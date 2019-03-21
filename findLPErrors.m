
function [ErroresTotales] = findLPErrors(mediamuestral,Activity1,Activity2,Activity3,Activity4,Activity5,Activity6,...
    CleanedSignal1,CleanedSignal2,CleanedSignal3,CleanedSignal4,CleanedSignal5,CleanedSignal6,...
    Fs,MinPeakWidthRest1,MinPeakWidthRun_2,MinPeakWidthRun_3,MinPeakWidthRun_4,MinPeakWidthRun_5,MinPeakWidthRest6,...
    MaxWidthRest1,MaxWidthRun2,MaxWidthRun3,MaxWidthRun4,MaxWidthRun5,MaxWidthRest6,...
    ProminenceInRest,ProminenceRunning, ecgName,MinHeightECGRest1,MinHeightECGRest6,...
    MinHeightECGRun2,MinHeightECGRun3,MinHeightECGRun4,MinHeightECGRun5,minDistRest1,minDistRest6,...
    minDistRun2,minDistRun3,minDistRun4,minDistRun5,minDD)
% 1. ORIGINAL en reposo vs sin ruido
[PKS1Original,LOCS1Original] = GetLPCPeakPoints(Activity1,...
    Fs,MinPeakWidthRest1,MaxWidthRest1,ProminenceInRest,minDD);
[PKS1ruido,LOCS1ruido] = GetLPCPeakPoints(CleanedSignal1,Fs,MinPeakWidthRest1,MaxWidthRest1,ProminenceInRest,minDD);
% 2. CORRIENDO 1min se�al original vs sin ruido
[PKS2Original,LOCS2Original] = GetLPCPeakPoints(Activity2,...
    Fs,MinPeakWidthRun_2,MaxWidthRun2,ProminenceRunning,minDD);
[PKS2ruido,LOCS2ruido] = GetLPCPeakPoints(CleanedSignal2,Fs,MinPeakWidthRun_2,MaxWidthRun2,ProminenceRunning,minDD);
% 3. CORRIENDO 1min se�al original vs sin ruido
[PKS3Original,LOCS3Original] = GetLPCPeakPoints(Activity3,...
    Fs,MinPeakWidthRun_3,MaxWidthRun3,ProminenceRunning,minDD);
[PKS3ruido,LOCS3ruido] = GetLPCPeakPoints(CleanedSignal3,Fs,MinPeakWidthRun_3,MaxWidthRun3,ProminenceRunning,minDD);
% 4. CORRIENDO 1min se�al original vs sin ruido
[PKS4Original,LOCS4Original] = GetLPCPeakPoints(Activity4,...
    Fs,MinPeakWidthRun_4,MaxWidthRun4,ProminenceRunning,minDD);
[PKS4ruido,LOCS4ruido] = GetLPCPeakPoints(CleanedSignal4,Fs,MinPeakWidthRun_4,MaxWidthRun4,ProminenceRunning,minDD);
% 5. CORRIENDO 1min se�al original vs sin ruido
[PKS5Original,LOCS5Original] = GetLPCPeakPoints(Activity5,...
    Fs,MinPeakWidthRun_5,MaxWidthRun5,ProminenceRunning,minDD);
[PKS5ruido,LOCS5ruido] = GetLPCPeakPoints(CleanedSignal5,Fs,MinPeakWidthRun_5,MaxWidthRun5,ProminenceRunning,minDD);
% 6. REST 30s se�al original vs sin ruido
[PKS6Original,LOCS6Original] = GetLPCPeakPoints(Activity6,...
    Fs,MinPeakWidthRest6,MaxWidthRest6,ProminenceInRest,minDD);
[PKS6ruido,LOCS6ruido] = GetLPCPeakPoints(CleanedSignal6,Fs,MinPeakWidthRest6,MaxWidthRest6,ProminenceInRest,minDD);

