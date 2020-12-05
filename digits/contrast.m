% Calculate the contrast of a dataset of vectorized images stored in matrix X
% Each line is an image 20x20
% Method: 	minmax: global max-min; a global measure; dependent on noise
%		std:	use st.dev.; global, robust to noise
% 		local:	average local contrast.  

function C=contrast(X,method)
switch method
    
 case 'minmax'                  % Global contrast, too-much sensitive to noise
   C=max(X,[],2)-min(X,[],2);

 case 'std'                     % Global contrast based on average difference from mean
   C=std(X,[],2);
   
 case 'local'                   % Average local contrast
   C=zeros(size(X,1),1);
   F=[-1,-1,-1;-1,8,-1;-1,-1,-1]/8;
   for i=1:size(X,1)
     dIMG=conv2(reshape(X(i,:),20,20),F,'same'); % Convolve each image with a differential spatial filter
     dIMG=abs(dIMG(:));         % vectorize and abs. values
     C(i)=mean(dIMG(dIMG>0));	% Contrast as the average non-zero differences (to consider only true effective objects)
   end
   
end
C=C/max(C);                     % normalize contrast to 1
end
