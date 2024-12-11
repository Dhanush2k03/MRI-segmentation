%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                   %
%           VISUALIZING,FILTERINIG AND SEGMENTING DICOM IMAGE       %
%                            PROJECT1                               %        
%                                                                   %
%-------------------------------------------------------------------%
%        first we visualize the dicom image using "imagesc"         %                                                   
%        we filter noise using different filters.                   %                 
%        then we segment the portion manually                       %                                     
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  

image = dicomread("Vida_Head.MR.Comp_DR-Gain_DR.1005.1.2021.04.27.14.20.13.818.14380335.dcm");

im = imagesc(image);
dicominfo("Vida_Head.MR.Comp_DR-Gain_DR.1005.1.2021.04.27.14.20.13.818.14380335.dcm");
%% IMAGE NORMALIZATION
min(image(:))
max(image(:))
mean(image(:))

inormal = mat2gray(image);
min(inormal(:))
max(inormal(:))
mean(inormal(:))

dicomimg = imagesc(inormal);
%% filtering
% Convert to grayscale if the image is not already grayscale
if size(image, 3) > 1
    grayscaleImage = rgb2gray(imag);
else
    grayscaleImage = image;
end
figure;
subplot(3, 2, 1);
imshow(inormal, []);
title('Original DICOM Image');
subplot(3, 2, 2);
imshow(grayscaleImage, []);
title('Grayscale Image');
%  Add Gaussian noise
noiseStrength = 0.5; % Adjust the strength of the noise as needed

noisyImage = imnoise(grayscaleImage, 'gaussian', 0, (noiseStrength/255)^2);
subplot(3, 2, 3);
imshow(noisyImage, []);
title('Noisy Image gaussian');

%filtering using gaussianfilter
filtimg = imgaussfilt(noisyImage,1.5);
subplot(3, 2, 4);
imshow(filtimg,[]);
title('gaussianfilter');

%filtering using median filter
filtimg2 = medfilt2(noisyImage,[3 3]);
subplot(3,2,5);
imshow(filtimg2,[]);
title('median filter');

%filterinng using Averaging filter
k = fspecial('average',[5 5]);
filtimg3 = imfilter(noisyImage,k);
subplot(3,2,6);
imshow(filtimg3,[]);
title('Averaging filter');

%% removal of skull portion/tumor from the image
figure;
subplot(1,2,1);
imshow(inormal,[]);
mask = roipoly();
subplot(1,2,2);
imshow(mask,[]);

inormal = inormal.*mask;
figure;
subplot(1,1,1);
imshow(inormal);



