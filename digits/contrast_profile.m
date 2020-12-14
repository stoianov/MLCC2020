% Investigate the effect of image contrast on classification accuracy

function contrast_profile(NN,D,fig)

if nargin<3, fig=0; end         % No figure number given, so no new figure; it will be provided from outside
 
I=D.Iva;                        % Set to use for the analysis
X=D.IMG(I,:);                   % Let's use the validation image set
T=D.Num(I);                     % The categories on that set
R=onehot2digit(mlp_activate(NN,X));% The network response 
AC=(R==T);                      % Accuracy (response = true category)

C=contrast(X,'local');          % image contrast; methods: 'minmax','std','local'. See the function "contrast.m"
CD=round(C*10);                 % Scale-up and round to obtain discrete levels
CDsc=min(CD):max(CD);           % the levels of the discrete contrast 
Csc=CDsc/10;                    % the original levels of the new scale
nsc=numel(Csc);                 % how many levels

ACcon=NaN(1,nsc);               % Average accuracy per each new contrast level
if fig, figure(fig+1);clf reset; end % Figure for samples
for i=1:nsc
  II=find(CD==CDsc(i));
  ACcon(i)=mean(AC(II));
  if fig
    subplot(1,nsc,i);
    Ipl=II(randi(numel(II)));
    imagesc(reshape(X(Ipl,:),20,20));
    axis image; axis off; colormap bone;
    title(sprintf('Contrast %.1f',Csc(i)));
  end
end

if fig, figure(fig); end        % Open a figure for profile
plot(Csc,ACcon);
title('Effect of contrast');
xlabel('Contrast'); ylabel('Accuracy');
end

