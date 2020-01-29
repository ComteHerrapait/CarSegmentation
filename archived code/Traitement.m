function [ ImgFin ] = Traitement( ImgPreTrait, showSteps )
% * Fonction de traitement de l'image
% * Prend en argument l'image renvoyee par le pre-traitement et renvoie une
% * image ne contenant que les voitures

Marqueur = ImgPreTrait; % Marqueurs
s = strel('rectangle', [9,11]); % Element structurant
for k=1:1 % Parametre k a preciser   
    Marqueur = imerode(Marqueur, s); % Erosion successive pour ne garder que les marqueurs des voitures
end

ImgReconstr = imreconstruct(Marqueur, ImgPreTrait); % Image reconstruite a partir des marqueurs (voitures)
s = strel('disk', 4);
ImgFin = imclose(ImgReconstr, s);

if showSteps == 1
    a = 1;
    imshow(ImgFin, []);
    pause(a);
end

end

