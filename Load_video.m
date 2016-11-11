%读取视频
function videoData=Load_video(videoDir)
    videoFile = videoDir; %文件路径
    videoData = VideoReader(videoFile);%读取视频
% % for i = 1 : 50
% %         videoframe = read(videoData,i);% 读取每一帧
% %         videoframe= rgb2gray(videoframe);%转换为灰度图
% %         imshow(videoframe);%显示每一帧
% %         % imwrite(frame,strcat(num2str(i),'.jpg'),'jpg');% 保存每一帧
% % end
end