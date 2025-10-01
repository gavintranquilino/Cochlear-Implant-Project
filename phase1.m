function out = downsamp(InSignal, ratio)
    InLength = size(InSignal);
    InLength = InLength(:,1);

    out = [0:1:InLength/ratio-1];

    for index = 1:InLength/ratio
        out(index) = InSignal(round(index*ratio)-1);
    end
end

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

    multiplier = Fs / sampleRate;

    signal = downsamp(y, multiplier)

    sound(signal, sampleRate);

    % plotting 

    subplot(1, 2, 1)
    plot(y, "r");
    title("raw");

    subplot(1, 2, 2);
    plot(signal);
    title("downsampled");

end

inputFile = "track2.mp3";
outputFile = "track2-mono.mp3";

signal = file2Signal(inputFile, outputFile, 16000);
