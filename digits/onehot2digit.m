% X=digit2onehot(Y)
% decode a matrix with one-hot coding of ditis (0..9)
% Input:  Y, matrix with 10 collumns 
% Output: X, vector containing for each pattern in Y (rows) the digit with strongest activation

function [X,pX]=onehot2digit(Y)

n=size(Y,1);            % number of data patterns
X=zeros(n,1);          	% vector with the decoded digit
pX=X;
for i=1:n
  [p,j]=max(Y(i,:));    % find the position of the item with strongest activation
  X(i)=j-1;             % transform the position to digit [1..10] -> [0..9]
 pX(i)=p/sum(Y(i,:));   % the probability of the item with the strongest activation
  
end

end
