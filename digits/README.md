# Digit perception

- *Digits20x20.mat* is a mat-file containing images of digits. Hereafter some samples.

## Data samples
![sample digits](sample_digits.png)

- digitdata.m is a reader of that file and prepares a balances set of images for training, test, and validation

- Hereafter the training progress of a simple MLP-based model of digit perception showing classification error and confusion matrix

## Training
![sample training](sample_training.png)

- *digitperc_main.m* is the main script which:
  - sets parameters, loads the dataset *D=digitdata(tr_size,te_size,va_size)*, 
  - runs the learning function *mlp_train(NN,X,T,nepochs)* and on-line analysis of the learning process *digitperc_analysis(NN,D)*, 
  - runs psychophysical analysis of the trained network *contrast_profile(NN,D)*, *noise_profile(NN,D)*, *rotation_profile(NN,D)*
  - shows the unit weights as images *plot_hweights(NN)*, *plot_oweights(NN)* to allow inside visual analysis of the network computations.

## Profile
   ![Profile](Profile.png)

## Hiden units
   ![Hidden units](HL.png)

## Output units
  ![Output units](OL.png)

