function DepthEst

clc
clear
image_sobel1 = imread('sobel_matab_cf1.jpg');
image_sobel1 = rgb2gray(image_sobel1);
image_sobel1 = im2bw(image_sobel1,0.314);
[m, n] = size(image_sobel1);
image_sobel = zeros(m,n);
for i = 1:m
    for j = 1:n
        if (image_sobel1(i,j) == 1)
            image_sobel(i,j) = 255;
        end
    end
end

imshow(image_sobel1)
[m, n] = size(image_sobel);

a = mean(mean(image_sobel));  %��Ե׷��Լ��
%��������-----------------------------------------------------
aweight = [0.4, 0.3, 0.3];  %Ŀ�꺯��Ȩֵϵ��
Aweight = [a, 141, 141];  %Լ����������ϵ��
%����������������������������������������������������
Interval = round(m/101);  %���ֲ���
LineRegion = ones(102,n);

for num = Interval:Interval:m
    Jprior = num/Interval;
    LineRegion(num/Interval, 1) = num;
    for j = 2:n
        t= lineway(aweight, Aweight, num, j, Jprior, image_sobel);
        Jprior = t;
        LineRegion(num/Interval, j) = t;
        image_sobel(t+1, j) = image_sobel(t, j) + 30;
    end
end

figure(2)  %�߹켣ͼ
imshow(image_sobel)

%�����Ϣ
high = zeros(m,n);
for num = 1:101
    for j = 1:n
        for i =  LineRegion(num,j):1:LineRegion(num+1,j)
            high(i, j) = 255 - (255/100)*(num-1);
        end
    end
end
figure(4)
imshow(high);

figure(3)  %���ͼ
[x, y] = meshgrid(1:400,1:400);
u = high(x(1,:), y(:,1));
mesh(x,y,u);

        
        %�߹켣׷�ٺ���
function  y= lineway(aweight, Aweight, Jtbegin,  j, Jprior, image_sobel)

% ����Լ������
[m, n] = size(image_sobel);
for t_tt=1:m
    E1 = exp(double(-image_sobel(t_tt,j)/Aweight(1,1)));
    E2 = abs(t_tt - Jprior)/Aweight(1,2);  %ƽ��Լ��
    E3 = abs(t_tt - Jtbegin)/Aweight(1,3);  %����Լ��
    yfun(1,t_tt) = aweight(1,1)*E1 + aweight(1,2)*E2 + aweight(1,3)*E3;
end
[Tmin, y] = min(yfun);
     
    