% Creates a new 2-layer multilayer perceptron.
% Network size is given in the input parameter sz
% sz=[n-input units, n-output units]
% Returns variable N: a structure containing the layer weights, ready to be trained

function N=fclayer(lsize,par)
N.par=par;
N.lsize=lsize;                  % network size (we expect 3 layers)
N.nlayers = numel(lsize);       % the total number of the layers (including inp and out)
N.lc=par.lc;                    % learning coefficient
N.mc=par.mc;                    % momentum term
N.wsd=par.wsd;                  % st.dev. of gassian weight init

N.w=randn(lsize(1),lsize(2))*N.wsd;  % random weights (n-inp x n-unit)
N.b=zeros(1,lsize(2));          % null bias
N.fun=par.fun{2};               % activation funtction 

N.dw=zeros(size(N.w));
N.db=zeros(size(N.b));
end