% DBN
Z=dbn_activate(DN,D.IMG);       % Activate the DBN
Y=single(D.Numerosity>16);      % comparison task on all data
% CLASSIFIER PARAMS
pa2.fun={'inp','sig'};          % Activation functions for each layer. 
pa2.wsd=0.01;                   % spread of weights during initialization
pa2.lc= 0.01;                   % learning coeff.
pa2.mc= 0.7;                    % momentum
pa2.batch=20;                   % fraction of training data to learn in a single pass
epochs=100;
sessions=20;

figure(10); clf reset; L={''};
ER=NaN(sessions,DN.nlayers);    % Holder for comparison error in diff conditions
for l=1:DN.nlayers
  X=Z{l};                       % Input data for numerosity comparison learner
  NN=fclayer([size(X,2) 1],pa2);% Init a 1-layer learner
  for s=1:sessions              % Train the learner for xx sessions
    % Training
    NN=fclayer_train(NN,X(D.Itr,:),Y(D.Itr,:),epochs); % Train on (epochs x batch) patterns
    % Activation on test and analysis
    R=layer_activate(NN.w,NN.b,X(D.Ite,:),NN.fun);% Activate on the test set  
    ER(s,l)=mean(abs((R>0.5)~=Y(D.Ite))); % Err (test set)
    plot(ER);       
    ylim([0 .5]);
    title('Comparison error'); xlabel('Session'); ylabel('Error');
    L{l}=sprintf('L%d err=%.2f',l,ER(s,l)); legend(L);
    drawnow;                        
  end
end