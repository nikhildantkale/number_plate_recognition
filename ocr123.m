function [a]=ocr123(imagen)
if length(size(imagen))==3
    imagen = rgb2gray(imagen);
end
imagen = ~imagen
imagen = bwareaopen(imagen,50)
%imagen = ~imagen
figure(10),imshow(imagen)
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
ncnt=1;
word=[];%Storage matrix word from image
re=imagen;
fid = fopen('nik.xls', 'a+');%Opens text.txt as file for write and Open or create new file for writing. Append data to the end of the file.
%  if ncnt==1
     fprintf(fid,'STATE');%Write 'word' in text file (upper)
    fprintf(fid,'\tCITY');
    fprintf(fid,'\tNUMBER');
    fprintf(fid,'\tDATE');
%     ncnt=2;
%  end
     while 1
    [fl re]=lines(re);%Fcn 'lines' separate lines in text
    imgn=~fl;
   
       figure,imshow(fl);pause(1)
   
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
        img_r=same_dim(n1);%Transf. to size 42 X 24
       
        figure,imshow(img_r);pause(1)
        
       letter=read_letter(img_r);%img to text
       if letter~=13
           word=[word letter];
       end
    end
    if isempty(re)  %See variable 're' in Fcn 'lines'
        break
    end
     end
 fprintf(fid,'\n%s',word(1:2));
    fprintf(fid,'\t%s',word(3:4));
    fprintf(fid,'\t%s',word(5:end));
    fprintf(fid,'\t%s',date);
    
    word=[];%Clear 'word' variable
fclose(fid);
a=1;