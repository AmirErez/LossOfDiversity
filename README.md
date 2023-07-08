# LossOfDiversity
Code and data for "Diversity loss in microbial ecosystems undergoing gradual environmental changes"

## AECode/
Simulation code

* ODE solver serialdil_odesolver.m
* The function for extracting the shifted exponential decay, shifted_exponential.m
* SLURM scripts running the parallel simulation jobs in *.cmd files, using the split-apply-collect template
* Consult runme.sh for usage details

## AEData/
Saved simulation data used from plotting the figures in the manuscript.
Please open the file collected.tgz to access the collected simulation 
data.

## AEPlot/
Scripts used to generate the figures in the manuscript

## AEFigures/
Figures, generated using the scripts in AEPlot/ and the data in AEData/
