%% 1. Init simulation
n=10000;                    % Number of samples
pr=[0.001 0.200];			% test limits
E = rand(1,n)*(pr(2)-pr(1))+pr(1); % Investigated precision of set
N=zeros(size(E)); 			% Storage place for generated set-size
m=0; 
s=0.02;                     % params of the normal distribution
 
%% 2. Gather data
for i = 1:n  				% generate sets for each investigated precision
  N(i)=n_sample(m,s,E(i));  % draw from N(m,s) with precision e=E(i)
end

%% 3. Graphical analysis
figure(1);                  % new figure
plot(E,N,'.');              % plot the obtained set-size against each level of E
set(gca,'XScale','log','YScale','log');    
xlabel('precision');        % name the abscissa
ylabel('sample size');      % name the ordinate
title('Set size as a function of precision');         % name the figure

%% 4. Quantitatively invesigate how strong is the link between N and E on a log-log scale.
logN=log(N)';
logE=log(E)';
[B,~,~,~,ST]=regress(logN,[ones(size(logE)) logE]);
b0=B(1);     					% B(1) is the intercept (constant term)
b=B(2);     					% coefficient of the predictor (slope)
R2=ST(1);                       % R2-stat
pval=ST(3);                     % significance of the regression
fprintf('logN ~ %.2f + %.2f logE (R2=%.2f, p=%.3f)\n',b0,b,R2,pval); 

%% 5. Graphical summary of the log-log model
% 5a Prepare a vector with the (log)predictor and the (log)predicted value
xE=pr(1):0.001:pr(2);           % Values of the predictor (on a linear scale)
xlogE = log(xE);				% Predictor on log-scale
ylogN=b0+xlogE*b;               % Apply the model: evaluate the predicted variable (on a log-scale)

% 5b. Visualize (1) the data and (2) the prediction on a log scale
figure(2);  
clf reset; hold on;   			% clear the figure; allow drawing over
plot( logE, logN, '.');         % plot the sampled set-size against E
plot( xlogE, ylogN, 'r');		% plot over the modelled relationship
