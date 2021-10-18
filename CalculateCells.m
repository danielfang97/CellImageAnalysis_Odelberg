%%
clc;

%%
NCad4522 = imread('4522-5 WT 40X ZOOM2_0003 N-Cad.tif');
%subplot(2,2,1); imshow(NCad4522);

figure(2);
NCad4522Grey = rgb2gray(NCad4522);
%subplot(2,2,1); 
imshow(NCad4522Grey);

NCad4522Binary = imbinarize(NCad4522Grey,0.1);
%subplot(2,2,3); imshow(NCad4522Binary);

%figure(2);
NCad4522Inverse = imcomplement(NCad4522Binary);
%subplot(2,2,1); imshow(NCad4522Inverse);

se90 = strel('line', 3, 90);
se0 = strel('line', 3, 0);
NCad4522Dilate = imdilate(NCad4522Inverse, [se90 se0]);
%subplot(2,2,2); imshow(NCad4522Dilate);

NCad4522Fill = imfill(imcomplement(NCad4522Dilate), 'holes');
NCad4522Fill = imfill(NCad4522Fill, 'holes');
%subplot(2,2,3); imshow(NCad4522Fill);

figure(3);

subplot(1,2,1); imshow(NCad4522);
subplot(1,2,2); imshow(NCad4522Fill);

totalPixels = numel(NCad4522Fill);
whitePixels = sum(NCad4522Fill(:));
greenArea = whitePixels/totalPixels;
fprintf("Percent of image that is green: %f%% \n", greenArea*100);

%%

CD314522 = imread('4522-5 WT 40X ZOOM2_0003 CD31.tif');
%figure(4);
%subplot(2,2,1); imshow(CD314522);

CD314522Grey = rgb2gray(CD314522);
%subplot(2,2,2); imshow(CD314522);

CD314522Binary = imbinarize(CD314522Grey,0.1);
%subplot(2,2,3); imshow(CD314522Binary);

%figure(5);
CD314522Inverse = imcomplement(CD314522Binary);
%subplot(2,2,1); imshow(CD314522Inverse);

se90 = strel('line', 3, 90);
se0 = strel('line', 3, 0);
CD314522Dilate = imdilate(CD314522Inverse, [se90 se0]);
%subplot(2,2,2); imshow(CD314522Dilate);

CD314522Fill = imfill(imcomplement(CD314522Dilate), 'holes');
CD314522Fill = imfill(CD314522Fill, 'holes');
%subplot(2,2,3); imshow(CD314522Fill);

figure(6);

subplot(1,2,1); imshow(CD314522);
subplot(1,2,2); imshow(CD314522Fill);

totalPixels = numel(CD314522Fill);
whitePixels = sum(CD314522Fill(:));
redArea = whitePixels/totalPixels;
fprintf("Percent of image that is red: %f%% \n", redArea*100);

%%

overlap = NCad4522Fill & CD314522Fill;
figure(7);
imshow(overlap);

totalPixels = numel(overlap);
whitePixels = sum(overlap(:));
overlapArea = whitePixels/totalPixels;
fprintf("Percent of image that is both red and green: %f%% \n", overlapArea*100);

percentOfGreenThatIsRed = overlapArea/greenArea;
percentOfRedThatIsGreen = overlapArea/redArea;

fprintf("Percent of green image that overlaps with red: %f%% \n", percentOfGreenThatIsRed*100);
fprintf("Percent of red image that overlaps with green: %f%% \n", percentOfRedThatIsGreen*100);

