% MLP as universal function approximator

% DATA
X=rand(2000,2);                       % X [ 0...1 , 0...1 ]
T=(X(:,1)-0.5).^2 + (X(:,2)-0.5).^2; % F(x) quadratic function

%% MODEL
N = mlp_init([2 30 1]); 
Y0 = mlp_activate(N,X);
N = mlp_train(N,X,T,10000);
Y1 = mlp_activate(N,X);

%% DIAGNOSTICS
Residuals0=abs(T-Y0);		% untrained
Residuals1=abs(T-Y1);		% trained

% Numerical output
merr0=mean(abs(Difference0)); 	% average error untrained
merr1=mean(abs(Difference1));	% average error trained
fprintf('error Untrained = %.3f  Trained %.3f \n',merr0,merr1);

%% Graphical analysis
h_fg=figure(1); clf reset;  
% Set figure size and other params to make it redy for saving as image file
set(h_fg,'Position',[100,900,1200,700],'Renderer','zbuffer','Color',[1 1 1],'PaperPositionMode', 'auto');

% FUNCTION
subplot(2,3,1);   
plot3(X(:,1),X(:,2),T,'.');	% 3D Plot of target function 
zlim([0 1]);
title('Y=F(X)');

subplot(2,3,2);   
plot3(X(:,1),X(:,2),Y0,'r.');   % 3D Plot of response of untrained network			
zlim([0 1]);
title('Untrained N(X)');

subplot(2,3,3);   
plot3(X(:,1),X(:,2),Y1,'g.');   % 3D plot of response of trained network		
zlim([0 1]);
title('Trained N(X)');

% ERROR
subplot(2,3,4);             
plot(N.E,'k','LineWidth',3);    % Error during learning
xlabel('Epoch');
ylabel('error');
title('Leaning Error');

subplot(2,3,5);  
plot(X,Difference0,'r.');	% plot target vs untrained (as dots)
axis equal;                 	% use same scale for absc and ordinate
xlim([0 1]);ylim([0 1]);
xlabel('Target F(x)'); 
ylabel('N(x)');
title(sprintf('Untrained: Residuals m=%.3f',merr0));

subplot(2,3,6);             
plot(X,Difference1,'g.');	% plot targets vs trained (as dots)
axis equal;
xlim([0 1]);ylim([0 1]);
xlabel('Target F(x)'); 
ylabel('N(x)');
title(sprintf('Trained: residuals m=%.3f',merr1));

% Store fig as PNG image file
print(h_fg,'-dpng','-painters','-r100','Test-MLP.png');

