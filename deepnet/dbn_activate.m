% Sensory (bottom-up) driven activation of a DBN on a set of data patterns X
% Input: DBN structure & Input matrix in which rows are input patterns
% Output: The activity of all layers, including the input.
function Y=dbn_activate(N,X)
Y=cell(N.nlayers,1);    % Container for input data and activity of each layer
Y{1}=X;                 % Keep the data as 1st (input) layer
for l=2:N.nlayers 		% Activate layer l with input from the preceding layer
  Y{l}=layer_activate(N.W{l},N.B{l},Y{l-1},N.actfun);
end
end
