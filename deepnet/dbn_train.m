function N=dbn_train(N,X,epochs)
 ntr=size(X,1);
 nba=ceil(ntr*N.par.batchfr);   % Number of training samples per batch

 for layer=2:N.nlayers,  fprintf('TRAIN Layer %d ',layer);  
  for i=1:epochs
    Iba=randperm(ntr,nba);      % Random subset(batch) of training data           
    Xba=X(Iba,:);               % Get a batch of training patterns
    if layer==2                 % Add noise to the sensory data
      noise=randn(size(Xba))*N.par.trnoise; % Generate gaussian noise
      Xba=max(0,min(1,Xba+noise));% Add the noise to the input, and rectify
    end
    N=rbn_train(N,layer,Xba);   % Train the layer on this pattern    
  end
  X=layer_activate(N.W{layer},N.B{layer},X,N.actfun); % Activate the layer on the data, to produce inputs for the next layer
 end
end