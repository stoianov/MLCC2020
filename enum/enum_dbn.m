addpath([pwd filesep '../deepnet']); % Library with DBN and MLP
D=enumdata30x30;            % Adds indexed for training, test, validation

%% DBN
pa1.wsd=0.01;               % spread of weights during initialization
pa1.lc= 0.3;                % learning coeff.
pa1.mc= 0.7;                % momentum
pa1.dec=0.0002;             % small decay term
pa1.trnoise=0.02;           % St.dev. for gaussian noise.             
batch=100;                  % size of a batch of samples to learn in a single pass
epochs=30000;               % how many training epochs

%%
DN=dbn([D.npix 80 300],pa1);% Deep Belief Network with 900-80-300 units
X=D.IMG(D.Itr,:);           % Training data: vectorized images of digits
DN=dbn_train(DN,X,epochs,batch); % Train the DBM network for 50 epochs
DN.fname=[D.fname '_DBN' sprintf('-%d',DN.lsize) sprintf('_Tr%dkpat',epochs*batch/1000)]; 
save(DN.fname,'D','DN');    % Store only DBN
plot_dbn(DN,D.imageSize,120,50); % Visualize the weights as spatial filters
