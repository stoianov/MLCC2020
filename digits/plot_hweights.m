% Plot the weights of the hidden units as images
function plot_hweights(NN)

 h_fg=figure(15); clf reset;	% Set figure properies (position, size, background, .. ) ready to save as image	
 set(h_fg,'Position',[100,1000,1600,1000],'Renderer','zbuffer','Color',[1 1 1],'PaperPositionMode', 'auto');
 clim=1.;                         		% Limits of color scale, to show more clearly the response patterns
 cthr=0.05;                         		% Plot as Zero any (absolute) weight-values bellow this threshold
 npl=NN.lsize(2); nx=10; ny=npl/10; % How many images weight matrixes to show
 for i=1:npl,                    		% Cycle over every hidden unit
   subplot(ny,nx,i);             		% Divide the figure into [nx x ny] subplots and selects subplot-with-index i
   w=NN.hw(:,i);                        % The weight matrix of hidden unit i as filters on the input domain
   w(abs(w)<cthr)=0;                    % Set to zero absoloute weight-values bellow the threshold
   img=reshape(w,20,20);                % Reshape the weight matrix as an image according to the original image size
   imagesc(img);                        % Display the weight matrix as an image
   axis image; axis off;                % Set the type of plot as "image" and remove axes, for clear visualization
   caxis([-clim clim]);          		% Set the color limits to show more clearly important values
   s=sprintf('unit %d',i);              % String with unit-name 
   text(1,-3,s);                        % Display the unit-name
 end
 print(h_fg,'-dpng','-painters','-r100','HL.png'); % Save the figure as an image "HL.png"
end