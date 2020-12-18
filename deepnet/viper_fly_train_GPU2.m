clear all;close all;clc; tic; 
userpath('/media/DATI/ivo/');
gpuDevice(1);

%% DATA
load data

%% DN
DN.layersize  = [200 1000 400];  DN.nlayers=length(DN.layersize);

DN.macroepoch = 80000; DN.macroepoch = 10000;

DN.Schedule   = [0 .10 .30];
DN.ScheduleS  = '1234';
DN.largemomentumepoch=round(.5*DN.macroepoch);
DN.microepoch = 1;
DN.batchsize  = 200; DN.batchsize  = 100;
DN.epsilon    = 0.1;   % Learning rate for weights
DN.weightcost = 0.0005; % Original was 0.0002
DN.initialmomentum  = 0.5;
DN.finalmomentum    = 0.9;
DN.errstep    = 100; 		   % How often to calcolate error
DN.p_sparse   = [0 0.10 0.05];  % 2500 -> 125 units active
DN.fname = ['LET_V25x25_DBN' sprintf('%d-',DN.layersize) sprintf('Ep%d-b%d',DN.macroepoch,DN.batchsize) '' ];
DN.time_calc=0;
DN.time_total=0;
DN.err=zeros(ceil(DN.macroepoch/DN.errstep),DN.nlayers,'single');
DN.Schedule=round(DN.Schedule*DN.macroepoch);

fine_tuning    = 0;
linear_readout = 0;
get_sample     = 0;

epsilon_GPU    = gpuArray(DN.epsilon);
weightcost_GPU = gpuArray(DN.weightcost);


%% Init weights
for layer=1:DN.nlayers
     if layer>1, numdims  = DN.layersize(layer-1); else numdims  = 2500; end
     numhid  = DN.layersize(layer);
     % Store weights to cell array
     DN.L{layer}.hidbiases  = zeros(1,numhid, 'single');
     DN.L{layer}.vishid     = 0.1*randn(numdims, numhid, 'single');
     DN.L{layer}.visbiases  = zeros(1,numdims, 'single');
     % Cell-array --> GPU
     eval(sprintf('hidbiases%d_GPU=gpuArray(DN.L{layer}.hidbiases);',layer));     
     eval(sprintf('visbiases%d_GPU=gpuArray(DN.L{layer}.visbiases);',layer));     
     eval(sprintf('vishid%d_GPU=gpuArray(DN.L{layer}.vishid);',layer));     
     % Increments in GPU
     eval(sprintf('hidbiasinc%d_GPU=hidbiases%d_GPU;',layer,layer));     
     eval(sprintf('visbiasinc%d_GPU=visbiases%d_GPU;',layer,layer));     
     eval(sprintf('vishidinc%d_GPU=vishid%d_GPU*0;',layer,layer));     
end

for macroepoch=1:DN.macroepoch

  [XX DeepestLayer]=find(DN.Schedule<=macroepoch); DeepestLayer=DeepestLayer(end);
  %data_GPU=gpuArray(single(make_wordbatch_cpu(EngMono.words((EngMono.len(:,1)<=4),1),F.L,F.LW, F.Letter2Ind,DN.batchsize)));
  data_GPU=gpuArray(single(make_letterbase(F)));
  % Error calculation schedule. If non-positive, calc_err = position to store the error.
  if rem(macroepoch,DN.errstep)==0, calc_err=macroepoch/DN.errstep; else calc_err=0; end

  for layer=1:DeepestLayer
    rbm_fly_GPU2;
  end

  if rem(macroepoch,1000)==0 || macroepoch==DN.macroepoch
    fprintf('k');
    if rem(macroepoch,20000)==0 || macroepoch==DN.macroepoch
      % GPU --> Cell-array 
      for layer=1:DN.nlayers
        eval(sprintf('DN.L{layer}.hidbiases=gather(hidbiases%d_GPU);',layer));     
        eval(sprintf('DN.L{layer}.visbiases=gather(visbiases%d_GPU);',layer));     
        eval(sprintf('DN.L{layer}.vishid=gather(vishid%d_GPU);',layer));
      end     
      DN.epoch=macroepoch;
      DN.time_total = toc;
      fprintf('%dk\n',macroepoch/1000); 
      save (['nn' filesep DN.fname],'DN');
    end
  end

end

DN.time_total = toc;
fprintf(1, '\nElapsed time: %d (Calc = %.2f perc) \n', DN.time_total,DN.time_calc/DN.time_total*100);
save (['nn' filesep DN.fname],'DN');

% free GPU memory
clear batchposhidprobs_GPU batchdata_GPU data_GPU hidbiases_GPU hidbiasinc_GPU negdata_GPU neghidact_GPU
clear neghidprobs_GPU negprods_GPU negvisact_GPU poshidact_GPU poshidprobs_GPU poshidstates_GPU
clear posprods_GPU posvisact_GPU visbiases_GPU visbiasinc_GPU vishid_GPU vishidinc_GPU

exit;
