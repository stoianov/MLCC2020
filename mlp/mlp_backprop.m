% N: MLP structure
% X: Input data (the features of each pattern)
% T: Target data
function N=mlp_backprop(N,X,T)
 lc=N.lc;                       % Learning coefficient
 mc=N.mc;                       % Momentum coefficient
 
 [Y, H]=mlp_activate(N,X);      % Activate the MLP on data
 
 oE=T-Y;                        % Errors at the output layer 
 dY = oE.*Y.*(1-Y);             % Deltas at the output layer
 dW = (H'*dY);                  % Weight change
 dB = sum(dY);                  % change of bias
  
 N.dow=mc*N.dow+(1-mc)*dW;      % Momentum term (weights)
 N.dob=mc*N.dob+(1-mc)*dB;      % momentum of bias
 
 N.ow = N.ow + lc * N.dow;      % ow: [nh,no]
 N.ob = N.ob + lc * N.dob;      % ob  [1 ,no]
 
 hE=(dY*N.ow');                 % Errors at the hidden layer (propoagated from top layer)
 dY = hE.*H.*(1-H);             % Deltas at the hidden layer  
 dW = (X'*dY);                  % Weigh changes 
 dB = sum(dY);                  % change of bias
 
 N.dhw=mc*N.dhw+(1-mc)*dW;      % Momentum term of weights
 N.dhb=mc*N.dhb+(1-mc)*dB;      % momentum of bias
 
 N.hw = N.hw + lc * N.dhw;      % hw  [in,nh]
 N.hb = N.hb + lc * N.dhb;      % hb  [1 ,nh]
 
 N.e=mean(abs(oE(:)));          % Average error over all output units and all data
 N.lepochs=N.lepochs+1;         % Add the number of epochs so far
 N.lpatterns=N.lpatterns+size(X,1); % Total number of learning patterns

end
