clc
clear all

%% CONVERSION A VARIABLES F�SICAS: (Signal-base)/Gain



ppg=load('DATA_01_TYPE01.mat');
ppgSignal = ppg.sig;
pfinal = ppgSignal(2,(1:5000));
pfinal2= ppgSignal(3,(1:5000));
%Frecuencia de Muestreo
Fs = 125;
vmax = 0.6392;
vmin = -4.5176;
s1 = (pfinal-128)/255;
s1Norm = (s1-vmin)/(vmax-vmin);
s2 = (pfinal2-128)/255;
%s2 = (ppgSignal(2,:)+81)/161;
%s3 = (ppgSignal(3,:)+41)/81;

t = (0:length(pfinal)-1)/Fs;
figure(1)
plot(s1Norm), grid on
%axis([0 100000 -0.1 1 ])
%% HeartRate Detection alg using ECG Signals
% La se�al cuenta con 3.7 e 4 
% uncomment for octave under windows


h = fir1(1000,1/1000*2,'high');
%% filter out DC


h = fir1(1000,1/125*2,'high');

% filter out DC
figure(2)
y_filt=filter(h,1,s1Norm);
plot(y_filt);

% square it
detsq = y_filt .^ 2;
figure(3)
plot(detsq),grid on
% % thresholded output
 detthres = zeros(length(detsq),1);
% 
% % let's detect the momentary heart rate in beats per min
 last=0;
 upflag=0;
 pulse=zeros(length(detsq),1);
 p=0;
 
 for i = 1:length(detsq)
    if (detsq(i) > 0.06)
        if (upflag == 0)
            if (last > 0)
                t = i - last;
                p = 1000/t;
            end
            last = i;
        end
        upflag = 10;
    else
        if (upflag>0)
            upflag = upflag - 1;
        end
    end
    pulse(i)=p;
end
% 
% % plot it
figure(2)
plot (pulse);
aux = 1;
for j=1:length(pulse)-1
    if(pulse(j)~= pulse(j+1))
        aux = aux+1;
    end
end

%% TIPO 2 ACTIVIDADES M[AS INTENSAS
figure(3)

ppg=load('DATA_02_TYPE02.mat');
ppgSignal = ppg.sig;
pfinal = ppgSignal(5000:10000)
%Frecuencia de Muestreo
s2 = (pfinal(1,:)-128)/255;
s2Norm = (s2-vmin)/(vmax-vmin);
%s2 = (ppgSignal(2,:)+81)/161;
%s3 = (ppgSignal(3,:)+41)/81;

t = (0:length(ppgSignal)-1)/Fs;
plot(s2Norm), grid on
axis([0 100000 -0.1 1 ])
%% HeartRate Detection alg using ECG Signals
% La se�al cuenta con 3.7 e 4 
% uncomment for octave under windows

h = fir1(1000,100/1000*2,'high');
%% filter out DC


h = fir1(1000,1/125*2,'high');

% filter out DC
figure(4)
y_filt=filter(h,1,s2Norm);
plot(y_filt);

% square it
detsq = y_filt .^ 2;
figure(5)
plot(detsq),grid on
% % thresholded output
 detthres = zeros(length(detsq),1);
% 
% % let's detect the momentary heart rate in beats per min
 last=0;
 upflag=0;
 pulse=zeros(length(detsq),1);
 p=0;
 
 for i = 1:length(detsq)
    if (detsq(i) > 0.1)
        if (upflag == 0)
            if (last > 0)
                t = i - last;
                p = 1000/t;
            end
            last = i;
        end
        upflag = 10;
    else
        if (upflag>0)
            upflag = upflag - 1;
        end
    end
    pulse(i)=p;
end
% 
% % plot it
figure(6)
plot (pulse);
aux2 = 1;
for j=1:length(pulse)-1
    if(pulse(j)~= pulse(j+1))
        aux2 = aux2+1;
    end
end

