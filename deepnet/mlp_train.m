% N: MLP structure
% X: Input data (the features of each pattern)
% T: Target data (desired output activations for each input patterns)
% epochs: number of learning epochs

function N = mlp_train(N,X,T,epochs)
  ntr=size(X,1);                % Number of training patterns
  nba=ceil(ntr*N.par.batchfr);  % Number of training samples per batch
  E = zeros(epochs,1);          % Container for the error

  for i= 1:epochs               % iterative training
    Iba=randperm(ntr,nba);      % Random subset (batch) of the entire dataset
    N=mlp_backprop(N,X(Iba,:),T(Iba,:)); % Back-prop on the batch
    E(i)=N.e;                   % store the error
  end
  
  N.E=[N.E; E];                 % Store the training error
end
