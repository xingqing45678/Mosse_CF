%调用函数读取图片帧，读取groundtruth数据
function [ground_truth,img_path,img_files]=Load_image(imgDir)
%     %% Read params.txt
%     params = readParams('params.txt');
	%% load video info
    sequence_path = [imgDir,'/'];%文件路径
    img_path = [sequence_path 'img/'];
    %% Read files 
    ground_rect = csvread([sequence_path 'groundtruth_rect.txt']);%序列中真实目标位置
    %%%%%%%%%%%%%%%%%%%%%%%%%
    % read all the frames in the 'imgs' subfolder
    dir_content = dir([sequence_path 'img/']);
    % skip '.' and '..' from the count
    n_imgs = length(dir_content) - 2;
    img_files = cell(n_imgs, 1);
    for ii = 1:n_imgs
        img_files{ii} = dir_content(ii+2).name;
    end
    %% get position and boxsize 读取groundtruth数据 
    if(size(ground_rect,2)==1)%一列
        error('please add "," in groundtruth');%x,y,w,h目标框大小
    else if(size(ground_rect,2)==4)%4列
        ground_truth=ground_rect;%x,y,w,h目标框大小
    else
        error('something wrong in groundtruth');
        end
    end
%     im = imread([img_path img_files{1}]);%读取目标帧
%     im= rgb2gray(im);%转换为灰度图
%     imshow(im);
end