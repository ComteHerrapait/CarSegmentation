%% Chargement de l'image
Img = imread('Images\007.jpg');
figure();

%% Pre-traitement
ImgPreTrait = PreTraitement(Img, 1);

%% Traitement
ImgTraitement = Traitement(ImgPreTrait, 1);

%% Post-traitement
Contour = PostTraitement(ImgTraitement, Img, 1);