%% Chargement de l'image
Img = imread('Images\006.jpg');
figure();

%% Pre-traitement
ImgPreTrait = PreTraitement(Img, 1);

%% Traitement
ImgTraitement = Traitement(ImgPreTrait, 1);

%% Post-traitement
PostTraitement(ImgTraitement, Img, 1)