function topl(src_path,dst_path)
fil_list=dir(src_path);
    for k=3:length(fil_list)
       imagePath{k-2}=[src_path fil_list(k).name];
    
img=imread(imagePath{k-2});
img=imgaussfilt(img,0.5)
len=zeros(1,496);
str_pt=zeros(1,496);
sprintf("i")
for i=1:496
    start=false;
    %sprintf("i=%d: \n",i);
    for j=1:512
        if(img(j,i)~=0&& ~start)
            start=true;
            st_pt=j;
            %disp(j);
        else
            if(start&&img(j,i)==img(st_pt,i)/2)
                %disp(j)
                len(i)=max(len(i),j-st_pt);
                if(i==3)
                    sprintf("%d %d %d yes",len(i),j-st_pt,st_pt)
                end
                if(j-st_pt>=len(i))
                    str_pt(i)=st_pt;
                end
                start=false;
            end
        end
    end
end
imshow(img)
hold on;
x=[1:496];
plot(x,str_pt,'r*', 'LineWidth', 2, 'MarkerSize', 5)
saveas(gcf,[dst_path fil_list(k).name '_final.png'],'png')
hold off
    end
end

          