%% Chargement de l'image
clc; clear all;
Img = imread('Images\001.jpg');
figure(1); 
subplot(221); imshow(Img, []); title('Image initiale');
subplot(223); histogram(Img); axis on; ylim([0, 10^5]);
Img = rgb2gray(Img);
subplot(222); imshow(Img, []); title('Niveau de gris');
subplot(224); histogram(Img); axis on; ylim([0, 10^5]);

%% Seuillage de l'image
Img2 = adapthisteq(Img);
ImgThresh = adaptthresh(Img2);
ImgBin = imbinarize(Img2, ImgThresh);
figure(); 
%subplot(121); 
imshow(ImgBin, []); title('Image seuillée');
%s = strel('square', 2);
%ImgClose = imopen(ImgBin, s);
%subplot(122); imshow(ImgClose, []); title('Image seuillée fermée');
%ImgTrait = ImgClose; % Fermeture non prise en compte

%% Traitements
% Récupération de la largeur des objets
[fe, n] = bwlabel(ImgBin);
Largeur = extractfield(regionprops(fe, 'MinorAxisLength')', 'MinorAxisLength');
Longueur = regionprops(fe, 'MajorAxisLength')';
a = [];
b = [];
for k = 1:length(Largeur)
    if (Largeur(k) > 10 && Longueur(k) > 1)
        a = [a, Largeur(k)];
        b = [b, Longueur(k)];
    end
end
% Récupération des objets avec une largeur inférieur à 100pix
idx = find(b > 2.2*a);
idx2 = find(b < 3*a);
idx3 = find(a > 5);
idx4 = find(b > 5);
ImgT = ismember(fe, idx);
ImgT2 = ismember(ImgT, idx2);
ImgT3 = ismember(ImgT2, idx3);
ImgF = ismember(ImgT3, idx4);
figure(); imshow(ImgF, []);
% Calcul et affichage des BoundingBox
Contours = regionprops(ImgF, 'BoundingBox');
figure(3); imshow(Img2, []); title('Image avec BoundingBox');
figure(3);
for k = 1 : length(Contours)
    thisBB = Contours(k).BoundingBox;
    rectangle('Position',[thisBB(1),thisBB(2),thisBB(3),thisBB(4)],'EdgeColor','b','LineWidth',3 );
end
%% Test couleur
length(Contours)
figure(4);
for k = 1 : length(Contours)
    thisBB = Contours(k).BoundingBox;
    y = floor(thisBB(1)/1);
    x = floor(thisBB(2)/1);
    w = thisBB(3);
    h = thisBB(4);
    img_cut = Img(x:x+h,y:y+w);
    subplot(4,4,k); imshow(img_cut, []); title(sprintf('Image %.0f', k));
    histogram(img_cut); title(sprintf('histogram %.0f', k));
end
%% Affichage
figure(); imshow(Img, []); title(sprintf('Il y a %.0f voitures', length(Contours)));

