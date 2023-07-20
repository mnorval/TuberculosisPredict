close all
clear

Fs = 200000;
recorder1 = audiorecorder(Fs,16,2);
record(recorder1);
pause(1);
stop(recorder1);
play(recorder1);

stereo = getaudiodata(recorder1);

Fs = 1000;            % Sampling frequency                    
T = 1/Fs;             % Sampling period       
L = length(stereo);             % Length of signal
t = (0:L-1)*T;        % Time vector
f = Fs*(0:(L/2))/L;

leftAudio = stereo(:,1);
rightAudio = stereo(:,2);
subplot(4,1,1), plot (leftAudio);
subplot(4,1,2), plot (rightAudio);

leftAudio_FFT = fft(abs(leftAudio));
rightAudio_FFT = fft(abs(rightAudio));

P12 = abs(leftAudio/L);
P11 = P12(1:L/2+1);
P11(2:end-1) = 2*P11(2:end-1);
subplot(4,1,3), plot(f,P11); 

P22 = abs(rightAudio/L);
P21 = P22(1:L/2+1);
P21(2:end-1) = 2*P21(2:end-1);
subplot(4,1,4), plot(f,P21);


%subplot(4,1,3), plot (leftAudio_FFT);
%subplot(4,1,4), plot (rightAudio_FFT);

