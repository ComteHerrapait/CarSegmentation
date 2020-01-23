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