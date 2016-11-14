%%%%%%%%%%%%%%%%%%%%产生高斯理想响应%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function F_response=templateGauss(im)
    if(size(im,3)==1) %灰度图像
        [height,width]=size(im);
        gaussMaxSize=20;%高斯平面最大值,值越大高斯点越小
        x=-gaussMaxSize:gaussMaxSize*2/width:gaussMaxSize-gaussMaxSize*2/width;
        y=-gaussMaxSize:gaussMaxSize*2/height:gaussMaxSize-gaussMaxSize*2/width;
        [X,Y]=meshgrid(x,y);%
        response=255.*exp(-X.^2-Y.^2);%生成二维高斯分布
    else              %彩色图像
        [height,width,~]=size(im);
        gaussMaxSize=20;%高斯平面最大值,值越大高斯点越小
        x=-gaussMaxSize:gaussMaxSize*2/width:gaussMaxSize-gaussMaxSize*2/width;
        y=-gaussMaxSize:gaussMaxSize*2/height:gaussMaxSize-gaussMaxSize*2/width;
        [X,Y]=meshgrid(x,y);%
        r=255.*exp(-X.^2-Y.^2);%生成二维高斯分布
        response(:,:,1)=r;response(:,:,2)=r;response(:,:,3)=r;
        
    end
        F_response=fft2(response);%傅里叶变换
%         figure
%         imshow(response);
%         mesh(response);
end