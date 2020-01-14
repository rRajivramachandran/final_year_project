% /* Pierrick Coupe - pierrick.coupe@gmail.com                               */
% /* Brain Imaging Center, Montreal Neurological Institute.                  */
% /* Mc Gill University                                                      */
% /*                                                                         */
% /* Copyright (C) 2008 Pierrick Coupe                                       */
%
%
%
% /*                 Details on Bayesian NLM filter                         */
% /***************************************************************************
%  *  The bayesian NLM filter is described in:                               *
%  *                                                                         *
%  * P. Coupe, P. Hellier, C. Kervrann, C. Barillot.                         *
%  * NonLocal Means-based Speckle Filtering for Ultrasound Images.           *
%  * IEEE Transactions on Image Processing, 18(10):2221-9, 2009.             *
%  ***************************************************************************/
%
%
% /*                 Details on blockwise NLM filter                        */
% /***************************************************************************
%  *  The blockwise NLM filter is described in:                              *
%  *                                                                         *
%  *  P. Coupe, P. Yger, S. Prima, P. Hellier, C. Kervrann, C. Barillot.     *
%  *  An Optimized Blockwise Non Local Means Denoising Filter for 3D Magnetic*
%  *  Resonance Images. IEEE Transactions on Medical Imaging, 27(4):425-441, *
%  *  Avril 2008                                                             *
%  ***************************************************************************/
%
%
%
% /*                 This method is patented as follows                     */
% /***************************************************************************
% * P. Coupe, P. Hellier, C. Kervrann, C. Barillot. Dispositif de traitement *
% * d'images ameliore. INRIA, Patent: 08/02206, 2008.                        *
% * Publication No. : WO/2009/133307.                                        *
% * International Application No. : PCT/FR2009/000445                        *
% *                                                                          *
%  ***************************************************************************/

function Denoise(path_src, path_dest)

%params
M = 7;      % search area size (2*M + 1)^2
alpha = 3;  % patch size (2*alpha + 1)^2
h = 2.7;    % smoothing parameter [0-infinite].
% If you can see structures in the "Residual image" decrease this parameter
% If you can see speckle in the "denoised image" increase this parameter

offset = 100; % to avoid Nan in Pearson divergence computation
% According to the gain used by your US device this offset can be adjusted.


    
   
    
    
    
    
 
        
        img = imread(path_src);
        
%             img = rgb2gray(img);
        
        
        % Intensity normalization
        imgd = double(img);
        mini = (min(imgd(:)));
        imgd = (imgd - mini);
        maxi = max(imgd(:));
        imgd = (imgd / maxi) * 255;
        imgd = imgd + offset; % add offset to enable the pearson divergence computation (i.e. avoid division by zero).
        s = size(imgd);
        
        % Padding
        imgd = padarray(imgd,[alpha alpha],'symmetric');
        fimgd=bnlm2D(imgd,M,alpha,h);
        fimgd = fimgd - offset;
        imgd = imgd - offset;
        imgd = imgd(alpha+1: s(1)+alpha, alpha+1: s(2)+alpha);
        fimgd = fimgd(alpha+1: s(1)+alpha, alpha+1: s(2)+alpha);
        
        % Display
        minds = min(imgd(:));
        maxds = max(imgd(:));
        dimg = mat2gray(fimgd,[minds maxds]);
        
        imwrite(dimg,path_dest,'png');
end
        
              
  
        

