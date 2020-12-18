% function D=digitdata30
%
% Load numerosity dataset and restructure it for our method of data handling using indexes
%
% The numerosity images of size 30x30 are stored as vectors. 
% To turn back do images, use img=reshape(vect,30,30)
%
% D.IMG: matrix with vectorized 5000 images of digits (500 images per digit)
% D.Numerosity: image numerosity
% D.Surface: cumulative surface area
% D.Num: the range of numerosity (1..32)

% D.Itr: set of nte images per digit, to be usef for training
% D.Ite: set of nte images per digits, to used for test
% D.Iva: set of nva images per digits, to be used or validation

function D=enumdata30x30
fname='numerosities_30x30_1-32_a8';
load(fname);                             % Load dataset 30x30 pix with 8 levels of cum.surf.area
D.fname=fname;                          % Keep the filename

% Put together three subsets and index them

D.IMG=[D.D{1};D.D{2};D.D{3}];                               % IMAGES 30x30px
D.Numerosity=[D.N{1}(:,1); D.N{2}(:,1); D.N{3}(:,1)];       % Numerosity
D.Surface=[D.Surf{1}(:,1); D.Surf{2}(:,1); D.Surf{3}(:,1)]; % Cumulative surface

D.Itr=(1:size(D.D{1},1));                                   % Training index
D.Ite=(1:size(D.D{2},1)) +size(D.D{1},1);                   % Test set
D.Iva=(1:size(D.D{3},1)) +(size(D.D{1},1)+size(D.D{1},2));  % Validation set

D.ntr=numel(D.Itr);                     % Size of the subsets
D.nte=numel(D.Ite);
D.nva=numel(D.Iva);

D.imageSizeX=D.input_size(1);
D.imageSizeY=D.input_size(2);
D.imageSize=[D.imageSizeY D.imageSizeY];
D.npix=D.imageSizeX*D.imageSizeY;

D.Num=min(D.Numerosity(:,1)):max(D.Numerosity(:,1));

D.D=[]; D.N=[]; D.Surf=[];                                  % remove obsolete variables

figure(1); Ipl=randperm(D.ntr,8);
for i=1:8
  subplot(1,8,i);
  imagesc(reshape(D.IMG(Ipl(i),:),30,30));
  title(sprintf('N=%d Surf=%d',D.Numerosity(Ipl(i)),D.Surface(Ipl(i))));
  colormap bone;
end
end
