%%%%%%%%%%%%%%%%%%%%产生高斯理想响应%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function F_response=templateGauss(im)
    [height,width]=size(im);
    gaussMaxSize=10;%高斯平面最大值
    x=-gaussMaxSize:gaussMaxSize*2/width:gaussMaxSize-gaussMaxSize*2/width;
    y=-gaussMaxSize:gaussMaxSize*2/height:gaussMaxSize-gaussMaxSize*2/width;
    [X,Y]=meshgrid(x,y);%
    response=255.*exp(-X.^2-Y.^2);%生成二维高斯分布
    F_response=fft2(response);
%     mesh(response);
end