% [X,Y,N,A]=digitdata(n,lim)
% loads n digits of size 20x20
% Example: [X,Y,N,A]=digitdata(100);

function [X,Y,N,A]=digitdata(n)
load('Digits20x20');
X=[]; N=[]; A=[];

for i=0:9
  I=find(D.Num==i);
  nI=numel(I);
  I=I(randperm(nI,n));
  X=[X;D.IMG(I,:)];
  N=[N;D.Num(I,:)];
  A=[A;D.Ang(I,:)];
end

nn=numel(N);
Y=zeros(nn,10);         % memory for one-hot-coding
for i=1:nn
  Y(i,N(i)+1)=1;        % one-hot-coding of N (N is 0-9)
end

end