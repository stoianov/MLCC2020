function digitdata_demo
load('Digits20x20.mat');                    % Load if not passed as argument

npl=5;                                      % How many images to show
Ipl=randperm(D.n,npl);
figure(1);
for i=1:npl
  subplot(1,npl,i);
  imagesc(reshape(D.IMG(Ipl(i),:),D.IMGshape));
  title(sprintf('digit %d rotation %d', D.Num( Ipl(i) ), D.Ang( Ipl(i)) ) );
end

end