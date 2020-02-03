function imgn=clip(imagen)
if ~islogical(imagen)
    imagen=im2bw(imagen,0.99);
end
a=~imagen;
figure(11),imshow(a);
[f c]=find(a);%non zero row indices in f and col indices in c 
lmaxc=max(c);lminc=min(c);
lmaxf=max(f);lminf=min(f);
imgn=a(lminf:lmaxf,lminc:lmaxc);%Crops image
figure(12),imshow(imgn);
