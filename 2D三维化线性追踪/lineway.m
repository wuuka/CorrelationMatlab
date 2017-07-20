%线轨迹追踪函数
function  y= lineway(Jtbegin,  j, Jprior, image_sobel)
% 三个约束条件
[m, n] = size(image_sobel);
for t_tt=1:m
    E2 = abs(t_tt - Jprior);  %平滑约束
    E3 = abs(t_tt - Jtbegin);  %弹性约束
    yfun(1,t_tt) = 256 - image_sobel(t_tt,j) + E2 + E3;
end
[Tmin, y] = min(yfun);