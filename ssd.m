% Match two strips to compute disparity values
clear;
clc;
%% Load images
left = imread('flowers-left.png');
right = imread('flowers-right.png');
figure, imshow(left);
figure, imshow(right);

%% Convert to grayscale, double, [0, 1] range for easier computation
left_gray = double(rgb2gray(left)) / 255.0;
right_gray = double(rgb2gray(right)) / 255.0;

%% Define strip row (y) and square block size (b)
y = 120;
b = 50;

%% Extract strip from left image
strip_left = left_gray(y : (y + b - 1), :);
figure, imshow(strip_left);

%% Extract strip from right image
strip_right = right_gray(y : (y + b - 1), :);
figure, imshow(strip_right);

%% Now match these two strips to compute disparity values
disparity = match_strips(strip_left, strip_right, b);
disp(disparity);
figure, plot(disparity);

