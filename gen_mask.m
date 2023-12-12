function gen_mask(indir,outdir,a)
% 隨機生成遮罩
% 指定图像文件夹路径
imageFolderPath = indir;

% 获取文件夹内所有图像文件
imageFiles = dir(fullfile(imageFolderPath, '*.png'));  % 假设图像格式为JPEG，根据实际情况修改
% 生成新的文件夾
new_folder = outdir;
mkdir(new_folder);
addpath(new_folder);
% 遍历每个图像文件
for i = 1:length(imageFiles)
    % 构建当前图像的完整文件路径
    currentImagePath = fullfile(imageFolderPath, imageFiles(i).name);
    [~,fileName, format] = fileparts(currentImagePath);
    % 读取图像
    originalImage = imread(currentImagePath);
    [height, width, ~] = size(originalImage);
    % 生成1到3个随机位置
        numBlocks = randi([1, 5]);
        for j = 1:numBlocks
            % 随机生成方块的位置
            x = randi([1, height-a ]);
            y = randi([1, width-a ]);

            % 在图像上绘制白色方块
            originalImage(y:y+a, x:x+a, 1) = 255; % 红色通道
            originalImage(y:y+a, x:x+a, 2) = 255; % 绿色通道
            originalImage(y:y+a, x:x+a, 3) = 255; % 蓝色通道
        end
    originalImage = rgb2gray(originalImage);
    % 将像素值不等于255的像素设置为0（黑色）
    originalImage(originalImage ~= 255) = 0;
    % 构建保存旋转后图像的文件路径
    flippedImagePath = fullfile(new_folder, [fileName,'_mask',format]);
    
    % 保存旋转后的图像
    imwrite(originalImage, flippedImagePath);
   
end

end