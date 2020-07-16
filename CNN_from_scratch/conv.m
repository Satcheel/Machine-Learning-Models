function [output] = conv(input,filter,cbias)
%CONV Summary of this function goes here
%   Detailed explanation goes here
s=1;
[w,h,c] = size(input);
[l,f,~,~] = size(filter);
w1 = (w-f)/s+1;
h1 = (h-f)/s+1;
output = zeros(w1,h1,l);

for jj = 1:l
    for i = 1:s:w1
        for j = 1:s:h1
            output(i,j,jj) = sum(reshape(filter(jj,:,:,:),f,f,c).*input(i:i+f-1,j:j+f-1,:),'all');
        end
    end
end
output = output + cbias;
output = (output>0).*output;

end

