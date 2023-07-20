%Close all figures and clear variables
close all
clear
    
%Set up the device reader
%fileName = 'myTwoChannelRecording.wav';
%deviceReader = audioDeviceReader('Driver', 'WASAPI', 'Device', 'Default','NumChannels', 2, 'SamplesPerFrame', 128);
%setup(deviceReader);
%fileWriter = dsp.AudioFileWriter(fileName)
%Record the audio
%recordDuration = 5;
%disp('Recording...')
%tic;
%while toc < recordDuration
%    acquiredAudio = deviceReader();
%    fileWriter(acquiredAudio);
%end
%disp('Recording complete.')
%Release system resources
%release(deviceReader);
%release(fileWriter);


recorder1 = audiorecorder(44100,16,1,3);
record(recorder1);
pause(3);
stop(recorder1);
play(gong);
%Read the audio file
fileName = 'D:\Temp\Audio\Right_Trimmed.wav';
[y, Fs] = audioread(fileName);

NFFT = length(y);
Y = fft(y,NFFT);
F = ((0:1/NFFT:1-1/NFFT)*Fs).';

%y = abs(y);
%Separate the audio into left and right channel
leftAudio = y(:,1);
rightAudio = y(:,2);
%Perform the cross-correlation and plot the result
subplot(4,1,1), plot (leftAudio);
subplot(4,1,2), plot (rightAudio);
Y = fft(leftAudio);
Z = fft(abs(rightAudio));
sample_delay = finddelay(leftAudio,rightAudio);
%subplot(4,1,3), plot (delay);
%disp(sample_delay);
time_delay = (sample_delay/Fs);
%disp(time_delay);
distance = time_delay * 340;
disp(distance*1000);
%[c,lags]=xcorr(leftAudio,rightAudio);  %do the cross-correlation
%[max_c,I]=max(x);  %find the best correlation
%delay = lags(I);  %here is the delay in samples
%disp(delay);
