%% Program to test the success rate of the current algorithm

%%  Initialisation
nTested = 0;
nValid = 0;
for b = ["",'b']
    for i=1:30
        %% Chemin d'acc�s
        name = num2str(i,'%03.f');                  %mise en forme du nom de l'image
        if b == ""
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
            nCarsTheoricMin = str2num(line);	%conversion en nombre
            line = fgetl(file);                 %premiere ligne du texte d'annotations
            nCarsTheoricMax = str2num(line);    %conversion en nombre
            tic;
            %%Traitement de l'image
            ImgPreTrait = PreTraitement(image, 0);
            ImgTraitement = Traitement(ImgPreTrait, 0);
            nCarsDetected = PostTraitement(ImgTraitement, image, 0);

            %%Affichage en cours de traitement
            fprintf('%s%s.jpg  [%02.0f : %02.0f]\t %02.0f voitures trouv�es (%.3fs)\n', name, b, nCarsTheoricMin, nCarsTheoricMax, nCarsDetected,toc)

            %%teste si les valeurs sont correctes et si les valeurs du fichier
            %%d'annotation existent
            if ~isempty(nCarsTheoricMin) && ~isempty(nCarsTheoricMax) && (nCarsDetected >= nCarsTheoricMin) && (nCarsDetected <= nCarsTheoricMax)
                nValid = nValid + 1;
            end

            %%Fermeture du fichier
            fclose(file);
        end
    end
end
%% Affichage du r�sultat
fprintf('\nTaux de r�ussite au traitement : %.1f %%\n %.0f bien trait�es \n\n',100 * nValid / nTested, nValid);
