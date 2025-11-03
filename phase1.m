function signal = file2Signal(inFile, outFile, sampleRate) 
    [y, Fs] = audioread(inFile); % y is the actual audio, Fs is sampling 

    sizeOfY = size(y);
    
    if (sizeOfY(:,2) == 2)
        disp(inFile + " is stereo")
        y = y(:,1) + y(:,2); % if stereo, add columns to make mono
    else
        disp(inFile + " is mono")
    end
    
    disp(inFile + " is " + Fs + " Hz")
    
    audiowrite(outFile, y, Fs)

    % downsampling 

    signal = resample(y, sampleRate, Fs);

    % start phase 2 
    N = 8;
    f_low = 100;
    f_high = 8000;
    
    band_edges = logspace(log10(f_low), log10(f_high), N+1)

    %{
    % plotting 

    subplot(1, 2, 1); plot(signal);
    title("Downsampled Input Audio");

    % make cosine
    n = [0 : 1 : sizeOfY(:,1)];
    cosine = cos((2 * pi * 1000) .* (n ./ Fs));

    subplot(1, 2, 2);
    plot(cosine);
    xlim([0,2*Fs/1000]);
    title("Cosine Wave");

    % audio
    player = audioplayer(signal, sampleRate);
    playblocking(player);
    
    sound(cosine, Fs);
    %}

end

inputFile = "track2.mp3";
outputFile = "track2-mono.mp3";

signal = file2Signal(inputFile, outputFile, 16000);