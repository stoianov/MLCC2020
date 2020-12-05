% Plot the weights of the hidden units as images
function plot_oweights(NN)

 h_fg=figure(16); clf reset;	% Set figure properies (position, size, background, .. ) ready to save as image	
 set(h_fg,'Position',[100,1000,1500,200],'Renderer','zbuffer','Color',[1 1 1],'PaperPositionMode', 'auto');
 clim=2;                         		% Limits of color scale, to show more clearly the response patterns
 cthr=0.1;                         		% Plot as Zero any (absolute) weight-values bellow this threshold
 npl=NN.sz(3); nx=10; ny=npl/10; % How many images weight matrixes to show
 for i=1:npl,                    		% Cycle over every hidden unit
   subplot(ny,nx,i);             		% Divide the figure into [nx x ny] subplots and selects subplot-with-index i
   w=NN.hw*NN.ow(:,i);                  % The weight matrix of unit i as a vector
   w(abs(w)<cthr)=0;                    % Set to zero absoloute weight-values bellow the threshold
   img=reshape(w,20,20);                % Reshape the weight matrix as an image according to the original image size
   imagesc(img);                        % Display the weight matrix as an image
   axis image; axis off;                % Set the type of plot as "image" and remove axes, for clear visualization
   caxis([-clim clim]);          		% Set the color limits to show more clearly important values
   s=sprintf('Digit%d',i-1);            % String with unit-name 
   text(3,-3,s);                        % Display the unit-name
 end
 print(h_fg,'-dpng','-painters','-r100','OL.png'); % Save the figure as an image "HL.png"
end