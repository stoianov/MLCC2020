function NN=digitperc_analysis(NN,D)

% a) Performance on the batch subset
Rba=onehot2digit(mlp_activate(NN,D.IMG(D.Iba,:))); 
DE(1,1)=mean(abs(Rba~=D.Num(D.Iba)));  % Category error (training batch)
% b) Performance on the test subset
Rte=onehot2digit(mlp_activate(NN,D.IMG(D.Ite,:))); 
DE(1,2)=mean(abs(Rte~=D.Num(D.Ite)));  % Category error (test set)
NN.DE=[NN.DE;DE];                   % Store the error

figure(1); clf reset;
 subplot(1,3,1); 
   plot(NN.DE);                     % Show the learning trend
   ylim([0 1]);
   title('Digit recognition error');
   xlabel('Session'); ylabel('Error');
   legend({sprintf('Training set Err=%.2f',DE(1)),sprintf('Test set Err=%.2f',DE(2))});
 subplot(1,3,2);
   Dig=0:9;
   imagesc(Dig,Dig,confusionmatrix(Rba,D.Num(D.Iba),Dig)); % Show confusion matrix
   title('Training set:  P(Response|Target)');
   xlabel('Preferred response'); ylabel('Target'); 
 subplot(1,3,3);
   imagesc(Dig,Dig,confusionmatrix(Rte,D.Num(D.Ite),Dig)); % Show confusion matrix
   title('Test set: P(Response|Target)');
   xlabel('Preferred response'); ylabel('Target'); 
 drawnow;                           % Needed to show the plot
end
