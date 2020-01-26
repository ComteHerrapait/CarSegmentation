function [Contours] = PostTraitement( ImgTraitement, ImgInit )
% * Fonction de post-traitement
% * Prend en argument l'image initiale et l'image renvoyee par le traitement

Contours = regionprops(ImgTraitement, 'BoundingBox'); % Contours des objets de l'image
imshow(ImgInit, []);
nbVoiture = 0;
for k = 1:length(Contours) % Iteration sur tous les contours
    thisBB = Contours(k).BoundingBox;
    if (thisBB(4)>thisBB(3)*1.5 && thisBB(4)<thisBB(3)*3) 
        rectangle('Position',[thisBB(1),thisBB(2),thisBB(3),thisBB(4)],'EdgeColor','b','LineWidth',5 );
        nbVoiture = nbVoiture + 1;
    end
end
title(sprintf('Il y a %.0f voitures', nbVoiture));
end

