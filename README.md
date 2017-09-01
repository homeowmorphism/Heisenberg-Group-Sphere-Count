# Heisenberg Group Sphere Count

*Status: Polished.*

This algorithms generate the sphere counts for the three-dimensional Heisenberg group over the integers (nilpotent of step 2), and gives the sphere count in terms of its Malcev coordinates. 

## Run 
To run these algorithms on your computer, you will need a running version of [SageMath](http://www.sagemath.org/).

By following the commands below, you will obtain a *sphere words [generating set]* file (like the one shown in the repo), with the generating set of your choice.

To load, type in at the sage prompt in command line:
```
sage: load("spherecount_enumerate_coord_v1.sage")

```
To obtain the *sphere words [generating set]* file, for example, the sphere counts from radius 1 up to 8 with standard generating set ```[a,b]``` type in

```
sage: print_spherecounts([a,b], 8)
```
once the script is done running, the file shoud appear in the folder you're in from the command line!
