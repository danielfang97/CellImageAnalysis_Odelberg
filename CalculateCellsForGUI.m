function [startingIMG, overlapIMG, intensityLevel] = CalculateCellsForGUI(inputArray, threshold)

% IMGNameNCad = strcat(inputIMG,' 40X ZOOM2_0003 N-Cad.tif');
% IMGNameCD31 = strcat(inputIMG,' 40X ZOOM2_0003 CD31.tif');
% startingIMG = strcat(inputIMG, ' 40X ZOOM2_0003 Merge.tif');
% img1 = split(inputArray, "'    '");

startingIMG = inputArray{1,1}{1};

% addpath 'C:\Users\dfang\Documents\MATLAB\CalculateCells\New folder';

OriginalGreen = imread(inputArray{1,1}{2});
IMGgreen = rgb2gray(OriginalGreen);
IMGred = transformIMG(inputArray{1,1}{3}, threshold);
overlapIMG = IMGgreen;
overlapIMG(~IMGred) = 0;

greenPixels = sum(overlapIMG(:));
redPixels = 255*sum(IMGred(:));

intensityLevel = greenPixels/redPixels;
