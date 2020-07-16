function [J,Acc,filter1,filter2,filter3,cbias1,cbias2,cbias3,theta1,theta2,bias1,bias2] = final(imagefile,labelfile)
	images = loadimages(imagefile);
	labels = loadlabels(labelfile);
	f = 3;
	lr = 0.0001;
	filter1 = rand(4,f,f,c);
	filter2 = rand(8,f,f,4);
	filter3 = rand(16,f,f,8);
	cbias1 = zeros(124,124,4);
	cbias2 = zeros(60,60,8);
	cbias3 = zeros(28,28,16);
	theta1 = rand(512,3136);
	theta2 = rand(10,512);
	bias1 = zeros(512,1);
	bias2 = zeros(10,1);
	J = [];
	for e = 1:20
		tacc = 0;
		for i = 1:length(images)
			image = images(i,:,:);
			label = labels(i,:); %%
			[j,acc,dfilter1,dfilter2,dfilter3,dcbias1,dcbias2,dcbias3,dtheta1,dtheta2,dbias1,dbias2] = convnet(image,filter1,filter2,filter3,cbias1,cbias2,cbias3,theta1,theta2,bias1,bias2,label);
			filter1 = filter1 - lr*dfilter1;
			filter2 = filter2 - lr*dfilter2;
			filter3 = filter3 - lr*dfilter3;
			cbias1 = cbias1 - lr*dcbias1;
			cbias2 = cbias2 - lr*dcbias2;
			cbias3 = cbias3 - lr*dcbias3;
			theta1 = theta1 - lr*dtheta1;
			theta2 = theta2 - lr*dtheta2;
			bias1 = bias1 - lr*dbias1;
			bias2 = bias2 - lr*dbias2;
			J = [J;j];
			tacc = tacc + acc;
		end
		Acc = [Acc;tacc/length(images)];
	end
	subplot(2,1,1);
	plot(J);
	subplot(2,1,2);
	plot(Acc);
	save('coeffs.mat');

end



%%add cost to convnet