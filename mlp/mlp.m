% Creates a new 2-layer multilayer perceptron.
% Network size is given in the input parameter sz
% sz=[n-input units, n-hidden units, n-output units]
% Returns variable N: a structure containing the layer weights, ready to be trained

function N=mlp(lsize,par)
if nargin<2,                    % Default learning parameters
  par.wsd=0.1; 
  par.lc=0.03; 
  par.mc=0.8; 
  par.fun={'same','sig','sig'}; % activation functions
  par.batchfr=0.1;              % fraction of training data to learn in a single pass
end

N.par=par;
N.lsize=lsize;                  % network size (we expect 3 layers)
N.nlayers = numel(lsize);       % the total number of the layers (including inp and out)
N.lc=par.lc;                    % learning coefficient
N.mc=par.mc;                    % momentum term
N.wsd=par.wsd;                  % st.dev. of gassian weight init
N.lepochs=0;                    % Learning epochs so far
N.lpatterns=0;                  % Learning patterns so far
N.E=[];                         % keep history of learing error

N.hw=randn(lsize(1),lsize(2))*N.wsd;  % random weights of the hidden layer (n-inp x n-hid)
N.hb=zeros(1,lsize(2));         % null bias
N.hfun=par.fun{2};              % hidden-layer activation funtction 

N.ow=randn(lsize(2),lsize(3))*N.wsd;  % random weights of the ouput layer (n-hid x n-out)
N.ob=zeros(1,lsize(3));         % null bias of output units
N.ofun=par.fun{3};              % output activation funtction

N.dhw=zeros(size(N.hw));
N.dhb=zeros(size(N.hb));

N.dow=zeros(size(N.ow));
N.dob=zeros(size(N.ob));

end
