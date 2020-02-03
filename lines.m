function [fl re]=lines(aa)
%Divide text in lines.
aa=clip(aa);
r=size(aa,1);%no. of rows
for s=1:r
    if sum(aa(s,:))==0 %all ele of resp row
        nm=aa(1:s-1,1:end);%First line matrix
        rm=aa(s:end,1:end);%Remain line matrix
        fl=~clip(~nm);
        re=~clip(~rm);
       
                 figure,imshow(fl);
                 figure,imshow(re);
        break
    else
        fl=~aa;%Only one line.
        re=[];
    end
end