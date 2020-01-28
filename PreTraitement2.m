function [ ImgBin ] = PreTraitement2( Istart, showSteps )
% * Fonction de pre-traitement de l'image
% * Prend une mage uint8 en entrée et renvoie une image binarise

%% binarization
IGray = rgb2gray(Istart);
ICartoon = cartoon(IGray);
IBinary = ICartoon<0.10;
IBinary = bwareaopen(IBinary,10);%%removes small shapes

%% Rough shape of cars
IEdge = edge(ICartoon,'canny');
IFill = imdilate(IEdge,strel('disk',3));
IFill = imfill(IFill, 'holes');

ImgBin = IFill;

%% 
if showSteps == 1 % si showSteps == 1, on affiche les différentes étapes
    a = 2;
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