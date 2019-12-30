function [ ratio ] = estimatePar( img )
%ESTIMATEPAR estimates the constant ratio between the standard deviation
%and mean of homogeneous regions in OCT data


% select a homogeneous area

region = img;

ratio = std(region(:),1)/mean(region(:));


end

