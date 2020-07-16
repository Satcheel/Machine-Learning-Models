function [J,Acc,filter1,filter2,cbias1,cbias2,theta1,theta2,bias1,bias2] = final2(imagefile,labelfile)
images = loadMNISTImages(imagefile);
images = reshape(images,28,28,60000);
labels = loadMNISTLabels(labelfile);
labels = [labels==0,labels==1,labels==2,labels==3,labels==4,labels==5,labels==6,labels==7,labels==8,labels==9];
f = 5;
lr = 0.0001;
filter1 = rand(4,f,f,1);
filter2 = rand(8,f,f,4);
cbias1 = zeros(24,24,4);
cbias2 = zeros(8,8,8);
theta1 = rand(64,128);
theta2 = rand(10,64);
bias1 = zeros(64,1);
bias2 = zeros(10,1);
J = [];
Acc = [];
for e = 1:20
    tacc = 0;
    for i = 1:length(images)
        if mod(i,100)==0
            fprintf('Epoch %d Image %d \n',e,i);
        end
        image = images(:,:,i);
        label = labels(i,:)';
        [j,acc,dfilter1,dfilter2,dcbias1,dcbias2,dtheta1,dtheta2,dbias1,dbias2] = convnet2(image,filter1,filter2,cbias1,cbias2,theta1,theta2,bias1,bias2,label);
        size(theta1);
        size(dtheta1);
        filter1 = filter1 - lr*dfilter1;
        filter2 = filter2 - lr*dfilter2;
        cbias1 = cbias1 - lr*dcbias1;
        cbias2 = cbias2 - lr*dcbias2;
        theta1 = theta1 - lr*dtheta1;
        theta2 = theta2 - lr*dtheta2;
        bias1 = bias1 - lr*dbias1;
        bias2 = bias2 - lr*dbias2;
        J = [J;j];
        tacc = tacc + acc;
    end
    
    save('coeffs.mat');
    Acc = [Acc;tacc/length(images)];
    subplot(2,1,1);
    plot(J);
    subplot(2,1,2);
    plot(Acc);
end

save('coeffs.mat');
subplot(2,1,1);
plot(J);
subplot(2,1,2);
plot(Acc);

end



%%add cost to convnet