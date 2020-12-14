function NN=digitperc_analysis(NN,D,fgn)

Rtr=onehot2digit(mlp_activate(NN,D.IMG(D.Itr,:))); 
DE(1,1)=mean(abs(Rtr~=D.Num(D.Itr)));   % Category error (training set)
Rte=onehot2digit(mlp_activate(NN,D.IMG(D.Ite,:))); 
DE(1,2)=mean(abs(Rte~=D.Num(D.Ite)));   % Category error (test set)
NN.DE=[NN.DE;DE];                  

figure(fgn); clf reset;
 subplot(1,3,1); 
   plot(NN.DE);                         % Show the training progress
   ylim([0 1]);
   title('Digit recognition error');
   xlabel('Session'); ylabel('Error');
   legend({sprintf('Training set Err=%.2f',DE(1)),sprintf('Test set Err=%.2f',DE(2))});
 subplot(1,3,2);
   Dig=0:9;
   imagesc(Dig,Dig,confusionmatrix(Rtr,D.Num(D.Itr),Dig)); % Show confusion matrix
   title('Training set:  P(Response|Target)');
   xlabel('Preferred response'); ylabel('Target'); 
 subplot(1,3,3);
   imagesc(Dig,Dig,confusionmatrix(Rte,D.Num(D.Ite),Dig)); % Show confusion matrix
   title('Test set: P(Response|Target)');
   xlabel('Preferred response'); ylabel('Target'); 
 drawnow;                           % Needed to show the plot
end
