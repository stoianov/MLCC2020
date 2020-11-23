% D=digitdata
% Load digit- dataset and add a digit-balanced set for training, test, and validation.
% The digit images of size 20x20 are stored as vectorized. 
% To turn back do images, use img=reshape(vect,20,20)
%
% D.IMG: matrix with vectorized 5000 images of digits (500 images per digit)
% D.Num: digit label (0..9)
% D.Ang: image inclination circa (-50 .. 50 degree)
% D.Itr: set of nte images per digit, to be usef for training
% D.Ite: set of nte images per digits, to used for test
% D.Iva: set of nva images per digits, to be used or validation

function D=digitdata(ntr,nte,nva)
load('Digits20x20');                  % Load dataset
if (ntr+nte+nva)*10>D.n, 
  error('Too many samples. In total there are 500 samples per digit.'); 
end
Itr=[]; Ite=[]; Iva=[];               % Empty indexes

for dig=0:9    
  I=find(D.Num==dig);                 % Find all images containing digit "dig"
  nI=numel(I);
  I=I(randperm(nI));                  % randomize the index
  
  Itr=[Itr;I(1:ntr)]; I=I(ntr+1:end); % add to the training set and keep the rest
  Ite=[Ite;I(1:nte)]; I=I(nte+1:end); % add to the test set and keep the rest  
  Iva=[Iva;I(1:nva)];                 % add to the validation set  
end

D.Itr=Itr;                            % Training, test, validation subset
D.Ite=Ite;
D.Iva=Iva;
D.ntr=numel(D.Itr);                   % Size of those subsets
D.nte=numel(D.Ite);
D.nva=numel(D.Iva;)

end