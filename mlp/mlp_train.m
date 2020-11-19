% N: MLP structure
% X: Input data (the features of each pattern)
% T: Target data (desired output activations for each input patterns)
% epochs: number of learning epochs

function N = mlp_train(N,X,T,epochs)
  E = zeros(epochs,1);          % Container for the error

  for i= 1:epochs               % iterative training
    I=find(rand(size(T))<1);  % Mini-batch 20%    
    N=mlp_backprop(N,X(I,:),T(I,:));% Back-prop on all data
    E(i)=N.e;                   % store the error
  end
  
  N.E=[N.E; E];                 % Store the training error

end
