# DVRK MTM Gravity Compensation(GC)
## Declaration
This repository is of the continuation of the work from RBE501 dVRK MTM gravity compensation. It is the Matlab code using in the paper ICRA18 workshop, *A Case Study of Gravity Compensation for da Vinci Robotic
Manipulator: A Practical Perspective*.
## Procedure of GC
### 1. Data Collection 
Collecting Data using matlab script in folder **/Data Collection/**,*CoupledDataCollection.m, decoupledDataCollection.m*, to collect joint configuration and force signal data.
### 2. Data Processing
After Collecting data， Data Processing should be proceeded to tranform the data form and filter out the noise. The script can be found at folder **/Data Processing/**
### 3. Dynamic Parameters Estimation
Both Simple Manipulator Model (SMM) and Manipulator Model with Parallelogram Mechanism (MMPM) are implemented in our work. MMPM is recommended to provide a sufficient modelling. Estimation is using Least Square Estimation(LSE). Iterative LSE is recommended to provide a more accurate estimation on dynamic paramters in distal joints. The scprits can be found in **/Estimation/LSE**
### 4. Evaluation
Finally, Estimation of Dynamic should be evaluated. In the off-line evaluation,  Square Error is computing the error between the computing torque and real measuring torque. On the other hand, on-line evaluation is plotting the joint position without interacting with mtm.Both plots can be found in folder **/Evaluation/**
