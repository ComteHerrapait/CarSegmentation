function [] = PostTraitement2( ImgInit , ImgBW, Contours,  showSteps )
% * Fonction de post traitement de l'image
% * Permet de dessiner les bounding box sur les voitures (et peut etre
% * trouver les couleurs)
% * ImgInit => image en couleur de départ, pour tracer les BB
% * ImgBW => image en Noir et Blanc après les traitements
% * Contours => liste des bounding Box
% * showSteps => booleen pour l'affichage des étapes de traitements

%% Debuggage
% en fait on veut toujours voir les étapes de cette partie !
showSteps = 1;

%% traitement des couleurs
[imgLabel, nbLabels] = bwlabel(ImgBW); %etiquetage
Icouleurs = ImgInit;

for L = 0:nbLabels
    %%creation d'un masque correspondant à un label
    masque = imgLabel == L;
    
    %%séparation des canaux de couleurs
    Irouge = ImgInit(:,:,1);
    Ivert = ImgInit(:,:,2);
    Ibleu = ImgInit(:,:,3);
    
    %%valeurs moyenne sur le masque
    moyR = uint8(mean(Irouge(masque)));
    moyV = uint8(mean(Ivert(masque)));
    moyB = uint8(mean(Ibleu(masque)));
    
    %%Set the region to average RGB
    IcouleursR = Icouleurs(:,:,1);
    IcouleursV = Icouleurs(:,:,2);
    IcouleursB = Icouleurs(:,:,3);
    if L == 0
        IcouleursR(masque) = 0;
        IcouleursV(masque) = 0;
        IcouleursB(masque) = 0;
    else
        IcouleursR(masque) = moyR;
        IcouleursV(masque) = moyV;
    	IcouleursB(masque) = moyB;
    end
    Icouleurs = cat(3,IcouleursR,IcouleursV,IcouleursB);
end


%% Affichage

if showSteps == 1
    imshow(Icouleurs, []);
    nbVoiture = 0;
    for k = 1:length(Contours) % Iteration sur tous les contours
        thisBB = Contours(k).BoundingBox;
        rectangle('Position',[thisBB(1),thisBB(2),thisBB(3),thisBB(4)],'EdgeColor','b','LineWidth',4 );
        nbVoiture = nbVoiture + 1;
        
    end
    title(sprintf('Il y a %.0f voitures', nbVoiture));
end 

end

