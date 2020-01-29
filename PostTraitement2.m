function [] = PostTraitement2( ImgInit , Contours,  showSteps )
% * Fonction de post traitement de l'image
% * Permet de dessiner les bounding box sur les voitures (et peut etre
% * trouver les couleurs)

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

end

