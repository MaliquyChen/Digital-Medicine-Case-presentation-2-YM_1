function output = dicompreprocess(filename)

% Code for Simple CNN model
dcm = dicomread(filename);
dcm = imresize(dcm,[1024 1024]);
dcm = mat2gray(dcm);
dcm = histeq(dcm);
Files = readtable('Files.csv');
Files = Files(:,1);
Files = table2cell(Files);
idx = find(contains(Files,filename));
BD = readtable('BD2.csv');
BD = table2array(BD);
if BD(idx)==0
    dcm = 1-dcm;
end

dcm1 = HPF(dcm,1);
dcm2 = HPF(dcm,1);
BW = Itersplit(dcm2);
% dcm = ones(1024);
% dcm(BW)=0;
mask = masker(BW);
mask = im2double(mask);
dcm = im2double(dcm1);
dcm = dcm.*mask;
dcm = uint8(dcm*256);

% dcm_resize = imresize(dcm,[1024 1024]);
% output = dcm_resize;

% % Code for Transfer Learning Model
dcm_resize = imresize(dcm,[224 224]);
output = cat(3,dcm_resize,dcm_resize,dcm_resize);
% 
end