function N=dbn_train(N,X,epochs,batch)

 for layer=2:N.nlayers,  
  fprintf('\nTRAIN Layer %d ',layer);  
  for i=1:epochs,        
    if ~rem(i,1000), fprintf('k'); end % Print 'k' every 1000 epochs
    Iba=randperm(size(X,1),batch);  % Random subset(batch) of training data           
    Xba=X(Iba,:);                   % Get a batch of training patterns
    if layer==2 && N.par.trnoise>0  % Add noise to the sensory data
      noise=randn(size(Xba))*N.par.trnoise; % Generate gaussian noise
      Xba=max(0,min(1,Xba+noise));  % Add the noise to the input, and rectify
    end
    N=rbn_train(N,layer,Xba);       % Train the layer on this pattern    
  end
  X=layer_activate(N.W{layer},N.B{layer},X,N.actfun); % Activate the layer on the data, to produce inputs for the next layer
 end

 N.History=[N.History;sprintf('Trained for %d epochs on batches of size %d',epochs,batch)];
 fprintf(' .. Done \n');
end
