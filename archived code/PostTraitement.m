function [nCarsDetected] = PostTraitement( ImgTraitement, ImgInit , showSteps)
% * Fonction de post-traitement
% * Prend en argument l'image initiale et l'image renvoyee par le traitement
if nargin < 3
    showSteps =   true;
end

Contours = regionprops(ImgTraitement, 'BoundingBox'); % Contours des objets de l'image
if showSteps == 1
    imshow(ImgInit, []);
    nbVoiture = 0;
    for k = 1:length(Contours) % Iteration sur tous les contours
        thisBB = Contours(k).BoundingBox;
        rectangle('Position',[thisBB(1),thisBB(2),thisBB(3),thisBB(4)],'EdgeColor','b','LineWidth',5 );
        nbVoiture = nbVoiture + 1;
    end
    title(sprintf('Il y a %.0f voitures', nbVoiture));
end 
nCarsDetected = length(Contours);
end

