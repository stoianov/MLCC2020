% profile the effect of added pixel noise on classification accuracy

function noise_profile(NN,D,fig)

if nargin<3, fig=0; end         % No figure number given, so no new figure; it will be provided from outside

I=D.Iva;                        % Set to use for the analysis
X=D.IMG(I,:);                   % Let's use the validation image set
T=D.Num(I);                     % The categories on that set

sd=0:0.05:0.3;                  % levels of st.dev. of noise
nlev=numel(sd);
ACnoise=nan(1,nlev);            % storage for the profile

if fig, figure(fig+1);clf reset; end % Open a figure for samples

for i=1:nlev                    % for each level of the noise condition 
  G=randn(size(X))*sd(i);       % draw Gaussian noise for each pixel of each image
  XG=max(0,min(1,X+G));         % Rectified noise-added image
  R=onehot2digit(mlp_activate(NN,XG)); % Network response on the noisy images 
  AC=(R==T);                    % Accuracy (response = true category)
  ACnoise(i)=mean(AC);           % Average accuracy in this condition
  if fig
    subplot(1,nlev,i);
    Ipl=randi(size(X,1));
    imagesc(reshape(XG(Ipl,:),20,20));
    axis image; axis off; colormap bone;
    title(sprintf('Noise %.2f',sd(i)));
  end
end

if fig, figure(fig); end        % Open a figure for profile
plot(sd,ACnoise);
title('Effect of noise');
xlabel('Noise (st.dev.)'); ylabel('Accuracy');
end