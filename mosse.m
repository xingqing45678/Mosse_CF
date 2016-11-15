%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%function is correlation filter
%Visual Object Tracking using Adaptive Correlation Filters
%MOSSE
%date:2016-11-10
%author:WeiQin
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
close all;clear all;clc;
%载入图片文件
imgDir='D:\ImageData\David';%图片文件夹路径名
[guroundtruth,img_path,img_files]=Load_image(imgDir);%调用函数读取图片帧
img = imread([img_path img_files{1}]);%读取目标帧
if(size(img,3)==1) %灰度图像
    im=img;
else
    im = rgb2gray(img);%转换为灰度图
end
%     figure
%     subplot(1,2,1)
%     imshow(im);title('current imge');
%载入视频文件
% videoDir= '.\video\03_pedestrian1\pedestrian1.mpg';
% videoData=Load_video(videoDir);
target=guroundtruth(1,1:4);%x,y,w,h目标框大小
if rem(target(3),2)==1
    target(3)=target(3)+1;
end
if rem(target(4),2)==1
    target(4)=target(4)+1;
end
target_sz=[target(4) target(3)];%h,w
pos=[target(2)+target(4)/2,target(1)+target(3)/2];%目标框中心点
target_box=im(pos(1)-target_sz(1)/2:pos(1)+target_sz(1)/2,pos(2)-target_sz(2)/2:pos(2)+target_sz(2)/2,:);%获取目标框s
%产生高斯理想模板
F_response=templateGauss(target_box);%高斯理想模板
%主循环读取全部图像帧
for frame=1:100%length(img_files)
        %training训练获得模板
        img = imread([img_path img_files{frame}]);%读取目标帧
        if(size(img,3)==1) %灰度图像
            im=img;
        else
            im = rgb2gray(img);%转换为灰度图
        end
        target_box=im(pos(1)-target_sz(1)/2:pos(1)+target_sz(1)/2,pos(2)-target_sz(2)/2:pos(2)+target_sz(2)/2,:);
        F_im= fft2(target_box);
    if frame>1
        %训练结束开始跟踪并更新模板
        F_newPoint=F_Template.*F_im;
        newPoint=real(ifft2(F_newPoint));%进行反变换
        newPoint=uint8(newPoint);
        [row, col,~] = find(newPoint == max(newPoint(:)), 1);
        pos = pos - target_sz/2 + [row, col]; 
    end
        F_Template=conj(F_im.*conj(F_response)./(F_im.*conj(F_im)));%mosse模板更新      
        %画图
        imagesc(uint8(img))
        colormap(gray)
        rect_position = [pos([2,1]) - (target_sz([2,1])/2), (target_sz([2,1]))]; 
        rectangle('Position',rect_position,'LineWidth',4,'EdgeColor','r');
        hold on;
        text(5, 18, strcat('#',num2str(frame)), 'Color','y', 'FontWeight','bold', 'FontSize',20);
        set(gca,'position',[0 0 1 1]); 
        pause(0.001); 
        hold off;
        drawnow;
end

