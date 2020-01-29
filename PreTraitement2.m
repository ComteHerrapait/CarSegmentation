function [ ImgBin, nbVoit, contoursVoit, IFill] = PreTraitement2( Istart, showSteps )
% * Fonction de pre-traitement de l'image
% * Peut permettre de trouver le nombre de voiture
% ImgBin - > image binaire des voitures
% nbVoit - > nombre de voitures trouvées par cette méthode
% contoursVoit - > Bounding Boxes des voitures trouvées par cette méthode
% IFill -> version remplie de l'image binaire, pour l'affichage 

%% binarization
IGray = rgb2gray(Istart);
ICartoon = cartoon(IGray);
IBinary = ICartoon<0.10;
IBinary = bwareaopen(IBinary,10);%removes small shapes

%% Rough shape of cars
IEdge = edge(ICartoon,'canny');                 %detection de contours
IFill = imdilate(IEdge,strel('disk',3));        %dilatation pour rassembler les contours
IFill = imfill(IFill, 'holes');                 %remplissage des formes
IReconstruct = imreconstruct(IBinary, IEdge);   %recontruction géodésique
ImgBin = IReconstruct;                          %image finale

Longueur = regionprops(IFill, 'MajorAxisLength');%trouve la taille du grand axes des blobs
med = median([Longueur.MajorAxisLength]);%puis en calcule la médiane

Contours = regionprops(IFill, 'BoundingBox'); 
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