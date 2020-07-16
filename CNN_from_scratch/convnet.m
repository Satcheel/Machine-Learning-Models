function [dfilter1,dfilter2,dfilter3,dcbias1,dcbias2,dcbias3,dtheta1,dtheta2,dbias1,dbias2] = convnet(image,filter1,filter2,filter3,cbias1,cbias2,cbias3,theta1,theta2,bias1,bias2,label)
	%[w,h,c] = size(image);
	conv1 = conv(image,filter1,cbias1);
	pool1 = pool(conv1,2);
	conv2 = conv(pool1,filter2,cbias2);
	pool2 = pool(conv2,2);
	conv3 = conv(pool2,filter3,cbias3);
	pool3 = pool(conv3,2);
	[wf,hf,cf] = size(pool3);
	fc = reshape(pool3,wf*hf*cf,1);
	fc1 = theta1*fc+bias1;
	softm = theta2*fc1+bias2;
	output = softm>0;
	%%if label num = output acc is 1

	dfc2 = output-label;
	%dfc2 = theta2'*dout;
	dtheta2 = (dfc2*fc1')';
	dbias2 = reshape(sum(dfc2')',10,1);
	dfc1 = theta2'*dfc2;
	dtheta1 = (dfc1*fc')';
	dfc = theta1'*dfc1;
	dbias1 = reshape(sum(dfc1')',size(bias1));
	dpool3 = reshape(dfc,wf,hf,cf);
	dconv3 = dpool(dpool3,conv3,2);
	[dpool2,dfilter3,dcbias3] = dconv(dconv3,filter3,pool2,cbias3);
	dconv2 = dpool(dpool2,conv2,2);
	[dpool1,dfilter2,dcbias2] = dconv(dconv2,filter2,pool1,cbias2);
	dconv1 = dpool(dpool1,conv1,2);
	[~,dfilter1,dcbias1] = dconv(dconv1,filter1,image,cbias1);
end


%%adding relu,bias in conv dfilter,dbias in dconv