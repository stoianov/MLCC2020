%% MLP as universal function approximator

% We will learn the function (x-0.5)^2 + (y-0.5)^2) 
X=rand(1000,2);
T=(X(:,1)-0.5).^2 + (X(:,2)-0.5).^2;

% Visualize the input-output data
figure(1);

subplot(2,2,1);   
  plot3(X(:,1),X(:,2),T,'.');
  title('Data');

% Init a network with 2 input units, 10 hidden units, one output unit. 
N=mlp_init([2 50 1]);  

% Visualize the activation before training
subplot(2,2,2); 
  Y=mlp_activate(N,X);
  plot3(X(:,1),X(:,2),Y,'.');
  title('Random Network');

% Train the network for 100 steps
N=mlp_train(N,X,T,1000);

% Show graphically the learning trend
subplot(2,2,3); 
  plot(N.err);
  title('Learning error');
  
% Show graphically the learning trend
subplot(2,2,4); 
  Y=mlp_activate(N,X);
  plot3(X(:,1),X(:,2),Y,'.');
  title('Trained network');
  