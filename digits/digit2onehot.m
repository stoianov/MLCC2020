% Y=digit2onehot(X)
% returns one-hot coding of a vector of ditis (0..9)
% Input:  X, vector with digits 
% Output: Y, matrix with 10 collumns with orthgonal (one-hot) coding of each digit in X

function Y=digit2onehot(X)

n=numel(X);		% number of data patterns
Y=zeros(n,10);         	% array for the one-hot code
for i=1:n
  Y(i,X(i)+1)=1;        % one-hot-code for each number
end

end
