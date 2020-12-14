% profile the effect of image rotation on classification accuracy

function rotation_profile(NN,D,fig)
if nargin<3, fig=0; end         % No figure number given, so no new figure; it will be provided from outside

I=D.Iva;                        % Set to use for the analysis
X=D.IMG(I,:);                   % Let's use the validation image set
T=D.Num(I);                     % The categories on that set
R=onehot2digit(mlp_activate(NN,X));% The network response 
AC=(R==T);                      % Accuracy (response = true category)

A=D.Ang(I);                     % Image rotation angle
AD=round(A/10);                 % Uniformly distributed levels of rotation in step of 5
ADsc=min(AD):max(AD);           % the discrete scale 
Asc=ADsc*10;                    % turn the discrete scale back to the original level
nsc=numel(Asc);

ACrot=NaN(1,nsc);               % Average accuracy per each angle level
if fig, figure(fig+1);clf reset; end % Open a figure for samples

for i=1:nsc
  II=find(AD==ADsc(i));
  ACrot(i)=mean(AC(II));
  if fig
    subplot(1,nsc,i);
    Ipl=II(randi(numel(II)));
    imagesc(reshape(X(Ipl,:),20,20));
    axis image; axis off; colormap bone;
    title(sprintf('Theta %.0f',Asc(i)));
  end
end

if fig, figure(fig); end        % Open a figure for profile
plot(Asc,ACrot); xlim([-50 50]); ylim([0.5 1]);
title('Effect of digit rotation');
xlabel('Rotation (degr)'); ylabel('Accuracy');
end