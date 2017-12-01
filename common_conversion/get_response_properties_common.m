function [Sa,Sb,Modulation,Power,PeakRate,MinRate,RespStart,PeakTime,MinTime,FiftyPercentTime,NinetyPercentTime,IsResponse] = get_response_properties_common(binned_spike_times,beforeS,stim_startS,afterS,resp_endS,BinSize);

% Same as get_response_properties_V2, but given a different name in case we
% make changes
% the only difference is that here the before and after params can vary depending on the cut.
%
%
% Return parameters regarding describing the responses.
% The structure of each parameter reflecs the structure of the binned_spike_times variable, organized into trials, cuts and units.
% Sb: baseline rate before the stimulation
% Sa: baseline rate after the stimulation (starting with the end of stimulation time)
% Modulation is just the difference of these two
% PeakRate is the peak rate after the stimulation
% Power is similar to the modulation, but calculated for the half time rather than the entire 30 seconds.
% PeakTime, HalfTime and NinetPercentTime are the times (measured
% from START of stimulation) of the peak, one third the number of spikes,
% one half, and two thirds, respectively.

% for plotting the results graphically
DEBUG_MODE = 0;

% These values were used after the 12 of december 07 - requirement for longer responses but no
% safety factors
ThreshS = 5; % minimal length of posiresponse in seconds
ThreshN = ceil(ThreshS/BinSize); % minimal length of response in samples
MaxStartTime = 10; % This is the value in seconds


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

N_trials = length(binned_spike_times);
N_cuts = length(binned_spike_times{1});
N_units = length(binned_spike_times{1}{1});




