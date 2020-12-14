%% INIT
addpath(pwd,[pwd filesep '../mlp']); % Library with MLP
D=digitdata(300,100,100);  % Select (300+100+100) cases per each digit for training, test, validation

%% MLP
par.fun={'inp','rlu','sig'};% Activation functions for each layer (use RLY only for hidden units)
par.wsd=0.01;               % spread of weights during initialization
par.lc= 0.03;               % learning coeff.
par.mc= 0.7;                % momentum
par.trnoise=0.02;           % St.dev. for gaussian noise. Check mlp_backrprop() for details             
par.batchfr=0.05;           % fraction of training data to learn in a single pass

NN=mlp([D.npix 50 10],par); % Init a MLP with 50 hidden units and 10 outputs
X=D.IMG(D.Itr,:);           % Inputs: vectorized images of the training patterns
T=digit2onehot(D.Num(D.Itr)); % Targets: orthogonal (onehot) code of the digit labels
NN.DE=[ ];                  % Storage for problem-specific (digit recognition error)
for i=1:20                  % training session    
  NN=mlp_train(NN,X,T,50);  % Training in epochs during which the net learns a random batch
  NN=digitperc_analysis(NN,D,7); % Analysis of the training progress
end
save(sprintf('DigitNet%d.mat',NN.lsize(2)),'NN','D');
%%
figure(8); clf;             % Fig for psychophysical profile
subplot(1,3,1);  contrast_profile(NN,D);
subplot(1,3,2);  noise_profile(NN,D);
subplot(1,3,3);  rotation_profile(NN,D);
%plot_hweights(NN);
%plot_oweights(NN);