%% Error using HeartBeats from findpeaks
ErrorFindP1 = 100*abs(length(LOCS1ruido)-length(LOCS1Original))./length(LOCS1Original);
ErrorFindP2 = 100*abs(length(LOCS2ruido)-length(LOCS2Original))./length(LOCS2Original);
ErrorFindP3 = 100*abs(length(LOCS3ruido)-length(LOCS3Original))./length(LOCS3Original);
ErrorFindP4 = 100*abs(length(LOCS4ruido)-length(LOCS4Original))./length(LOCS4Original);
ErrorFindP5 = 100*abs(length(LOCS5ruido)-length(LOCS5Original))./length(LOCS5Original);
ErrorFindP6 = 100*abs(length(LOCS6ruido)-length(LOCS6Original))./length(LOCS6Original);
ErrorFromFindPeaks = [ErrorFindP1 ErrorFindP2 ErrorFindP3 ErrorFindP4 ErrorFindP5 ErrorFindP6];
%% Error from BPM 
% bpm stores the bpm in the matrix 6x12, where 1-6 represents the type of
% activity and 1-12 represents the number of realizations. Since the bpm is
% taken from 8 windows size and is overlapping every 6s, there are 2
% effective seconds and therefore, the activity 1 (Rest per 30s)
% corresponds to 15 effective seconds
addpath('C:\MATLAB2018\MATLAB\mcode\Tesis\IEEE-Processing-Cup\competition_data\Training_data\Noiseproofs')
bpm = CompareBPM();
realizacion = 1;
% Separate peaks from findpeaks detection 
FindPeaks1 = length(LOCS1ruido);
FindPeaks2 = length(LOCS2ruido);
FindPeaks3 = length(LOCS3ruido);
FindPeaks4 = length(LOCS4ruido);
FindPeaks5 = length(LOCS5ruido);
FindPeaks6 = length(LOCS6ruido);
% For computational reasons, we separate the 30s-activities
bpm1 = bpm(1,realizacion)./2;
bpm6 = bpm(6,realizacion)./2;
%
EBPM1 = 100*abs(FindPeaks1-bpm1)./bpm1;
EBPM2 = 100*abs(FindPeaks2-bpm(2,realizacion))./bpm(2,realizacion);
EBPM3 = 100*abs(FindPeaks3-bpm(3,realizacion))./bpm(3,realizacion);
EBPM4 = 100*abs(FindPeaks4-bpm(4,realizacion))./bpm(4,realizacion);
EBPM5 = 100*abs(FindPeaks5-bpm(5,realizacion))./bpm(5,realizacion);
EBPM6 = 100*abs(FindPeaks6-bpm6)./bpm6;


ErrorFromBPM = [EBPM1 EBPM2 EBPM3 EBPM4 EBPM5 EBPM6];


%% PROOF 2: ECG peaks detection
% Random sample signal: 
ecg = load(char(ecgName));
ecgSig = ecg.sig;
ecgFullSignal = ecgSig(1,(1:length(mediamuestral)));% match sizes 
% Normalize with min-max method
ecgFullSignal = (ecgFullSignal-128)./255;
ecgFullSignal = (ecgFullSignal-min(ecgFullSignal))./(max(ecgFullSignal)-min(ecgFullSignal));
% Squared signal to 
ecgF = (abs(ecgFullSignal)).^2;
t = (0:length(ecgFullSignal)-1)/Fs;   

[ECG1Peaks,ECG1Locs] = GetECGPeakPoints(ecgF(1,(1:3750)),MinHeightECGRest1,minDistRest1);
[ECG2Peaks,ECG2Locs] = GetECGPeakPoints(ecgF(1,(3751:11250)),MinHeightECGRun2,minDistRun2);
[ECG3Peaks,ECG3Locs] = GetECGPeakPoints(ecgF(1,(11251:18750)),MinHeightECGRun3,minDistRun3);
[ECG4Peaks,ECG4Locs] = GetECGPeakPoints(ecgF(1,(18751:26250)),MinHeightECGRun4,minDistRun4);
[ECG5Peaks,ECG5Locs] = GetECGPeakPoints(ecgF(1,(26251:33750)),MinHeightECGRun5,minDistRun5);
[ECG6Peaks,ECG6Locs] = GetECGPeakPoints(ecgF(1,(33751:end)),MinHeightECGRest6,minDistRest6);

peaksECG1 = length(ECG1Locs);
peaksECG2 = length(ECG2Locs);
peaksECG3 = length(ECG3Locs);
peaksECG4 = length(ECG4Locs);
peaksECG5 = length(ECG5Locs);
peaksECG6 = length(ECG6Locs);

ECGERROR1 = 100*abs(FindPeaks1-peaksECG1)./peaksECG1;
ECGERROR2 = 100*abs(FindPeaks2-peaksECG2)./peaksECG2;
ECGERROR3 = 100*abs(FindPeaks3-peaksECG3)./peaksECG3;
ECGERROR4 = 100*abs(FindPeaks4-peaksECG4)./peaksECG4;
ECGERROR5 = 100*abs(FindPeaks5-peaksECG5)./peaksECG5;
ECGERROR6 = 100*abs(FindPeaks6-peaksECG6)./peaksECG6;
ErrorFromECG = [ECGERROR1 ECGERROR2 ECGERROR3 ECGERROR4 ECGERROR5 ECGERROR6];

FindPeaksOriginalPeaks = [length(LOCS1Original) length(LOCS2Original) length(LOCS3Original) length(LOCS4Original) length(LOCS5Original) length(LOCS6Original)]

FindPeakDenoisedPeaks = [length(PKS1ruido) length(PKS2ruido) length(PKS3ruido) length(PKS4ruido) length(PKS5ruido) length(PKS6ruido)] 

showBPMPeaks = [bpm1 bpm(2,realizacion) bpm(3,realizacion) bpm(4,realizacion) bpm(5,realizacion) bpm6]

showECGPeaks = [peaksECG1 peaksECG2 peaksECG3 peaksECG4 peaksECG5 peaksECG6  ]
disp('CALCULO % ERRORES: Fila 1 (FindPeaks), Fila 2 (BPM), Fila 3 (ECG)')
ErroresTotales = [ErrorFromFindPeaks;ErrorFromBPM;ErrorFromECG];

end