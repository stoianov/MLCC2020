function Y=layer_activate(W,B,X)
  npat=size(X,1);
  A=X*W+repmat(B,npat,1); % X[npat, ninp] * W[ninp, n] → [npat, n] + B[npat, n] → A 
  Y=1./(1+exp(-A));
end