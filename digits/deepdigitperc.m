%% INIT
addpath(pwd,[pwd filesep '../deepnet'],[pwd filesep 'deepnet']); % Library with DBN and MLP
D=digitdata(300,100,100);  % 300+100+100 patterns per digit for training, test, validation

%% DBN
pa1.wsd=0.01;                % spread of weights during initialization
pa1.lc= 0.3;                 % learning coeff.
pa1.mc= 0.7;                 % momentum
pa1.dec=0.0002;              % small decay term
pa1.trnoise=0.02;            % St.dev. for gaussian noise.             
pa1.batchfr=0.05;            % fraction of training data to learn in a single pass

DN=dbn([D.npix 200 150],pa1);% Deep Belief Network with 400-200-150 units
X=D.IMG(D.Itr,:);            % Training data: vectorized images of digits
T=digit2onehot(D.Num(D.Itr)); % Orthogonal code of the digit labels (for the MLP)
DN=dbn_train(DN,X,1000);     % Train the DBM network for 50 epochs
DN.fname=['DeepDigitNet_DBN' sprintf('-%d',DN.lsize)]; % FileName for the DBN model
save(DN.fname,'D','DN');     % Store only DBN
plot_dbn(DN,[20 20],120,20); % Visualize the weights as spatial filters

deepdigitperc_mlp;          % Train a classifier using the DBN as unsupervised pre-processor