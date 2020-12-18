% N: MLP structure
% X: Input data (the features of each pattern)
% T: Target data (desired output activations for each input patterns)
% epochs: number of learning epochs

function N = fclayer_train(N,X,T,epochs)
  ntr=size(X,1);                % Number of training patterns
  nba=N.par.batch;              % Number of training samples per batch
  for i= 1:epochs               % iterative training
    Iba=randperm(ntr,nba);      % Random subset (batch) of the entire dataset
    N=fclayer_optimize(N,X(Iba,:),T(Iba,:)); % Back-prop on the batch
  end
end
