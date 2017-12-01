function S = p2nd_der(S,Tb,Ta);
% Calcualte the 2nd derivative of the input signal

n = length(S);

S(Tb+1:n-Ta) = 2*S(Tb+1:n-Ta)-S(1:n-Tb-Ta) - S(Tb+Ta+1:n);




