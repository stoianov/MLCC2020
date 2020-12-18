% N: MLP structure
% X: Input data (the features of each pattern)
% T: Target data
function N=fclayer_optimize(N,X,T)
 lc=N.lc;                       % Learning coefficient
 mc=N.mc;                       % Momentum coefficient  
 Y=layer_activate(N.w,N.b,X,N.fun); % Activate the MLP on data
 % Gradients
 oE=T-Y;                        % Errors at the output layer 
 dY = oE.*Y.*(1-Y);             % Gradients at the output layer
 % Increments
 dW = (X'*dY);                  
 dB = sum(dY);                  
 % Momentum
 N.dw=mc*N.dw + (1-mc)*dW;      
 N.db=mc*N.db + (1-mc)*dB;      
 % Add updates
 N.w = N.w + lc * N.dw;         
 N.b = N.b + lc * N.db;         
end
