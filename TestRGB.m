Img = imread('Images\024.jpg');

figure(); imshow(Img, []);
figure();
subplot(221); imshow(rgb2gray(Img), []);
subplot(222); imshow(Img(:,:,1), []);
subplot(223); imshow(Img(:,:,2), []);
subplot(224); imshow(Img(:,:,3), []);