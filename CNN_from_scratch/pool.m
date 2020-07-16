function [output] = pool(input,s)
%DPOOL Summary of this function goes here
%   Detailed explanation goes here
[w,h,c] = size(input);
w1 = w/s;
h1 = h/s;
output = zeros(w1,h1,c);
m = [];
for jj = 1:c
    for i = 1:s:w
        for j = 1:s:h
            temp = input(i:i+s-1,j:j+s-1,jj);
            m = max(temp(:));
            %[x,y] = ind2sub(size(temp),ind);
            output((i+1)/s,(j+1)/s,jj) = m;
        end
    end
end

    
end

