%读取图片帧
function [guroundtruth,img_path,img_files]=Load_image(imgDir)
%     %% Read params.txt
%     params = readParams('params.txt');
	%% load video info
    sequence_path=imgDir;%文件路径
    img_path = [sequence_path 'imgs/'];
    %% Read files 
    guroundtruth = csvread([sequence_path 'groundtruth.txt']);%序列中真实目标位置
    %%%%%%%%%%%%%%%%%%%%%%%%%
    % read all the frames in the 'imgs' subfolder
    dir_content = dir([sequence_path 'imgs/']);
    % skip '.' and '..' from the count
    n_imgs = length(dir_content) - 2;
    img_files = cell(n_imgs, 1);
    for ii = 1:n_imgs
        img_files{ii} = dir_content(ii+2).name;
    end
%     im = imread([img_path img_files{1}]);%读取目标帧
%     im= rgb2gray(im);%转换为灰度图
%     imshow(im);
end