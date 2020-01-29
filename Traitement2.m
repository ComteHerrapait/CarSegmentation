function [ nbVoit, contoursVoit, IFill] = Traitement2( Istart, showSteps )
% * Fonction de traitement de l'image
% * Prend une image binarise et renvoie le nombre de voiture si le
% * preTraitement n'est pas suffisant

%% Adaptative closing
orientations = regionprops(Istart, 'Orientation');
axisLength = regionprops(Istart, 'MajorAxisLength');

deg = median([orientations.Orientation]);
len = median([axisLength.MajorAxisLength]);

IReconstruct2 = imclose(Istart, strel('line',len/6,deg));

%%
IReconstruct3 = imclose(IReconstruct2, strel('disk',fix(len/15) )); %rapproche
IReconstruct3 = imfill(IReconstruct3, 'holes');
IReconstruct3 = imopen(IReconstruct3, strel('disk', fix(len/30) )); %sépare

longueur = regionprops(IReconstruct3, 'MajorAxisLength');
largeur = regionprops(IReconstruct3, 'MinorAxisLength');

Contours = regionprops(IReconstruct3, 'BoundingBox'); % Contours des objets de l'image
nbVoit = 0;
contoursVoit = [];
for k=1:length(longueur)
    long = longueur(k).MajorAxisLength;
    larg = largeur(k).MinorAxisLength;
    if (long>larg*1.2 && long<larg*3.5 && long > 100)
        contoursVoit = [contoursVoit, Contours(k)];
        nbVoit = nbVoit + 1;
    end
end
IFill = IReconstruct3;
%% 
if showSteps == 1 % si showSteps == 1, on affiche les différentes étapes
    a = 0.5;
    imshow(Istart, []);title('image reconstruite')
    pause(a);
    imshow(IReconstruct2, []);title('image fermeture adaptative')
    pause(a);
    imshow(IReconstruct3, []);title('image finale')
    pause(a); 
end

end