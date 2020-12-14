% N: MLP structure
% X: Input data (the features of each pattern)
% T: Target data
function N=mlp_backprop(N,X,T)
 lc=N.lc;            		% Learning coefficient
 mc=N.mc;                       % Momentum coefficient
 
 if isfield(N.par,'trnoise')                   
   G=randn(size(X))*N.par.trnoise;% gaussian noise
   X=max(0,min(1,X+G));         % rectify
 end
 
 [Y,H,X]=mlp_activate(N,X);     % Activate the MLP on data
                                % Eventually replace X with pre-processed X
 % Gradients Output layer
 oE=T-Y;                        % Errors at the output layer 
 dY = oE.*df(Y,N.ofun);         % Gradients at the output layer
 dW = (H'*dY);                  % Weight change
 dB = sum(dY);                  % change of bias
  
 N.dow=mc*N.dow + (1-mc)*dW;    % Momentum of weights gradient
 N.dob=mc*N.dob + (1-mc)*dB;    % momentum of bias gradient
 
 % Gradients Hidden Layer
 hE=(dY*N.ow');                 % Errors at the hidden layer (propoagated from top layer)
 dY = hE.*df(H,N.hfun);         % Gradients at the hidden layer  
 dW = (X'*dY);                  % Weigh changes 
 dB = sum(dY);                  % change of bias
 
 N.dhw=mc*N.dhw + (1-mc)*dW;    % Momentum of weight gradient
 N.dhb=mc*N.dhb + (1-mc)*dB;    % momentum of bias gradient
 
 % Weight updates
 N.ow = N.ow + lc * N.dow;      % ow: [nh,no]
 N.ob = N.ob + lc * N.dob;      % ob  [1 ,no] 
 N.hw = N.hw + lc * N.dhw;      % hw  [in,nh]
 N.hb = N.hb + lc * N.dhb;      % hb  [1 ,nh]
 
 % Learning statistics
 N.e=mean(abs(oE(:)));          % Average error over all output units and all data
 N.lepochs=N.lepochs+1;         % Add the number of epochs so far
 N.lpatterns=N.lpatterns+size(X,1); % Total number of learning patterns
end

function dY=df(Y,f)
  switch f
    case 'sig', dY=Y.*(1-Y);    % Sigmoid
    case 'rlu', dY=double(Y>0);       % RLU: 1 for positives, 0 otherwise
  end
end
