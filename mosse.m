%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%function is correlation filter
%Visual Object Tracking using Adaptive Correlation Filters
%MOSSE
%date:2016-11-10
%author:WeiQin
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
close all;clear all;clc;
%载入图片文件
imgDir='.\BlurCar3\';%图片文件夹路径名
[guroundtruth,img_path,img_files]=Load_image(imgDir);%调用函数读取图片帧
im = imread([img_path img_files{1}]);%读取目标帧
im = rgb2gray(im);%转换为灰度图
    figure
    subplot(1,2,1)
    imshow(im);title('current imge');
%载入视频文件
% videoDir= '.\video\03_pedestrian1\pedestrian1.mpg';
% videoData=Load_video(videoDir);
%产生高斯理想模板
F_response=templateGauss(im);%高斯理想模板
%主循环读取全部图像帧
for frame=1:50%length(img_files)
        %training训练获得模板
        im = imread([img_path img_files{frame}]);%读取目标帧
        im = rgb2gray(im);%转换为灰度图
        F_im= fft2(im);
    if frame>1
        %训练结束开始跟踪并更新模板
        F_newPoint=F_Template.*F_im;
        newPoint=real(ifft2(F_newPoint));%进行反变换
        newPoint=uint8(newPoint);
        %画图
        subplot(1,2,1)
        imshow(im);title('current imge');
        subplot(1,2,2)
        imshow(newPoint);title('mosse');
        drawnow
    end
    F_Template=conj(F_im.*conj(F_response)./(F_im.*conj(F_im)));%mosse模板更新  
end

