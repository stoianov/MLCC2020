function [Bn,Bs] = enum_regress(D,DN,fgn)
warning('off','all');
Z=dbn_activate(DN,D.IMG);       % Activate the DBN
Bn={}; Bs={};
for layer=1:3 
  X=[zscore(double([D.Numerosity(D.Ite) D.Surface(D.Ite)])) ones(numel(D.Ite),1)];
  Y=zscore(Z{layer}(D.Ite,:));  
  for h=1:size(Y,2);
    [b,~,~,~,~]=regress(Y(:,h),X);
    Bn{layer}(h)=b(1);
    Bs{layer}(h)=b(2);
  end
end

figure(fgn);clf reset; 
for layer=1:3
 subplot(1,3,layer); hold on;
 plot([-1 1 ]',[0 0 ]','k');
 plot([0 0]',[-1 1]','k');
 plot(Bn{layer},Bs{layer},'o');
 
 xlim([-1 1]);ylim([-1 1]);
 xlabel('Numerosity');ylabel('Surface');
 title(sprintf('Layer %d',layer));
end
