%�߹켣׷�ٺ���
function  y= lineway(Jtbegin,  j, Jprior, image_sobel)
% ����Լ������
[m, n] = size(image_sobel);
for t_tt=1:m
    E2 = abs(t_tt - Jprior);  %ƽ��Լ��
    E3 = abs(t_tt - Jtbegin);  %����Լ��
    yfun(1,t_tt) = 256 - image_sobel(t_tt,j) + E2 + E3;
end
[Tmin, y] = min(yfun);