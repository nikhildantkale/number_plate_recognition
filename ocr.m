function [a]=ocr(imagen)
if length(size(imagen))==3
    imagen = rgb2gray(imagen);
end
imagen = ~imagen
imagen = bwareaopen(imagen,50)
%imagen = ~imagen

imshow(imagen)
title('INPUT IMAGE WITH NOISE')

if length(size(imagen))==3 %RGB image
    imagen=rgb2gray(imagen);
end
imagen = medfilt2(imagen);
[f c]=size(imagen);
imagen (1,1)=255;%next 4 to remove corner noise
imagen (f,1)=255;
imagen (1,c)=255;
imagen (f,c)=255;
imshow(imagen);

word=[];%Storage matrix word from image
x=[];
re=imagen;
fid = fopen('text.txt', 'at');%Opens text.txt as file for write and Open or create new file for writing. Append data to the end of the file.
while 1
    [fl re]=lines(re)%Fcn 'lines' separate lines in text
    imgn=~fl;
   
       imshow(fl);pause(1)
   
    L = bwlabel(imgn);
    mx=max(max(L));%no.of objects
    BW = edge(double(imgn),'sobel');
    [imx,imy]=size(BW);
    for n=1:mx
        [r,c] = find(L==n);
        rc = [r c];
        [sx sy]=size(rc);
        n1=zeros(imx,imy);
        for i=1:sx
            x1=rc(i,1);
            y1=rc(i,2);
            n1(x1,y1)=255;
        end
        
        n1=~n1;
        n1=~clip(n1);
        size(n1)
        img_r=same_dim(n1);%Transf. to size 42 X 24
       
        imshow(img_r);pause(1)
        
       letter=read_letter(img_r);%img to text
       if letter~=13
           word=[word letter];
           x=[x word];
       end
    end
   
   if length(word)>=2
       fprintf(fid,'Number Plate:-%s\nDate:-%s\n',word,date);%Write 'word' in text file (upper)
    end
    word=[];%Clear 'word' variable
    if isempty(re)  %See variable 're' in Fcn 'lines'

        %start
word=checkst(x,re);
       fprintf(fid,'Number Plate:-%s\nDate:-%s\n',word,date);%Write 'word' in text file (upper)

%end
     break
    end
end
fclose(fid);
a=1;