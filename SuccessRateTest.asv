%% Program to test the success rate of the current algorithm

nTested = 0;
nValid = 0;

for i=1:30
    name = num2str(i,'%03.f');%mise en forme du nom de l'image
    path = strcat('Images/', name,'.jpg');%chemin vers l'image
    image = imread(path);
    
    file = fopen(strcat('Images/Annotations/',name,'.annotation.txt'));
    if file ~= -1 %si le fichier s'ouvre bien :
        line = fgetl(file); %premiere ligne du texte
        nCarsTheoric = str2num(line); %conversion en nombre
        nTested = nTested + 1;
        
        ImgPreTrait = PreTraitement(image, 0);
        ImgTraitement = Traitement(ImgPreTrait, 0);
        nCarsDetected = PostTraitement(ImgTraitement, image, 0);
        
        if nCarsDetected == nCarsTheoric
            nValid = nValid + 1;
        end
        
        fclose(file);
    end

end
successRate = nValid / nTested