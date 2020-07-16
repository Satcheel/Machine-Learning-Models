function [output] = dpool(dinput,input,s)
%DPOOL Summary of this function goes here
%   Detailed explanation goes here
[w,h,c] = size(dinput);
w1 = w*s;
h1 = h*s;
output = zeros(w1,h1,c);
if(isequal(size(output),size(input)))
    for jj = 1:c
        for i = 1:s:w1
            for j = 1:s:h1
                temp = input(i:i+s-1,j:j+s-1,jj);
                [~,ind] = max(temp(:));
                [x,y] = ind2sub(size(temp),ind);
                output(i+x-1,j+y-1,jj) = dinput((i+1)/s,(j+1)/s,jj);
            end
        end
    end
    
end


end

