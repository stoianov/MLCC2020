function n = n_sample(m,s,e)
  X=[ ];  
  d=Inf;
  % Iteratively sample from a normal distribution and expand the set X
  while d>e 				% While distance d is greater than e ...
     r=randn*s+m;			% draw from a gaussian distribution N(m,s)
     X=[X r];				% add r to the series X 
     d=abs(mean(X)-m);      % calculate the distance btw set average and M
   end
   n=numel(X);
end