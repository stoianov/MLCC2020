# Statistical modelling of sample size

Let's iteratively draw random numbers from a Normal distribution with parameters (mean *m*, standard deviation *s*) until the distance between the average of the drawn numbers (sample) and its expected average (the mean *m*) falls bellow a certain threshold which we call "precision".

- Investigate the potential link between sample size and precision.
  -  function *n_sample* draws the sample
  -  script *samplesize_pre.m* runs the statistical modelling procedure, including setting, draw, analysis, and graphical visualization.  

- Investigate the link between sample size and the parameter st.dev. *s* of the Normal distribution. 
  -  script *samplesize_std.m* investigates the link (st.dev -> size)
  -  script *samplesize.m* ivestigate the joint influence of precision and st.dev. on sample size

