function [validation] = ChaineDeTraitement( numImg )
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
 
    [ImgBin, nCarsDetected, ContCarDetected] = PreTraitement2(Img, 1);
    if ~isempty(nCarsTheoricMin) && ~isempty(nCarsTheoricMax) && (nCarsDetected >= nCarsTheoricMin) && (nCarsDetected <= nCarsTheoricMax)
        PostTraitement2(Img, ContCarDetected, 1);
        validation = 1;
        valid = 'VALID';
    else
        [nCarsDetected, ContCarDetected] = Traitement2(ImgBin, 1);
        if ~isempty(nCarsTheoricMin) && ~isempty(nCarsTheoricMax) && (nCarsDetected >= nCarsTheoricMin) && (nCarsDetected <= nCarsTheoricMax)
            PostTraitement2(Img, ContCarDetected, 1);
            validation = 1;
            valid = 'VALID';
            
        else
            validation = 0;
            valid = '-----';
        end
    end
    
    %%Affichage en cours de traitement
    fprintf('%s%s [%02.0f : %02.0f]\t%02.0f voitures %s(%.2fs)\n', numImg, " ", nCarsTheoricMax, nCarsTheoricMin, nCarsDetected, valid, toc);
    
    %%Fermeture du fichier
    fclose(file);
end
end

