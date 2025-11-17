% PHASE 1
function signal = phase1(inFile, outFile, sampleRate) 
    [y, Fs] = audioread(inFile); % y is the actual audio, Fs is sampling

    sizeOfY = size(y);
    
    if (sizeOfY(:,2) == 2)
        disp(inFile + " is stereo")
        y = y(:,1) + y(:,2); % if stereo, add columns to make mono
        disp(inFile + " is now mono")
    else
        disp(inFile + " is mono")
    end
    
    disp(inFile + " is " + Fs + " Hz")
    
    audiowrite(outFile, y, Fs)

    % downsampling
    signal = resample(y, sampleRate, Fs);
end