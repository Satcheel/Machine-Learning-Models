function [j,acc,dfilter1,dfilter2,dcbias1,dcbias2,dtheta1,dtheta2,dbias1,dbias2] = convnet2(image,filter1,filter2,cbias1,cbias2,theta1,theta2,bias1,bias2,label)
	%[w,h,c] = size(image);
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
	output = softm>0;
    [~,i1] = max(output); [~,i2] = max(label);
	if i1==i2
        acc = 1;
    else
        acc = 0;
    end
	dfc2 = output-label;
    j = (1/2)*sum(dfc2.^2);
    
	%dfc2 = theta2'*dout;
	dtheta2 = (dfc2*fc1');
	dbias2 = dfc2;
	dfc1 = theta2'*dfc2;
	dtheta1 = (dfc1*fc');
	dfc = theta1'*dfc1;
	dbias1 = dfc1;
	dpool2 = reshape(dfc,wf,hf,cf);
    %size(dpool2)
	%dconv3 = dpool(dpool3,conv3,2);
	%[dpool2,dfilter3,dcbias3] = dconv(dconv3,filter3,pool2,cbias3);
	dconv2 = dpool(dpool2,conv2,2);
    %size(dconv2)
	[dpool1,dfilter2,dcbias2] = dconv(dconv2,filter2,pool1);
    %size(dpool1)
	dconv1 = dpool(dpool1,conv1,2);
    %disp(size(dconv1))
	[~,dfilter1,dcbias1] = dconv(dconv1,filter1,image);
end

