%% Program to test the success rate of the current algorithm

%%  Initialisation
nTested = 0;
nValid = 0;
fprintf('\n%s%s [%s : %s]\t%s voitures %s(%.s)\n\n', 'nom', ' ', 'min', 'max', 'nbcar' ,'VALID' ,'time')
for b = [" ",'b']
    for i=1:30
        %% Chemin d'acc�s
        name = num2str(i,'%03.f');                  %mise en forme du nom de l'image
        if b == " "
            path = strcat('Images/', name,'.jpg');	%chemin vers l'image
        else
            path = strcat('Images/', name,'b.jpg');	%chemin vers l'image bruit�e
        end


        %% Ouverture des fichiers
        image = imread(path);                                              	%ouverture de l'image
        file = fopen(strcat('Images/Annotations/',name,'.annotation.txt'));	%ouverture de l'annotation

        %% Test de l'ouverture
        if (file ~= -1)&&(~isempty(image))
            nTested = nTested + 1;%compteur d'images trait�es

            %%Lecture des annotations
            line = fgetl(file);                 %deuxi�me ligne du texte d'annotations
            nCarsTheoricMax = str2num(line);	%conversion en nombre
            line = fgetl(file);                 %premiere ligne du texte d'annotations
            nCarsTheoricMin = str2num(line);    %conversion en nombre
            tic;
            %%Traitement de l'image
            [ImgPre, nCarsDetected] = PreTraitement2(image, 0);

           
            %%teste si les valeurs sont correctes et si les valeurs du fichier
            %%d'annotation existent
            if ~isempty(nCarsTheoricMin) && ~isempty(nCarsTheoricMax) && (nCarsDetected >= nCarsTheoricMin) && (nCarsDetected <= nCarsTheoricMax)
                valid = 'VALID';
                nValid = nValid + 1;
            else
                nCarsDetected = Traitement2(ImgPre);
                if ~isempty(nCarsTheoricMin) && ~isempty(nCarsTheoricMax) && (nCarsDetected >= nCarsTheoricMin) && (nCarsDetected <= nCarsTheoricMax)
                    valid = 'VALID';
                    nValid = nValid + 1;
                else
                    valid = '-----';
                end
            end
            
            %%Affichage en cours de traitement
            fprintf('%s%s [%02.0f : %02.0f]\t%02.0f voitures %s(%.2fs)\n', name, b, nCarsTheoricMax, nCarsTheoricMin, nCarsDetected,valid,toc)
            
            %%Fermeture du fichier
            fclose(file);
        end
    end
end
%% Affichage du r�sultat
fprintf('\nTaux de r�ussite au traitement : %.1f %%\n %.0f bien trait�es \n\n',100 * nValid / nTested, nValid);
