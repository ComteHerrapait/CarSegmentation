%% Chargement de l'image
Img = imread('Images\001.jpg');
figure(1); imshow(Img, []); title('Image initiale');
figure(); histogram(Img);

% Seuillage de l'image
ImgBin = im2bw(Img, 91/255);
ImgBin = bwareaopen(ImgBin, 60);
%Img = rgb2gray(Img);
%ImgThresh = adaptthresh(Img);
%ImgBin = imbinarize(Img, ImgThresh);
figure(); 
subplot(131); imshow(ImgBin, []); title('Image seuillée');
ImgOpen = bwareaopen(ImgBin, 20);
subplot(132); imshow(ImgOpen, []); title('Image seuillée sans petits trucs');
s = strel('rectangle', [12,10]);
ImgClose = imclose(ImgOpen, s);
subplot(133); imshow(ImgClose, []); title('Image seuillée fermée');
ImgTrait = ImgClose;

%% Traitements
% Récupération de la largeur des objets
[fe, n] = bwlabel(ImgTrait);
Largeur = regionprops(fe, 'MinorAxisLength');
Longueur = regionprops(fe, 'MajorAxisLength');
a = [Largeur.MinorAxisLength];
% Récupération des objets avec une largeur inférieur à 100pix
idx = find(a<100);
ImgF = ismember(fe, idx);
% Calcul et affichage des BoundingBox
Contours = regionprops(ImgF, 'BoundingBox');
figure(3); imshow(Img, []); title('Image avec BoundingBox');
figure(3);
for k = 1 : length(Contours)
    thisBB = Contours(k).BoundingBox;
    rectangle('Position',[thisBB(1),thisBB(2),thisBB(3),thisBB(4)],'EdgeColor','b','LineWidth',5 );
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

