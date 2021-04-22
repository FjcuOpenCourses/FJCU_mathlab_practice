% Color-Based Segmentation Using the L*a*b* Color Space

%% Load image
fabric = imread('fabric.png');
figure(1), imshow(fabric), title('fabric');

%% Calculate sample colors in L*a*b* color space for each region

% To simplify this demo, load the region coordinates that are stored in a
% MAT-file.
load regioncoordinates;

% Identify the six colors in the image: background color, red, green,
% purple, yellow, and magenta. Use a mask to indetify the regions for each
% color.

nColors = 6;
sample_regions = false([size(fabric,1) size(fabric,2) nColors]);

for count = 1:nColors
  sample_regions(:,:,count) = roipoly(fabric,region_coordinates(:,1,count),...
                                      region_coordinates(:,2,count));
end

figure, imshow(sample_regions(:,:,2)), title('sample region for red');
% display all colors of the SAMPLE_REGIONS
% mask = sample_regions(:,:,1);
% for i=2:6
%     mask = mask+sample_regions(:,:,i);
% end
% color_regions(:,:,1) = fabric(:,:,1).*uint8(mask);
% color_regions(:,:,2) = fabric(:,:,2).*uint8(mask);
% color_regions(:,:,3) = fabric(:,:,3).*uint8(mask);
% figure, imshow(color_regions)

% Convert your fabric RGB image into an L*a*b* image using MAKECFORM and 
% APPLYCFORM. See help for more information on the use of thse two
% functions.
cform = makecform('srgb2lab');
lab_fabric = applycform(fabric,cform);

% Calculate the mean 'a*' and 'b*' value for each area that you extracted
% with roipoly. These values serve as your color markers in 'a*b*' space. 
a = lab_fabric(:,:,2);
b = lab_fabric(:,:,3);
color_markers = repmat(0, [nColors, 2]);

for count = 1:nColors
  color_markers(count,1) = mean2(a(sample_regions(:,:,count)));
  color_markers(count,2) = mean2(b(sample_regions(:,:,count)));
end

%% Classify each pixel using the nearest neighbor rule
% Create an array that contains your color labels, i.e., 0 = background, 1
% = red, 2 = green, 3 = purple, 4 = magenta, and 5 = yellow. 
color_labels = 0:nColors-1;

% Initialize matrices to be used in the nearest neighbor classification.
a = double(a);
b = double(b);
distance = repmat(0,[size(a), nColors]);

% Perform classification
for count = 1:nColors
  distance(:,:,count) = ( (a - color_markers(count,1)).^2 + ...
                      (b - color_markers(count,2)).^2 ).^0.5;
end

[value, label] = min(distance,[],3);
label = color_labels(label);
clear value distance;

%% Display results of nearest neighbor classification
% The label matrix contains a color label for each pixel in the fabric
% image. Use the label matrix to separate objects in the original fabric image by color. 
rgb_label = repmat(label,[1 1 3]);
segmented_images = repmat(uint8(0),[size(fabric), nColors]);

for count = 1:nColors
  color = fabric;
  color(rgb_label ~= color_labels(count)) = 0;
  segmented_images(:,:,:,count) = color;
end 

figure
subplot(3,2,1)
imshow(segmented_images(:,:,:,2)), title('red objects');
subplot(3,2,2)
imshow(segmented_images(:,:,:,3)), title('green objects');
subplot(3,2,3)
imshow(segmented_images(:,:,:,4)), title('purple objects');
subplot(3,2,4)
imshow(segmented_images(:,:,:,5)), title('magenta objects');
subplot(3,2,5)
imshow(segmented_images(:,:,:,6)), title('yellow objects');

% Combine segmented images as strips
% row_division = size(segmented_images,1)/5;
% segmented_strips = segmented_images(:,:,:,1);
% for count = 1:5
%     segmented_strips( ((count-1)*row_division)+1:count*row_division, :, :) = ...
%         segmented_images( ((count-1)*row_division)+1:count*row_division,:,:,count+1);
% end
% figure
% imshow(segmented_strips)