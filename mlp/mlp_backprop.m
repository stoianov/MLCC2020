% N: MLP structure
% X: Input data (the features of each pattern)
% T: Target data
function N=mlp_backprop(N,X,T)
 lc=N.lc;                       % Learning coefficient
 [Y, H]=mlp_activate(N,X);      % Activate the MLP on data 
 E=T-Y;                         % Errors for each data patterns
 
 dY = E.*Y.*(1-Y);              % Deltas at the output layer
 dW = (H'*dY);                  % Weight change 
 N.ow = N.ow + lc * dW;         % ow: [nh,no]
 N.ob = N.ob + lc * sum(dY);    % ob  [1 ,no]
 
 dH = (dY*N.ow').*H.*(1-H);     % Deltas at the hidden layer  
 dW = (X'*dH);                  % Weigh changes 
 N.hw = N.hw + lc * dW;         % hw  [in,nh]
 N.hb = N.hb + lc * sum(dH);    % hb  [1 ,nh]
 
 N.e=mean(abs(E(:)));           % Average error over all output units and all data
 N.lepochs=N.lepochs+1;         % Add the number of epochs so far
 N.lpatterns=N.lpatterns+size(X,1); % Total number of learning patterns

end
