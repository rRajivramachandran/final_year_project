% 
%     {{Caserel}}
%     Copyright (C) {{2013}}  {{Pangyu Teng}}
% 
%     This program is free software; you can redistribute it and/or modify
%     it under the terms of the GNU General Public License as published by
%     the Free Software Foundation; either version 2 of the License, or
%     (at your option) any later version.
% 
%     This program is distributed in the hope that it will be useful,
%     but WITHOUT ANY WARRANTY; without even the implied warranty of
%     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
%     GNU General Public License for more details.
% 
%     You should have received a copy of the GNU General Public License along
%     with this program; if not, write to the Free Software Foundation, Inc.,
%     51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
%

%   
%
%   This example script demonstrates the usage of CASEREL
%
%   Section 1, loads the path of the image.
%   Section 2, automatically segments the retinal layers based on graph theory.
%   Section 3, using a GUI, iterate through the segmentation results,
%              and maually or semi-automatically correct the segmented
%              retainl layers.
%   Section 4, calculate and print out retinal thickness (in pixels)
%
%   $Created: 1.0 $ $Date: 2013/09/09 20:00$ $Author: Pangyu Teng $
%   $Revision: 1.1 $ $Date: 2013/09/15 21:00$ $Author: Pangyu Teng $

close all;clear all;clc;
%lderPath '\exampleOCTimage0001.tif'];
    img=imread('exampleOCTimage0002.tif');
    
    
    [retinalLayers, params] = getRetinalLayers(img,params)
%% Section 2, automatically segments the retinal layers based on graph theory.

