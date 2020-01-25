function [ ImgFin ] = PreTraitement( ImgInit, showSteps )
% * Fonction de pre-traitement de l'image
% * Prend une mage uint8 en entré et renvoie une image binarise

ImgGray = rgb2gray(ImgInit); % Image uint8 => Image niveau de gris 
ImgCartoon = cartoon(ImgGray); % Image niveau de gris => Image cartoonisee
ImgAdapt = adapthisteq(ImgCartoon); % 
ImgThresh = adaptthresh(ImgAdapt); % Calcul d'un seuil adaptatif
ImgFin = imbinarize(ImgAdapt, ImgThresh); % Image cartoonise => Image binaire

if showSteps == 1 % si showSteps == 1, on affiche les différentes étapes
    a = 0.5;
    imshow(ImgGray, []);
    pause(a);
    imshow(ImgCartoon, []);
    pause(a);
    imshow(ImgAdapt, []);
    pause(a);
    imshow(ImgFin, []);
    pause(a);
end

end

