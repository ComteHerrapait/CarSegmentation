%% Numero de l'image
ImgSet = imageSet('Images');
%%
nbValid = 0;
for k=2:2
    if k<10
        numImg = strcat('00',int2str(k));
    elseif k<31
        numImg = strcat('0',int2str(k));
    elseif k<40
        numImg = strcat('00',int2str(k-30),'b');
    else
        numImg = strcat('0',int2str(k-30),'b');
    end
    %% Chaine de traitement
    valid = ChaineDeTraitement(numImg);
    nbValid = nbValid + valid;
end
%% Affichage du résultat
fprintf('\nTaux de réussite au traitement : %.1f %%\n %.0f bien traitées \n\n',100 * nbValid / 60, nbValid);