function plot_dbn(N,imagesize,fign,nshow)
 for l=2:N.nlayers
  if l==2,
    % The weights of the 1st computational layer are receptieve fields in the sensory domain
    W=N.W{2};      
  else
    % Recurrently multiply the weights from the lower layer by the current weights to obtain
    % an approximated sensitivity of each unit (receptieve fields) in the sensory domain
    W=W*N.W{l};
  end
  layer_plot(W,imagesize,fign+l,nshow);
 end 
end

function layer_plot(W,imagesize,fign,nshow)
 clim=max(abs(W(:)))*.3; % Limits of color scale, to show more clearly the response patterns
 n=size(W,2);            % Number of units to plot
 n=min(n,nshow);         % Limit to 50 units
 nx=10;                  % How many collumns of plots
 ny=ceil(n/nx);          % How many rows of plots
 figure(fign); clf reset;
 for i=1:n,
   subplot(ny,nx,i);     % Define plot space
   w=W(:,i);             % Weight to plot
   imagesc(reshape(w,imagesize)); % Plot the weights reshaped as image
   caxis([-clim clim]); % Set the color limits to show more clearly important values
   axis image; axis off; 
 end
end
