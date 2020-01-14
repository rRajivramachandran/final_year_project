clc;
clear all;
load Subject_01.mat
  
          
  
       
    % read in the image.
    img = images(:,:,1);
    [trsh rect] = imcrop(img);
    xrange = round(rect(1)):round(rect(1)+rect(3));
    yrange = round(rect(2)):round(rect(2)+rect(4));
    % error checking, get one channel from image.
    if size(img,3) > 1
        img = img(:,:,1);
        display('warning: this is probably not an oct image');
    end
    
    % make image type as double.
    img = double(img);
    
    % get size of image.
    szImg = size(img);
    
    %segment whole image if yrange/xrange is not specified.
    if isempty(yrange) && isempty(xrange)
        yrange = 1:szImg(1);
        xrange = 1:szImg(2);
    end    
    img = img(yrange,xrange);
    
    % get retinal layers.
    [retinalLayers, params] = getRetinalLayers1(img);
    
    % save range of image.
    params.yrange = yrange;
    params.xrange = xrange;
    
    % save data to struct.
    imageLayer(i).imagePath = imagePath{i};
    imageLayer(i).retinalLayers = retinalLayers;    
    imageLayer(i).params = params;



% % save segmentation
 filename = [imageLayer(1).imagePath '_octSegmentation.mat'];
 save(filename, 'imageLayer');
display(sprintf('segmentation saved to %s',filename));

%%   Section 3, using a GUI, iterate through the segmentation results,
%              and maually or semi-automatically correct the segmented
%              retainl layers.

% close all;
% 
% filename = [imagePath{1} '_octSegmentation.mat'];
% 
% isReviewSegmentation = 1;
% if isReviewSegmentation,
%     [h,guiParam] = octSegmentationGUI(filename);   
% 
%     if guiParam.proceed
%         delete(guiParam.figureOCT);
%         delete(h);
%     else
%         return;
%     end    
% end


%%  Section 4, calculate and print out retinal thickness (in pixels)
