if layer>1  
  data_GPU=poshidprobs_GPU; % the probabilities of the previous layer
end

numhid  = DN.layersize(layer);
[numcases numdims] = size(data_GPU);
numcases_GPU   = gpuArray(numcases);

if macroepoch < DN.largemomentumepoch, momentum_GPU = gpuArray(DN.initialmomentum); else momentum_GPU = gpuArray(DN.finalmomentum); end;

eval(sprintf('HB=gpuArray.ones(numcases,1,''single'')*hidbiases%d_GPU;',layer));

%%%%%%%%% POSITIVE PHASE %%%%%%%%%
eval(sprintf('poshidprobs_GPU = 1./(1 + exp(-data_GPU * vishid%d_GPU - HB));',layer));
poshidstates_GPU = poshidprobs_GPU > gpuArray.rand(numcases, numhid,'single');
posprods_GPU    = data_GPU' * poshidprobs_GPU;
poshidact_GPU   = sum(poshidprobs_GPU);
posvisact_GPU   = sum(data_GPU);

%%%%%%%%% NEGATIVE PHASE  %%%%%%%%%
eval(sprintf('negdata_GPU     = 1./(1 + exp(-poshidstates_GPU * vishid%d_GPU'' - gpuArray.ones(numcases,1,''single'')*visbiases%d_GPU  ));',layer,layer));
eval(sprintf('neghidprobs_GPU = 1./(1 + exp(-negdata_GPU * vishid%d_GPU       - HB ));',layer));
negprods_GPU    = negdata_GPU' * neghidprobs_GPU;
neghidact_GPU   = sum(neghidprobs_GPU);
negvisact_GPU   = sum(negdata_GPU);

%%%%%%%%% UPDATE WEIGHTS AND BIASES %%%%%%%%% 
eval(sprintf('vishidinc%d_GPU  = momentum_GPU*vishidinc%d_GPU  + (epsilon_GPU /numcases_GPU)*(posprods_GPU -negprods_GPU ) - (epsilon_GPU*weightcost_GPU)*vishid%d_GPU;',layer,layer,layer));
eval(sprintf('visbiasinc%d_GPU = momentum_GPU*visbiasinc%d_GPU + (epsilon_GPU/numcases_GPU)*(posvisact_GPU-negvisact_GPU);',layer,layer));
eval(sprintf('hidbiasinc%d_GPU = momentum_GPU*hidbiasinc%d_GPU + (epsilon_GPU/numcases_GPU)*(poshidact_GPU-neghidact_GPU);',layer,layer));
eval(sprintf('vishid%d_GPU     = vishid%d_GPU + vishidinc%d_GPU;',layer,layer,layer));
eval(sprintf('visbiases%d_GPU  = visbiases%d_GPU + visbiasinc%d_GPU;',layer,layer,layer));
eval(sprintf('hidbiases%d_GPU  = hidbiases%d_GPU + hidbiasinc%d_GPU;',layer,layer,layer));      

%%%%%%%%% SPARSITY &&&&&&&&&&&&&&&&&&&&&&&&&&&&&
if DN.p_sparse(layer)>0, 
  p_sparse_GPU=gpuArray(DN.p_sparse(layer));
  eval(sprintf('hidbiases%d_GPU = hidbiases%d_GPU - epsilon_GPU*(poshidact_GPU/numcases_GPU-p_sparse_GPU);',layer,layer));
end

%%%%%%%% Monitor Error & Time  %%%%%%%%%%%%%%%%
if calc_err, DN.err(calc_err,layer)=gather(sum(sum((data_GPU - negdata_GPU).^2))/(numcases_GPU*size(data_GPU,2))); end
DN.time_calc=DN.time_calc+(toc-time0_rbm);    	% DEBUG_Time

