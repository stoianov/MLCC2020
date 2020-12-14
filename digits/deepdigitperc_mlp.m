% DeepDititPerception (2)
% MLP training


%% MLP
pa2.fun={'inp','rlu','sig'};% Activation functions for each layer. 
pa2.wsd=0.01;               % spread of weights during initialization
pa2.lc= 0.03;               % learning coeff.
pa2.mc= 0.7;                % momentum
pa2.trnoise=0.02;           % St.dev. for gaussian noise. Check mlp_backrprop() for details             
pa2.batchfr=0.05;            % fraction of training data to learn in a single pass

NN=mlp([DN.lsize(end) 50 10],pa2); % % Init a MLP network with 50 hidden units
NN.DBN=DN;                  % Store the DBN as a preprocessor of the MLP classifier

NN.DE=[ ];                  % Storage for problem-specific (digit recognition error)
for i=1:20                  % Train for 20 sessions
  NN=mlp_train(NN,X,T,50);  % In each sessio, train for 50 epochs on a random batch
  NN=digitperc_analysis(NN,D,20); % Analysis of the training progress
end
NN.fname=[DN.fname sprintf('_MLP%d.mat',NN.lsize(2))]; % FileName for the complete model
save(NN.fname,'D','NN');

figure(21); clf;            % Fig for psychophysical profile
subplot(1,3,1);  contrast_profile(NN,D);
subplot(1,3,2);  noise_profile(NN,D);
subplot(1,3,3);  rotation_profile(NN,D);
