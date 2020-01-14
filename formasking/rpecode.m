clc;
clear all;
close all;


s=zeros(1,15);
s2=s;
s3=s;
for ab=1:1:1
    %abn=sprintf('%d',ab);
    filepath=strcat('/home/rajiv/Desktop/fyp/formasking/testing/');

a = dir(fullfile(filepath, '*.TIFF'));
n = numel(a);

name=strings(n,1);
f=strings(n,1);
%warning('off','all');
abc=0;
def=0;


 for txt=1:1:n

t=sprintf('Image %d.TIFF',txt);
 filename=t

In_img = imread(strcat(filepath, filename));

[m,n]=size(In_img);

        
        %Lgray=Lgray(k:m,:);
       In_img(In_img==255)=0;

In_img=double(In_img)/255; 
img1=In_img; 
filt_img=medfilt2(img1,[5 5]); 
filt_img=mat2gray(filt_img); 


%highest pixel value detection in each column
x=(1:n)';
y=(1:m)';
rpe_y=[];
new_img=zeros(m,n);
for i=1:n  
    highest_pix=[]; 
    label_img=bwlabel(filt_img(:,i)>(max(filt_img(:,i))*0.9));  
    new_img(:,i)=label_img; 
    for j=1:max(label_img) 
        pix=y(label_img==j);   
        highest_pix=[highest_pix;mean(pix)] ; 
    end
    if ~isempty(highest_pix)     
        rpe_y(i)=max(highest_pix);  
    else
        rpe_y(i)=0;   
    end
end
% figure; 
% imshow(mat2gray(new_img*0.5+filt_img));
% hold on;
% plot(rpe_y,'r*-');
     
     
     rpe_img=new_img;
     dy=gradient(rpe_y);
     dy2=ones([1 length(rpe_y)]); 
     dy2(abs(dy)>20)=0; 
     dy3=bwlabel(dy2); 
%      figure; 
%      imshow(mat2gray(rpe_img*0.5+filt_img));
%      hold on;  
%      palett=jet(max(dy3)); 
%      for k=1:max(dy3(:))        
%          plot(x(dy3==k), rpe_y(dy3==k),'Color',palett(k,:),'LineWidth',4); 
%      end
     pam_dl=[];
%      figure; 
%      imshow(mat2gray(Lbinrpe*0.5+Lmed)); 
%      hold on 
     for i1=1:max(dy3(:)) 
         for j1=i1:max(dy3(:))  
             if i1<=j1           
                 ygk=[rpe_y(dy3==i1),rpe_y(dy3==j1)];   
                 xgk=[x(dy3==i1);x(dy3==j1)];       
             else
                 ygk=[rpe_y(dy3==j1),rpe_y(dy3==i1)];
                 xgk=[x(dy3==j1);x(dy3==i1)];  
             end
             if length(ygk)>10   
                 P = polyfit(xgk',ygk,2); 
                 yrpes = round(polyval(P,x)); 
%                  plot(yrpes,'g*-')
     pam_dl=[pam_dl;[i1 j1 sum((abs(rpe_y-yrpes')<20))]];    
             end
         end
     end
     pam_s=sortrows(pam_dl,-3);
     if size(pam_s,1)==1   
         ygk=[rpe_y(dy3==pam_s(1,1))];      
         xgk=[x(dy3==pam_s(1,1))]; 
     else
         ygk=[rpe_y(dy3==pam_s(1,1)),rpe_y(dy3==pam_s(1,2))]; 
         xgk=[x(dy3==pam_s(1,1));x(dy3==pam_s(1,2))]; 
     end
     P = polyfit(xgk',ygk,2);
     yrpes = round(polyval(P,x));   
%      plot(x,yrpes,'w*-'); 
     rpe_y=rpe_y(:);     
%      plot(x,yrpe,'m*-');
     dx=x; 
     dx(abs(rpe_y-yrpes)>20)=[]; 
     rpe_y(abs(rpe_y-yrpes)>20)=[];
     dxl=bwlabel(diff(dx)<125); 
     pdxl=[]; 
     for qw=1:max(dxl)    
         pdxl=[pdxl;[qw, sum(dxl==qw)]]; 
     end
     pdxl(pdxl(:,2)<50,:)=[]; 
     dxx=[]; dyy=[]; 
     for wq=1:size(pdxl,1)    
         dxx=[dxx; dx(dxl==pdxl(wq,1))];    
         dyy=[dyy; rpe_y(dxl==pdxl(wq,1))]; 
     end
     dx=dxx; 
     rpe_y=dyy;     
%      plot(dx,yrpe,'c-');
% figure;
 imshow(In_img); 
 hold on
 sprintf("%d iter",txt)    
 plot(dx,rpe_y,'r-');

 saveas(gcf,sprintf('/home/rajiv/Desktop/fyp/formasking/rpe/%d.png',txt),'png'); 
%   figure;plot(dx,rpe_y);
name(txt)=strcat(filepath, filename);
  std_dev(txt)=std(rpe_y);
  if(std_dev(txt)>11)
      %sprintf('AMD affected\n');
      %sprintf('\n') ;
      f(txt)='Affected';
      abc=abc+1;
  else
      %sprintf('Not affected\n');
     % sprintf('\n') ;
     f(txt)='Not affected';
     def=def+1;
    
  end
  
 end
 %std_dev;
 %f;
 s(ab)=abc;
 s2(ab)=abc+def;

 
 VarNames = {'Serial_no', 'image_name', 'Result'};
T = table((1:1:txt)',name,f, 'VariableNames',VarNames);
%writetable(T,strcat('normal',abn,'.txt'));
end
 s3=s./s2;
 VarNames = {'Serial_no', 'Properly_detected_images', 'Total_images','Percentage'};
%T = table((1:1:ab)',s',s2',(s3*100)', 'VariableNames',VarNames)