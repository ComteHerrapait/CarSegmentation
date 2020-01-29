function [validation, nCarsDetected] = ChaineDeTraitement( numImg , showSteps)
% Chaîne de traitement prenant en argument une image initiale 8int et qui
% renvoie le nombre de voitures présente sur cette image

Img = imread(strcat('Images\',numImg,'.jpg'));
file = fopen(strcat('Images/Annotations/',numImg,'.annotation.txt'));	%ouverture de l'annotation

if (file ~= -1)&&(~isempty(image))
    %%Lecture des annotations
    line = fgetl(file);                 %deuxième ligne du texte d'annotations
    nCarsTheoricMax = str2num(line);	%conversion en nombre
    line = fgetl(file);                 %premiere ligne du texte d'annotations
    nCarsTheoricMin = str2num(line);    %conversion en nombre
    tic;
 
    [ImgBin, nCarsDetected, ContCarDetected, IFill] = PreTraitement2(Img, showSteps);
    if ~isempty(nCarsTheoricMin) && ~isempty(nCarsTheoricMax) && (nCarsDetected == nCarsTheoricMax)
        PostTraitement2(Img, IFill, ContCarDetected, showSteps);
        validation = 1;
    else
        [nCarsDetected, ContCarDetected, IFill] = Traitement2(ImgBin, showSteps);
        PostTraitement2(Img, IFill, ContCarDetected, showSteps);
        validation = 1;
    end
    
    %%Fermeture du fichier
    fclose(file);
end
end

