% Input Image
Im=imread('university.tif');
A = Im;
Lo = 256; % hist level     
%KERNEL SIZE: Sliding window
W=10;
L=15;

% Zero padding
%1. Find the number of rows and column to be padded
mid=round((W*L)/2);
l=0; % counter
for i=1:W
    for j=1:L
        l=l+1;
        if(mid==l)
            PadW=i-1;
            PadL=j-1;
            break;
        end
    end
end
Bo=padarray(A,[PadW,PadL]);

for i= 1:size(Bo,1)-((PadW*2)+1)    
    for j=1:size(Bo,2)-((PadL*2)+1)
        HIST=zeros(Lo,1); % contain the histogram
        nn=1; % counter
        for k=1:W
            for l=1:L
                % find the value in the middle of the kernel          
                if(nn==mid)
                    gr=Bo(i+k-1,j+l-1)+1;
                end
                pos=Bo(i+k-1,j+l-1)+1;
                HIST(pos)=HIST(pos)+1;
                nn=nn+1;
            end
        end
                      
        % calculate the HIST in the kernel
        for m=2:Lo
            HIST(m)=HIST(m)+HIST(m-1);
        end
        Im(i,j)=round(HIST(gr)/(W*L)*255);
     end
end
% Display the image along with both the old and new histogram
figure,imshow(Im)
figure
subplot(2,1,1); imhist(A);title('Initial Histogram');
subplot(2,1,2); imhist(Im);title('Reconstructed Image with Histogram Equalization');