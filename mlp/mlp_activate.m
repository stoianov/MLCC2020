function [Y, H]=mlp_activate(N,X)
  H = layer_activate(N.hw, N.hb, X);	% activate the hidden layer
  Y = layer_activate(N.ow, N.ob, H);  	% activate the output layer
end
