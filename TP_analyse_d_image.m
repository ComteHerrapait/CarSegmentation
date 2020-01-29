%% Test d'une image
numImg = '024';

% Chaine de traitement
valid = ChaineDeTraitement(numImg);
    
    
%% Test des 60 images
nbValid = 0;
for k=1:60
    if k<10
        numImg = strcat('00',int2str(k));
    elseif k<31
        numImg = strcat('0',int2str(k));
    elseif k<40
        numImg = strcat('00',int2str(k-30),'b');
    else
        numImg = strcat('0',int2str(k-30),'b');
    end

    valid = ChaineDeTraitement(numImg);
    nbValid = nbValid + valid;
end
%% Affichage du résultat
fprintf('\nTaux de réussite au traitement : %.1f %%\n %.0f bien traitées \n\n',100 * nbValid / 60, nbValid);