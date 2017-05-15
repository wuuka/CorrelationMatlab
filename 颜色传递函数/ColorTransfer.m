%% ÑÕÉ«´«µİ
img=imread('12.jpg');
imshow(img);
R_mean=mean2(img(:,:,1));
R_epse=std2(img(:,:,1))^2;
G_mean=mean2(img(:,:,2));
G_epse=std2(img(:,:,2))^2;
B_mean=mean2(img(:,:,3));
B_epse=std2(img(:,:,3))^2;

img2=imread('2.jpg');
figure,imshow(img2);
[m, n, dim]=size(img2);
R2_mean=mean2(img2(:,:,1));
R2_epse=std2(img2(:,:,1))^2;
G2_mean=mean2(img2(:,:,2));
G2_epse=std2(img2(:,:,2))^2;
B2_mean=mean2(img2(:,:,3));
B2_epse=std2(img2(:,:,3))^2;

for i=1:m
    for j=1:n
        imgcop(i,j,1) =(R_epse/R2_epse)*(img2(i,j,1)- R2_mean)+R_mean;
        imgcop(i,j,2) =(G_epse/G2_epse)*(img2(i,j,2)- G2_mean)+G_mean;
        imgcop(i,j,3) =(B_epse/B2_epse)*(img2(i,j,3)- R2_mean)+B_mean;
    end
end

figure,imshow(imgcop)
title('RGB');