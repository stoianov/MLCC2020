%% 1. Init simulation
n=1000;                        % Number of samples
LIM=[0.005 0.5];              % test limits
E = rand(1,n)*(LIM(2)-LIM(1))+LIM(1); % Investigated precision parameter
S = rand(1,n)*(LIM(2)-LIM(1))+LIM(1); % Investigated st.dev. parameter
N=zeros(size(E));               % Storage place for generated set-size
m=0; 
 
%% 2. Gather data
for i = 1:n                     % generate sets for each investigated precision
  N(i)=n_sample(m,S(i),E(i));   % draw from N(m,s) with precision e=E(i)
end

%% 3. Graphical analysis
figure(1); clf reset;           % new figure; clear
subplot(1,2,1);
 plot(E,N,'.');                 % plot the obtained set-size against each level of E
 set(gca,'XScale','log','YScale','log');    
 xlabel('precision');           % name the abscissa
 ylabel('sample size');         % name the ordinate
 title('Set size as a function of precision');     % name the figure

subplot(1,2,2);
 plot(S,N,'.');                 % plot the obtained set-size against each level of S
 set(gca,'XScale','log','YScale','log');    
 xlabel('st.dev.');             % name the abscissa
 ylabel('sample size');         % name the ordinate
 title('Set size as a function of st.dev.');         % name the figure

%% 4. Quantitatively invesigate how strong is the link between N and (E,S) on a log-log scale.
logN=log(N)';
logE=log(E)';
logS=log(S)';
[B,~,~,~,ST]=regress(logN,[ones(size(logS)) logE logS]);
b0=B(1);     					% B(1) is the intercept (constant term)
b1=B(2);     					% coefficient of the 1st predictor (prec)
b2=B(3);     					% coefficient of the 2nd predictor (st.dev.)
R2=ST(1);                       % R2-stat
pval=ST(3);                     % significance of the regression
fprintf('logN ~ %.2f + %.2f logE + %.2f logS (R2=%.2f, p=%.3f)\n',b0,b1,b2,R2,pval); 

%% 5. Graphical summary of the log-log model
%  Sampling as a function of precision (keep st.dev. constant)
xE=LIM(1):0.001:LIM(2);         % A range of precision values (on a linear scale)
xlogE = log(xE);				% Precision on log-scale
xS=mean(LIM);                   % Constant st.dev; the average of LIM(1), LIM(2)
xlogS = log(xS);				% st.dev. on log-scale
ylogN=b0+xlogE*b1+xlogS*b2;               % Apply the model: evaluate the predicted variable (on a log-scale)

% Plot
figure(2);clf reset;            % clear the fig
subplot(1,2,1);hold on;         % drawing over
 plot( logE, logN, '.');        % plot the sampled set-size against logE
 plot( xlogE, ylogN, 'r');		% plot over the modelled relationship
 xlabel('precision');           % name the abscissa
 ylabel('sample size');         % name the ordinate
 title('Set size as a function of precision');     % name the figure

% Sampling as a function of st.dev. (keep precision constant)
xE=mean(LIM);                   % Constant precision (on a linear scale)
xlogE = log(xE);				% Precision on log-scale
xS=LIM(1):0.001:LIM(2);         % A range of st.dev. values (on a linear scale)
xlogS = log(xS);				% St.dev. on log-scale
ylogN=b0+xlogE*b1+xlogS*b2;               % Apply the model: evaluate the predicted variable (on a log-scale)
% Plot
subplot(1,2,2); hold on;        % allow drawing over
 plot( logS, logN, '.');        % plot the sampled set-size against logS
 plot( xlogS, ylogN, 'r');		% plot over the modelled relationship
 xlabel('st.dev.');             % name the abscissa
 ylabel('sample size');         % name the ordinate
 title('Set size as a function of st.dev.');         % name the figure
