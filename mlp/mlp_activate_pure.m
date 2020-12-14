function [Y, H, X]=mlp_activate(N,X)
  H = layer_activate(N.hw, N.hb, X, N.hfun);	% activate the hidden layer
  Y = layer_activate(N.ow, N.ob, H, N.ofun); % activate the output layer
end
