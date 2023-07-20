
for n = 1:1

    close all
    clear

    Fs = 200000;
    recorder1 = audiorecorder(Fs,16,2);
    record(recorder1);
    pause(0.5);
    stop(recorder1);
    %play(recorder1);

    stereo = getaudiodata(recorder1);

    leftAudio = stereo(:,1);
    rightAudio = stereo(:,2);
    %subplot(4,1,1), plot (leftAudio);
    %subplot(4,1,2), plot (rightAudio);

    leftAudio_FFT = fft(abs(leftAudio));
    rightAudio_FFT = fft(abs(rightAudio));
    %subplot(4,1,3), plot (leftAudio_FFT);
    %subplot(4,1,4), plot (rightAudio_FFT);

    %leftAudio_filtered = bandpass(leftAudio,[20 400],Fs)
    %rightAudio_filtered = bandpass(rightAudio,[20 400],Fs)




    sample_delay = finddelay(leftAudio,rightAudio);
    %subplot(4,1,3), plot (delay);
    %disp(sample_delay);
    time_delay = (sample_delay/Fs);

    %disp(count);
    %disp(time_delay);
    distance = time_delay * 4000;
    %disp(distance*1000);
    %result = sprintf("%f : Time Delay %f  :   Distance %f",count,time_delay,distance);
    result = sprintf("Time Delay %f  :   Distance %f",time_delay,distance);
    disp(result);
    
end