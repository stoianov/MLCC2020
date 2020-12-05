function Y=layer_activate(W,B,X,actfun)
  npat=size(X,1);
  A=X*W+repmat(B,npat,1); % X[npat, ninp] * W[ninp, n] → [npat, n] + B[npat, n] → A   
  switch actfun
      case 'sig',   Y=1./(1+exp(-A));   % sigmoid unit
      case 'rlu',   Y=max(A,0);         % rectified linear unit
  end
end