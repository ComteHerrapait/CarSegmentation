%% Chargement de l'image
Img = imread('Images\008.jpg');
figure(1); imshow(Img, []); title('Image initiale');
%Img = cartoon(Img);
Img = rgb2gray(Img);

%% Seuillage de l'image
Img2 = adapthisteq(Img);
ImgThresh = adaptthresh(Img2);
ImgBin = imbinarize(Img2, ImgThresh);
figure();
imshow(ImgBin, []);

%% Reconstruction
[fe, n] = bwlabel(ImgBin);
Marqueur = ImgBin;
figure();
for k=1:6
    s = strel('disk', 1);
    Marqueur = imerode(Marqueur, s);
    [fe, n] = bwlabel(Marqueur);
    imshow(Marqueur, []);
    pause(0.5);
end
ImgReconstruct = imreconstruct(Marqueur, ImgBin);
figure();
imshow(ImgReconstruct, []);