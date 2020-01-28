function [ ImgBin ] = PreTraitement2( Istart, showSteps )
% * Fonction de pre-traitement de l'image
% * Prend une mage uint8 en entrée et renvoie une image binarise

%%
% stdfilt(I) => donne une image en ecart type
%
%
%%

ImgGray = rgb2gray(Istart); % Image uint8 => Image niveau de gris

ImgCartoon = cartoon(ImgGray); % Cartoonisation de l'image

ImgAdapt = adapthisteq(ImgCartoon); % ???

ImgBin = imbinarize(ImgAdapt,'adaptive'); % Image cartoonise => Image binaire

s = strel('disk', 4);
ImgFin = imopen(ImgBin, s);

if showSteps == 1 % si showSteps == 1, on affiche les différentes étapes
    a = 2;
    imshow(ImgGray, []);
    pause(a);
    imshow(ImgAdapt, []);
    pause(a);
    imshow(ImgBin, []);
    pause(a);
    imshow(ImgFin, []);
    pause(a);
end

end