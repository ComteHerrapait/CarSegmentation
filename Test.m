%% Chargement de l'image
Img = imread('Images\001.jpg');
figure(1); imshow(Img, []); title('Image initiale');
figure(); histogram(Img);
Img = rgb2gray(Img);
Img2 = adapthisteq(Img);
ImgThresh = adaptthresh(Img2);
ImgBin = imbinarize(Img2, ImgThresh);
subplot(121); imshow(ImgBin, []); title('Image seuillée');
D=bwdist(~ImgBin);
D = -D;
D=imhmin(D,2);
L = watershed(D);
ImgW=Img;
ImgW(L==0)=0;
imshow(ImgW, []);