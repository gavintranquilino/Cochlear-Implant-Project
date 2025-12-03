

% PHASE 2
function [bands, band_edges] = phase2(inSignal, filterType, filterName, lowFreq, highFreq, overlap_factor, numBands, sampleRate)

    % Task 4: exponentially space the edges of each band's channel
    band_edges = logspace(log10(lowFreq), log10(highFreq), numBands+1); % logarithmically spaced bands
    % band_edges = linspace(lowFreq, highFreq, numBands+1); % linearly spaced bands

    % Task 5: apply the filter 
    bands = zeros(size(inSignal, 1), numBands);
    for i = 1:1:numBands
        
        % Apply overlap/gap factor; overlap_factor > 0 means overlap / < 1 means gap of overlap_factor*2 * current channel bandwidth
        m = (band_edges(i+1) - band_edges(i)) * overlap_factor;
        if i > 1
            band_edges(i) = band_edges(i) - m;
        end
        if i + 1 < numBands
            band_edges(i+1) = band_edges(i+1) + m;
        end

        % Apply bandpass filter specified as function argument
        currentFilter = filterType(10, band_edges(i), band_edges(i+1), sampleRate, 1, 100);
        bands(:, i) = filter(currentFilter, inSignal);
    end

    
    % figure("Name", strcat("Lowest and Highest Frequency Bands for ", filterName, " Filter"))
    % % Task 6: Plot lowest and highest frequency channels
    % subplot(2, 2, 1); plot(bands(:, 1));
    % title("Lowest Frequency Channel");
    % subplot(2, 2, 2); plot(bands(:, numBands));
    % title("Highest Frequency Channel");

    % Task 7
    bands = abs(bands);
    
    % Task 8
    [b, a] = butter(5, 400/(sampleRate/2));
    for i = 1:1:numBands
        % disp(i)
        bands(:, i) = filter(b, a, bands(:, i));
    end

    % Task 9: plot lowest and highest frequency channels
    % subplot(2, 2, 3); plot(bands(:, 1));
    % title("Lowest Frequency Channel Envelope");
    % subplot(2, 2, 4); plot(bands(:, end));
    % title("Highest Frequency Channel Envelope");

    % sgtitle(strcat("Lowest and Highest Frequency Bands for ", filterName, " Filter"))

    % Testing filter output by summing up post-envelop-detection/filtered signals together
    % new_bands = bands(:, 2) + bands(:, 3) + bands(:, 4) + bands(:, 5) + bands(:, 6) + bands(:, 7);
    % new_bands = sum(bands, 2);
    % new_bands = new_bands .* 5;
    % hold off;

    % plot(new_bands);
    % player = audioplayer(bands(:, end), sampleRate);
    % playblocking(player);
end