% A response is defined for each unit for cut and of course for each trial
for ui = 1:N_units
    resps = [];
    for ci = 1:N_cuts

        stim_dur = (afterS(ci) - stim_startS(ci)) * BinSize;

        for ti = 1:N_trials
            % So, here we divide by the bin size, DO NOT DO IT AGAIN !!!
            resps = binned_spike_times{ti}{ci}{ui}/BinSize;
            if isempty(resps)
                [PeakRate{ti}{ci}{ui} ] = 'nan';
                [MinRate{ti}{ci}{ui} ]   = 'nan';
                PeakTime{ti}{ci}{ui} = 'nan';
                MinTime{ti}{ci}{ui}  = 'nan';
                FiftyPercentTime{ti}{ci}{ui} = 'nan';
                NinetyPercentTime{ti}{ci}{ui} = 'nan';
                Sb{ti}{ci}{ui} = 'nan';
                Sa{ti}{ci}{ui} = 'nan';
                Sc{ti}{ci}{ui} = 'nan';
                Modulation{ti}{ci}{ui} = 'nan';
                Power{ti}{ci}{ui}      = 'nan';
                IsResponse{ti}{ci}{ui} = 'nan';
                RespStart{ti}{ci}{ui} = 'nan';
            else

                mX = max(resps);
                cR = cumsum(resps(afterS(ci):resp_endS(ci)));
                % Relevant for plotting purposes only
                if max(cR)
                    cR = cR * mX /max(cR);
                end
                [PeakRate{ti}{ci}{ui} PeakLoc] = max(resps(afterS(ci):resp_endS(ci)));
                [MinRate{ti}{ci}{ui} MinLoc]   = min(resps(afterS(ci):resp_endS(ci)));

                HalfPoint = min(find(cR > 0.5*max(cR)));
                NinetyPercentPoint = min(find(cR > 0.9*max(cR)));

                if isempty(HalfPoint)
                    HalfPoint     = nan;
                    NinetyPercentPoint = nan;
                end

                PeakTime{ti}{ci}{ui} = (PeakLoc+afterS(ci)-stim_startS(ci))*BinSize;
                MinTime{ti}{ci}{ui}  = (MinLoc+afterS(ci)-stim_startS(ci))*BinSize;
                FiftyPercentTime{ti}{ci}{ui} = (afterS(ci)-stim_startS(ci)+HalfPoint)*BinSize;
                NinetyPercentTime{ti}{ci}{ui} = (afterS(ci)-stim_startS(ci)+NinetyPercentPoint)*BinSize;


                % Calcualte the response magnitude
                Sb{ti}{ci}{ui} = sum(resps(1:beforeS(ci)))/length(1:beforeS(ci));
                Sa{ti}{ci}{ui} = sum(resps(afterS(ci):resp_endS(ci)))/length(afterS(ci):resp_endS(ci));

                % this is the rate after, only for the period until 50% time is reached, so essentially it is the power of the response
                Ft = HalfPoint + afterS(ci);
                if ~isnan(Ft)
                    Sc{ti}{ci}{ui} = sum(resps(afterS(ci):Ft))/length(afterS(ci):Ft);
                else
                    Sc{ti}{ci}{ui} = 0;
                end

                % I siubtract the baseline form the mean rate
                % PeakRate{ti}{ci}{ui}   = PeakRate{ti}{ci}{ui} - Sb{ti}{ci}{ui};
                Modulation{ti}{ci}{ui} = Sa{ti}{ci}{ui} - Sb{ti}{ci}{ui};
                Power{ti}{ci}{ui}      = Sc{ti}{ci}{ui} - Sb{ti}{ci}{ui};

                % Determine the response threshold
                MAXBefore = max(resps(1:beforeS(ci)));
                MINBefore = min(resps(1:beforeS(ci)));

                [down_SL,up_SL,up_start,down_start] = get_response_segment_lengths(resps(afterS(ci):resp_endS(ci)),MAXBefore,MINBefore);

                up_start = up_start*BinSize + stim_dur;
                down_start = down_start*BinSize + stim_dur;

                % go over all segments and take the first one that is good
                NEG_RESP = 0;
                for rsi = 1:length(down_SL)
                    if down_SL(rsi) > ThreshN  & (down_start(rsi) <= MaxStartTime)
                        NEG_RESP = 1;
                        take_down_SL = down_SL(rsi);
                        take_down_start = down_start(rsi);
                        break
                    end
                end
                POS_RESP = 0;
                for rsi = 1:length(up_SL)
                    if  up_SL(rsi) > ThreshN & up_start(rsi) <= MaxStartTime
                        POS_RESP = 1;
                        take_up_SL = up_SL(rsi);
                        take_up_start = up_start(rsi);
                        break
                    end
                end

                if POS_RESP & ~NEG_RESP
                    IsResponse{ti}{ci}{ui} = 1;
                    RespStart{ti}{ci}{ui} = take_up_start;
                elseif ~POS_RESP & NEG_RESP
                    IsResponse{ti}{ci}{ui} = -1;
                    RespStart{ti}{ci}{ui} = take_down_start;
                elseif ~POS_RESP & ~NEG_RESP
                    IsResponse{ti}{ci}{ui} = 0;
                    RespStart{ti}{ci}{ui} = nan;
                elseif POS_RESP & NEG_RESP
                    IsResponse{ti}{ci}{ui} = 2;
                    RespStart{ti}{ci}{ui} = (min(take_down_start,take_up_start));
                end

                if DEBUG_MODE
                    if  IsResponse{ti}{ci}{ui} == 1
                        disp(['start ' num2str(RespStart{ti}{ci}{ui}) ' peak: ' num2str(PeakTime{ti}{ci}{ui})])
                    end
                    tstring = ['Sb: ' num2str(Sb{ti}{ci}{ui}) ' Sa: ' num2str(Sa{ti}{ci}{ui}) ' Resp: ' num2str(Modulation{ti}{ci}{ui}) ' PeakTime: ' num2str(PeakTime{ti}{ci}{ui}) ' 50% ' num2str(FiftyPercentTime{ti}{ci}{ui}) '90%: ' num2str(NinetyPercentTime{ti}{ci}{ui})]
                    tstring = [' Resp: ' num2str(IsResponse{ti}{ci}{ui}) ' mag: ' num2str(Modulation{ti}{ci}{ui}) ' PeakTime: ' num2str(PeakTime{ti}{ci}{ui}) ]
                    close
                    figure
                    set(gcf,'position',[ 32   485   769   511])
                    ph = plot(resps)
                    switch IsResponse{ti}{ci}{ui}
                        case 1
                            set(ph,'color','r','linewidth',2)
                        case -1
                            set(ph,'color','g','linewidth',2)
                        case 0
                            set(ph,'color','b','linewidth',2)
                        otherwise
                            set(ph,'color','k','linewidth',1)
                    end
                    hold on
                    title(tstring)
                    plot([afterS(ci):resp_endS(ci)],cR,'g')
                    lh = line([beforeS(ci) beforeS(ci)],[0 mX+1]); set(lh,'color','k','linewidth',2);
                    lh = line([afterS(ci)   afterS(ci)],[0 mX+1]); set(lh,'color','k','linewidth',2);
                    lh = line(afterS(ci) - 1 + [PeakLoc    PeakLoc],[0 mX+1]); set(lh,'color','r','linewidth',2);
                    lh = line(afterS(ci) - 1 + [HalfPoint HalfPoint],[0 mX+1]); set(lh,'color','y','linewidth',2);
                    lh = line([1 beforeS(ci)],[Sb{ti}{ci}{ui} Sb{ti}{ci}{ui}]); set(lh,'color','k','linewidth',2);
                    lh = line([afterS(ci) resp_endS(ci)],[Sa{ti}{ci}{ui} Sa{ti}{ci}{ui}]); set(lh,'color','k','linewidth',2);
                end
            end
        end
    end
end




return