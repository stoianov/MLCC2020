%%
figure(2); clf;             % Fig for psychophysical profile
subplot(1,3,1);  contrast_profile(NN,D,2);
subplot(1,3,2);  noise_profile(NN,D,2);
subplot(1,3,3);  rotation_profile(NN,D,2);
%%
plot_hweights(NN);
plot_oweights(NN);
