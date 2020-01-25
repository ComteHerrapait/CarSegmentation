%% Mise du fond à 0
[N, EDGES] = histcounts(Img);
max = 0;
indice = 0;
for k=1:length(N)
    if (N(k) > max)
        max = N(k);
        Indice = k;
    end
end
[rows, columns] = size(Img);
for k = 1:rows
    for i = 1:columns
        if (Img(k,i) >= EDGES(Indice-6) && Img(k,i) <= EDGES(Indice+7))
            Img(k,i) = 0;
        end
    end
end

%% Floutage du fond
h=fspecial('log');
Img =imfilter(Img, h);
subplot(222); imshow(Img, []); title('Image floutée');
subplot(224); histogram(Img); axis on; ylim([0, 10^5]);

%% Ligne de partage des eaux
D=bwdist(~Img);
D = -D;
D=imhmin(D,2);
L = watershed(D);
ImgW=Img;
ImgW(L==0)=0;

%% Reconstruction geodesique
[fe, n] = bwlabel(ImgBin);
Marqueur = ImgBin;
figure();
% Parametre k a preciser
for k=1:8
    s = strel('disk', 1);
    Marqueur = imerode(Marqueur, s);
    [fe, n] = bwlabel(Marqueur);
    imshow(Marqueur, []);
    pause(0.1);
end
ImgReconstruct = imreconstruct(Marqueur, ImgBin);
figure();
imshow(ImgReconstruct, []);

%% Test couleur
length(Contours)
figure(4);
for k = 1 : length(Contours)
    thisBB = Contours(k).BoundingBox;
    y = floor(thisBB(1)/1);
    x = floor(thisBB(2)/1);
    w = thisBB(3);
    h = thisBB(4);
    img_cut = Img(x:x+h,y:y+w);
    subplot(4,4,k); imshow(img_cut, []); title(sprintf('Image %.0f', k));
    histogram(img_cut); title(sprintf('histogram %.0f', k));
end

%% Affichage
figure(); imshow(Img, []); title(sprintf('Il y a %.0f voitures', length(Contours)));