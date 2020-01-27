%% Program to test the success rate of the current algorithm

%%  Initialisation
nTested = 0;
nValid = 0;

for i=1:30
    %% Chemin d'accès
    name = num2str(i,'%03.f');              %mise en forme du nom de l'image
    path = strcat('Images/', name,'.jpg');  %chemin vers l'image
    
    %% Ouverture des fichiers
    image = imread(path);                                              	%ouverture de l'image
    file = fopen(strcat('Images/Annotations/',name,'.annotation.txt'));	%ouverture de l'annotation
    
    %% Test de l'ouverture
    if (file ~= -1)&&(~isempty(image))
        nTested = nTested + 1;%compteur d'images traitées
        
        %%Lecture des annotations
        line = fgetl(file);                 %deuxième ligne du texte d'annotations
        nCarsTheoricMin = str2num(line);	%conversion en nombre
        line = fgetl(file);                 %premiere ligne du texte d'annotations
        nCarsTheoricMax = str2num(line);    %conversion en nombre
    
        %%Traitement de l'image
        ImgPreTrait = PreTraitement(image, 0);
        ImgTraitement = Traitement(ImgPreTrait, 0);
        nCarsDetected = PostTraitement(ImgTraitement, image, 0);
        
        %%Affichage en cours de traitement
        fprintf('num = %.0f \tmin = %.0f \tmax = %.0f \ttrouvées = %.0f\n',i, nCarsTheoricMin, nCarsTheoricMax, nCarsDetected)
        
        %%teste si les valeurs sont correctes et si les valeurs du fichier
        %%d'annotation existent
        if ~isempty(nCarsTheoricMin) && ~isempty(nCarsTheoricMax) && (nCarsDetected >= nCarsTheoricMin) && (nCarsDetected <= nCarsTheoricMax)
            nValid = nValid + 1;
        end
        
        %%Fermeture du fichier
        fclose(file);
    end
end

%% Affichage du résultat
fprintf('\n\nTaux de réussite au traitement : %.1f %%\n\n',100 * nValid / nTested);
