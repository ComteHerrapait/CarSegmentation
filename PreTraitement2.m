function [ ImgBin, nbVoit, contoursVoit, IFill] = PreTraitement2( Istart, showSteps )
% * Fonction de pre-traitement de l'image
% * Prend une image uint8 en entrée et renvoie une image binarise
% * Peut permettre de trouver le nombre de voiture

%% binarization
IGray = rgb2gray(Istart);
%IGray = medfilt2(IGray);
ICartoon = cartoon(IGray);
IBinary = ICartoon<0.10;
IBinary = bwareaopen(IBinary,10);%%removes small shapes

%% Rough shape of cars
IEdge = edge(ICartoon,'canny');
IFill = imdilate(IEdge,strel('disk',3));
IFill = imfill(IFill, 'holes');
IReconstruct = imreconstruct(IBinary, IEdge);
ImgBin = IReconstruct;

Longueur = regionprops(IFill, 'MajorAxisLength');
med = median([Longueur.MajorAxisLength]);

Contours = regionprops(IFill, 'BoundingBox'); % Contours des objets de l'image
nbVoit = 0;
contoursVoit = [];
for k=1:length(Longueur)
    if (Longueur(k).MajorAxisLength < med*1.5)
        contoursVoit = [contoursVoit, Contours(k)];
        nbVoit = nbVoit + 1;
    end
end

%% 
if showSteps == 1 % si showSteps == 1, on affiche les différentes étapes
    a = 0.5;
    imshow(IGray, []);title('niveaux de gris');
    pause(a);
    imshow(ICartoon, []);title('cartoonisation');
    pause(a);
    imshow(IBinary, []);title('binarisation');
    pause(a);
    imshow(IEdge, []);title('bordures');
    pause(a);
    imshow(IFill, []);title('remplissage');
    pause(a);
end

end