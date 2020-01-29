%% Program to test the success rate of the current algorithm on all images

%%  Initialisation
nTested = 0;
nValid = 0;
fprintf('\n%s%s [%s : %s]\t%s voitures %s(%.s)\n\n', 'nom', ' ', 'min', 'max', 'nbcar' ,'VALID' ,'time')
for b = [" ",'b']
    for i=1:30
        %% Nom de l'image
        name = num2str(i,'%03.f');%mise en forme du nom de l'image

        %% Ouverture du fichier d'annotations
        file = fopen(strcat('Images/Annotations/',name,'.annotation.txt'));	%ouverture de l'annotation
        
        %%  Lecture des annotations
        line = fgetl(file);                 %deuxi?me ligne du texte d'annotations
        nCarsTheoricMax = str2num(line);	%conversion en nombre
        line = fgetl(file);                 %premiere ligne du texte d'annotations
        nCarsTheoricMin = str2num(line);    %conversion en nombre
        
        %% Test de detections / traitement de l'image
        tic;
        [validation, nCarsDetected] = ChaineDeTraitement( name, 0 );
        if (nCarsDetected >= nCarsTheoricMin) && (nCarsDetected <= nCarsTheoricMax)
            valid = 'VALID';
            nValid = nValid + 1;
        else
        	valid = '-----';
        end

        %% Affichage en cours de traitement
        fprintf('%s%s [%02.0f : %02.0f]\t%02.0f voitures %s(%.2fs)\n', name, b, nCarsTheoricMax, nCarsTheoricMin, nCarsDetected,valid,toc)


    end
end
%% Affichage du résultat
fprintf('\nTaux de réussite au traitement : %.1f %%\n %.0f bien traitées \n\n',100 * nValid / nTested, nValid);
