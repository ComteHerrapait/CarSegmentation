%% Init
clear all, clc, close all;
Img = imread('Images\001.jpg');
%% binarization
IGray = rgb2gray(Img);
ICartoon = cartoon(IGray);
IBinary = ICartoon<50;
IBinary = bwareaopen(IBinary,10);%%removes small shapes

%% Rough shape of cars
IEdge = edge(ICartoon,'canny');
IFill = imdilate(IEdge,strel('disk',3));
IFill = imfill(IFill, 'holes');
IReconstruct = imreconstruct(IBinary, IEdge);

%% Adaptative closing

orientations = regionprops(IReconstruct, 'Orientation');
axisLength = regionprops(IReconstruct, 'MajorAxisLength');

deg = median([orientations.Orientation])
len = median([axisLength.MajorAxisLength])

IReconstruct2 = imclose(IReconstruct, strel('line',len/6,deg));

%%
IReconstruct3 = imclose(IReconstruct2, strel('disk',fix(len/15) ));%rapproche
IReconstruct3 = imfill(IReconstruct3, 'holes');
IReconstruct3 = imopen(IReconstruct3, strel('disk', fix(len/30) ));%sépare


%% affichage
figure(1); imshow(IBinary, []);title('image binaire')
figure(2); imshow(IEdge, []);title('image bordures')
figure(3); imshow(IFill, []);title('image remplie')
figure(4); imshow(IReconstruct, []);title('image reconstruite')
figure(5); imshow(IReconstruct2, []);title('image fermeture adaptative')
figure(6); imshow(IReconstruct3, []);title('image finale')
