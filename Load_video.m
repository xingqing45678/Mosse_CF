%用函数读取视频，读取groundtruth数据
function [videoData,target] = Load_video(videoDir)
    sequence_path = [videoDir,'\'];%文件路径
    videoFile = [sequence_path 'david.mpg']; %文件路径
    videoData = VideoReader(videoFile);%读取视频
% % for i = 1 : 50
% %         videoframe = read(videoData,i);% 读取每一帧
% %         videoframe= rgb2gray(videoframe);%转换为灰度图
% %         imshow(videoframe);%显示每一帧
% %         % imwrite(frame,strcat(num2str(i),'.jpg'),'jpg');% 保存每一帧
% % end
    %% Read files 
    groundtruth = csvread([sequence_path 'groundtruth_rect.txt']);%序列中真实目标位置
    %% get position and boxsize 读取groundtruth数据 
    if(size(groundtruth,2)==1)%一列
        target=groundtruth(1:4);%x,y,w,h目标框大小
    else if(size(groundtruth,2)==4)%4列
        target=groundtruth(1,1:4);%x,y,w,h目标框大小
    else
        error('something wrong in groundtruth');
        end
    end
end