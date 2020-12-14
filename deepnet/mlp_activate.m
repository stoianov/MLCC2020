function [Y, H, X]=mlp_activate(N,INP)
  X = INP;                                   % Raw input
  if isfield(N,'DBN'), 
    Z=dbn_activate(N.DBN,INP);               % Activate the DBN
    X=Z{end};                                % use the last layer as input for the MLP
  end
  H = layer_activate(N.hw, N.hb, X, N.hfun); % activate the hidden layer
  Y = layer_activate(N.ow, N.ob, H, N.ofun); % activate the output layer
end