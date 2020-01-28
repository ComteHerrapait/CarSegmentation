function [ Nbvoit ] = Traitement2( Istart )
% * Fonction de pre-traitement de l'image
% * Prend une mage uint8 en entrée et renvoie une image binarise

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
nbVoit = 0;
for k=1:length(longueur)
    long = longueur(k).MajorAxisLength;
    larg = largeur(k).MinorAxisLength;
    if (long>larg*1.2 && long<larg*3.5 && long > 100)
        nbVoit = nbVoit + 1;
    end
end
Nbvoit = nbVoit;
end