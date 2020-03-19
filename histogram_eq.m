function [histo,histe,I,Io] = histogram_eq(I,L)
%% Helper
% imname = image path
% L      = number of all possible gray values : ex = 256


% Read Image and convert to gray
%I = imread(imname);
if length(size(I))>2
    I = rgb2gray(I);
end
figure(1);
imshow(I);

% input image information
input_size  = size(I); 
input_table = unique(I); % all existing gray values of image I
Lo = length(input_table);% number of existing gray values

% construct histogram
histo = zeros(1,L); 
imarray = I(:);
n = 0;
for i = 1 : Lo
    % update histogram for every value found in the input table
    idx      = input_table(i)+1;
    temp     = find(imarray == input_table(i));
    dis      = length(temp);
    n        = n + dis; 
    histo(idx) = dis; 
    accum(i) = n;   % accumulative gray level pixels
end
figure(2);
plot(histo);
xlim([1,L]);
title(['Initial Histogram']);


% perform histogram equalization
const = (L-1)/n; % a constant = (L-1)/ total num of pixels
output_table = [];
for k = 1 : Lo
    % update the output table which contain the mapped input values
    nk = accum(k);
    output_table(k) = floor(const*nk);
end

% reconstruct the image
Io = I;
for k = 1 : Lo
    [ro,co]   = find(I == input_table(k));
    for jj = 1 : length(ro)
        Io(ro(jj),co(jj)) = output_table(k);
    end    
end
figure(3);
imshow((Io));
title('Reconstructed Image with Histogram Equalization');

% recompute the histogram after histogram equalization
new_table = unique(Io);
histe = zeros(1,L);
imarray = I(:);
n = 0;
for i = 1 : length(new_table)
    % update histogram for every value found in the new table
    idx      = new_table(i)+1;
    temp     = find(imarray == new_table(i)); 
    histe(idx) = length(temp); 
end
figure(4);
plot(histe);
xlim([1,L]);
title(['New Histogram After Histogram Equalization']);
