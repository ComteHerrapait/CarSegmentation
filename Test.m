%% Chargement de l'image
clear all, clc, close all;
Img = imread('Images\001.jpg');
ImgGray = rgb2gray(Img);
ImgGray2 = ImgGray<50;
ImgGray2 = bwareaopen(ImgGray2,10);
ImgGrad = edge(ImgGray,'canny');
ImgGrad2 = imfill(ImgGrad, 'holes');
ImgGrad3 = imreconstruct(ImgGray2, ImgGrad);
ImgGrad3 = imclose(ImgGrad3, strel('disk', 2));
ImgGrad3 = imfill(ImgGrad3, 'holes');
ImgGrad3 = imopen(ImgGrad3, strel('disk', 1));
figure(); imshow(ImgGray2, []);
figure(); imshow(ImgGrad, []);
figure(); imshow(ImgGrad2, []);
figure(); imshow(ImgGrad3, []);












%%
ImgGrayStd = stdfilt(ImgGray, ones(5));
figure(); imshow(ImgGray<50, []);
moy = mean(ImgGrayStd(:))
figure(); imshow(ImgGrayStd>19,[]);
ImgFill = imfill(ImgGrayStd>5, 'hole');
figure(); imshow(ImgFill,[]);
imgFill2 = imerode(ImgFill, strel('disk', 5));
Longueur = regionprops(imgFill2, 'MajorAxisLength');
Largeur = regionprops(imgFill2, 'MinorAxisLength');
figure(); imshow(imgFill2,[]);
nbVoiture = 0;
for k = 1:length(Longueur)
    longueur = Longueur(k).MajorAxisLength;
    largeur = Largeur(k).MinorAxisLength;
    if (longueur>largeur*2 && longueur<largeur*3 && longueur>10)
        nbVoiture = nbVoiture + 1;
    end
end
    