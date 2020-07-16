function [output,dfilter,dbias] = dconv(dinput,filter,input)
%DCONV Summary of this function goes here
%   Detailed explanation goes here
s=1;
[w,h,l] = size(dinput);
[~,f,~,c] = size(filter);
w1 = (w-1)*s+f;
h1 = (h-1)*s+f;
output = zeros(w1,h1,c);
dfilter = zeros(l,f,f,c);

for jj = 1:l
    for i = 1:w
        for j = 1:h
            output(i:i+f-1,j:j+f-1,:) = output(i:i+f-1,j:j+f-1,:) + dinput(i,j,jj)*reshape(filter(jj,:,:,:),f,f,c);
	        dfilter(jj,:,:,:) = dfilter(jj,:,:,:) + dinput(i,j,jj)*reshape(input(i:i+f-1,j:j+f-1,:),[1,size(input(i:i+f-1,j:j+f-1,:))]);
        end
    end
    %dbias(jj) = input(jj)
end
dbias = dinput;
size(dfilter);

end

%            dfilter(jj,:,:,:) = dfilter(jj,:,:,:) + filter(jj,i,j)*conv(i:i+f,j:j+f,:)
%		dbias(jj) = sum(dconv2(jj)