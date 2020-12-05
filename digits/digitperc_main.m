%% INIT
addpath(pwd,[pwd filesep '../mlp']); % Library with MLP
tr_size=300;                % patterns per class for training (total)
te_size=100;                % test set size (per class)
va_size=100;                % validation set size (per class)
ba_size=30;                 % patterns per class for training (batch)
D=digitdata(tr_size,te_size,va_size);  % Select (100+50+50) cases per each digit for training, test, validation
sz=[D.npix 50 10];          % Size of input all other layers
par.fun={'inp','rlu','sig'};% Activation functions for each layer. 
                            % Note that now we have intoduced rectified linear function. 
                            % USE RLU only for the HIDDEN layer. 
                            % Check the code for details.
par.trnoise=0.02;           % St.dev. for gaussian noise. Check mlp_backrprop() for details             
par.wsd=0.01;               % spread of weights during initialization
par.lc= 0.01;               % learning coeff.
par.mc= 0.7;                % momentum
nses=100;                   % number of training sessions
nepochs=50;                 % number of iterations per session on a batch
NN=mlp_init(sz,par);        % INIT
NN.DE=[ ];                  % Storage for problem-specific (digit recognition error)

%% TRAINING organized in sessions, epochs, trials.
for i=1:nses    
  D.Iba=randperm(D.ntr,ba_size*10); % Random subset (batch)
  X=D.IMG(D.Iba,:);                 % Inputs: vectorized images of the selected patterns
  T=digit2onehot(D.Num(D.Iba));     % Targets: orthogonal (onehot) code of the digit labels
  NN=mlp_train(NN,X,T,nepochs);     % Train on the batch
  NN=digitperc_analysis(NN,D);      % Analysis of the training progress
end

save(sprintf('DigitNet%d.mat',sz(2)),'NN','D');

contrast_profile(NN,D)
noise_profile(NN,D)
rotation_profile(NN,D)
plot_hweights(NN)
plot_oweights(NN)
