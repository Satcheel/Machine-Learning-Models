function prediction = predict(image)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
load('coeffs.mat','filter1','filter2','cbias1','cbias2','theta1','theta2','bias1','bias2');
% images = loadMNISTImages(imagefile);
% images = reshape(images,28,28,60000);
% labels = loadMNISTLabels(labelfile);
% labels = [labels==0,labels==1,labels==2,labels==3,labels==4,labels==5,labels==6,labels==7,labels==8,labels==9];
% image = images(:,:,1);
% label = label(1,:);
conv1 = conv(image,filter1,cbias1);
pool1 = pool(conv1,2);
conv2 = conv(pool1,filter2,cbias2);
pool2 = pool(conv2,2);
%conv3 = conv(pool2,filter3,cbias3);
%pool3 = pool(conv3);
[wf,hf,cf] = size(pool2);
fc = reshape(pool2,wf*hf*cf,1);
fc1 = theta1*fc+bias1;
softm = theta2*fc1+bias2;
prediction = softm>0
%[prop,prediction] = max(output); [~,i2] = max(label);
% if i1==i2
%     acc = 1;
% else
%     acc = 0;
% end
end

