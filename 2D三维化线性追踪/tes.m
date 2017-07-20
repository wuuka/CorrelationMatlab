clear all;
close all;
clc
imag = imread('we.jpg');  %读取关键帧
imag = rgb2gray(imag);        %转化为灰度图
subplot(221);imshow(imag);
title('原图');
uSobel = edge(imag,'sobel', 0.08);
subplot(222);imshow(uSobel,[]);title('Matlab自带函数边缘检测');

[m, n] = size(uSobel);
image_pro = zeros(m,n);
for i = 1:m
    for j = 1:n
        if (uSobel(i,j) == 1)
            image_pro(i,j) = 255;
        end
    end
end
subplot(223);imshow(uint8(image_pro));
title('二值图');

Interval = round(m/49);  %划分层数
LineRegion = ones(48,n);
image_pros = image_pro;
for num = Interval:Interval:m
    Jprior = num;
    LineRegion(num/Interval, 1) = num;
    for j = 2:n
        %t= lineway(aweight, Aweight, num, j, Jprior, image_sobel);
        t= lineway(num,  j, Jprior, image_pro);
        Jprior = t;
        LineRegion(num/Interval, j) = t;
        image_pros(t, j) =  255;
    end
end
%%线轨迹图
subplot(224);imshow(uint8(image_pros));
title('轨迹图');

%深度信息
high = zeros(m,n);
for num = 1:47
    for j = 1:n
        if num==1
            for i =  1:LineRegion(num,j)
            high(i, j) = 255;
            end
        end
        
        if num==47
            for i =  LineRegion(num+1,j):1:768
                high(i, j) = 0;
            end
        end
            
        for i =  LineRegion(num,j):1:LineRegion(num+1,j)
            high(i, j) = 255 - round((255/48)*num);
        end
    end
end
figure(2)
imshow(uint8(high));
title('轨迹图');
