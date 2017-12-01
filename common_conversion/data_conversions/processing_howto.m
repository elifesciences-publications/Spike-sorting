a desciption of the sorting process.

When the prerocessing is complete, you have to:

Import an XML file that will descirbe the appropariate number of channels, the number of samples per waveform and the
sample of the peak into the directory which contains the data (i.e. group1, group2, etc ...)
    
you can then open the approparite FET file woth Klusters and start the manual monitoring of the classification. 

To add the continuous data file to Klusters - trace view (so you can view them in the Klusters display) - 
do the following:
1. Generate data (.dat) files in each block using the call-mat2buz script. You will need to set the date and session
info and specify the blocks and shanks you wish to process. Take the minimum number of blocks required. The blocks
need top be continuous and start at the beginning, so a good coice is blocks 1 and 2. You may want to convert more though
for later use in neuroscope.
2. Combine the data file across blocks. This is done with the "combine dat files" option from call_proces./
note that you have to set thespecific block numbers and the group to process. Only one group is process
at a time for this function. Tge generated file name will reflect the name of the contributing blocks, 
but you will need to rename it to correspond with the other files in the same group directory, for example:
from group_1_combined_1_2.dat to combined1.dat.

To classify:
Step 1: Take a look through of the detected spikes as they appear in the trace display.
Step 2: remove all artifacts to class 0 (although artifacts are removed based on size some lowe ramplitude ones
still remain - they still are larger than typical waveforms).
Step 3: Remove all noise to class 1 - noise are defined as signals that are too low
to be separated, but by definition, are above threshold.
Step 4: at this stage, it is useful to renumber the clausters according to their amplitudes. 
this is accomplished with the function: reorder by amplitude in the post processing module that is called from
call process. Then, load the data file using neuroscope again - it shouod be easier to make sense of who is against
who. 
this procedure is useful to do severakl times while sorting. 


Once done with the classification, call the combine_and_reformat_clusters script from call_process. This reads the 
classified spikes and their times and arranges them into a matlab file that can be used for subsequent processing.










Sorting log:

1. 17nov07 - 
done several weeks ago, and on 1/5/07 looked at the data for the first time, similar to the
unsorted data, though less smoothm suggestng that what matters in some of those traces is the RMS signal.

2. 18jan07 - 
started on 03may07
group 1: 8 non noise classes - complted on 03may07.
group 2: 9 non noise classes - completed on 03may07
group 3: 6 non noise classes - completed on 03may07
group 4: 8 non noise classes - completed on 04may07

so, over all it is feasible to sort a day in a day.


3. 11jan07 - 
started on 09may07
group1: 4 non noise classes completed on 09may07. A poor group, only one spike is really distinguishable.
group2: 13 non noise groups. Some have similar spike averages and trace displays. However, clusters are 
        distinct (a good example of separation for a figure). i was able to "peel apart all clusters from 
        each other sequentially". There is clearly soe mixing between the noise clusters and themselves and
        between their respective groups.
group3: 15 non noise clusters (!!!). after much merging and these are "peelable" sequentially. 
group4: 16 non noise custers - but again, these are clearly differentiable on a cluster basis.
completed on 11may07. Also a nice example to show cluster separation.

4. 29feb07 (i know, there is no such date, it is really the 01 of march, but this is how i named it)
started on 11may07
group1: 3 non noise clusters (11may07)
group2: 8 non noise clusters (14may07) - many of the classes here are mixtures of more than a single spike,
                                         but they are not really separable.
group3: 8 non noise clusters (15may07) - 3301 is a mixture and overlaps with both 3302 and 3401. It is hard to 
                                         separate it further and so I leave it this way.
                                         3402 ends kind of abruptly, and might merge into 3401.
                                         
group4: 9 non noise clusters.
        4202 end abruptly and at the same time, 4301 gains much, and so do 4401 and 4501, but ACCORDING
        to the shapes there cannot be a mixup.
        4402, 4501 and 4502 similar in Pc projections, but they do differ in their spike shapes sufficiently.
        
        noise channels seem well correlated on a rough scale.
completed on 15may07 - a lot of stuff that cannot be well separated - esp on shank 4.
        
                                         
5. 19jan07 (started on 17may07)
group 1: 5 non noise clusters. 
1402 and 1401 definitely overlap, 1402 has very strange behavior over time, and it seems like two
distinct spikes that diverge and converge in the time doman - this is something that can almost
not be separated.
A similar situation exists with respect to 1601 and 1602 - but I do not think that there is some 
"cross talk" across these channels. it is interesting to understand what this pheonmenon is about 
and to examine it in the other probes.
group 2: almost done on 18may07, but still need to make a final pass - so check and finish.
2 non noise clusters - yes, i was quite conservative here. 
2301 is deifnitely one of these temporally varying classes, (lookit 5 vs 17) and it is most likely more than a single,
but very hard to separate.
2401 is pretty good, but extremely sprase, interesting to see what it is respontive to.
group 3: 4 non noise clusters. 3401 and 3402 are overlapping. iniitially i had spikes on elecs
5 and 6, but since they were so similar to the respecive noise class, i went a step back and called them noise -
this implies that 3500 and 3600 are not that bad.
group 4: 5 non noise clusters. Spikes pretty well separated. 4602 shows considerable drift and therefore the PC cloud
is large, but looking at its amplitude through time shows it is cleary the same spike. Some of the noise
classes are not so bad.

completed on 23may07


6. 10apr07 (started on 23may07)
group 1:
There were initially many clusters that had their maxima on channel one, some differed in their amplitude on
this chanel and some differed by having non zero amplitudes on other channels. what I did was to merge them all, 
throw away the very small signals. Although this mix includes two subpopulations that have spikes on these lower
channels simultaneously, they are a minority and moreover, these spikes are not well defined themseleves, so this
will just introduce unnecessary complexity.
Only three non noise clusters - this was a very depressing group, because thre were many pretty good but 
non sperable signals. Therefore, the activity on some of the noise channels is not so bad. 





        
        












