function N=rbn_train(N,layer,X)

  npat=size(X,1);                       % number of patterns to train on
  lc=N.par.lc/npat;                     % Learning coeff. normalized
  mc=N.par.mc;                          % Momentum term
  dec=N.par.dec*N.par.lc;               % Fraction of weight decay to match the learning coefficient

  % Positive phase: bottom-up activation on data X
  Y=layer_activate(N.W{layer},N.B{layer},X,N.actfun); % Sigmoid unit activations, given input signal X 
  Ybin=Y>rand(size(Y));                % Probabilistic sampling (to be used in the negative phase)
  
  poscor=X'*Y;                        	% Input-Unit Correlations in the positive phase
  posgB=sum(X);                        	% +corr genBias
  posB=sum(Y);                          % +corr unitBias
  
  % Negative phase (top-down and bottom-up activations) 
  X1=layer_activate(N.W{layer}',N.gB{layer},Ybin,N.actfun);% Generative (input) activation given the unit activity from the positive fase  
  Y1=layer_activate(N.W{layer},N.B{layer},X1,N.actfun);  % Activate the layer on the data  
  
  negcor=X1'*Y1;                        % Input-Unit Correlations in the negative phase
  neggB=sum(X1);                        % -corr genBias
  negB=sum(Y1);                         % -corr unitBias

  % Weight Increments (momentum + delta-Corr - weight-decay)
  N.dW {layer} = mc * N.dW {layer} + (1-mc) * (poscor - negcor) ;
  N.dgB{layer} = mc * N.dgB{layer} + (1-mc) * ( posgB -  neggB) ;
  N.dB{layer}  = mc * N.dB{layer}  + (1-mc) * (  posB -   negB) ;
  
  % Update the weights with the increments
  N.W{layer}  = N.W{layer}  + lc * N.dW{layer}  - dec * N.W{layer};  
  N.gB{layer} = N.gB{layer} + lc * N.dgB{layer} - dec * N.gB{layer};  
  N.B{layer}  = N.B{layer}  + lc * N.dB{layer}  - dec * N.B{layer};
end