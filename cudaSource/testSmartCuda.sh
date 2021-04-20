#!/bin/bash
nvcc -std=c++11 ./flock_better.cu -o flockBetterPar
echo -n > ./output.txt
echo "1 boid"
printf "Parra 1 boid 1000 iter\n" >> ./output.txt
for i in {1..10}
do 
./flockBetterPar 1 1000 >> ./output.txt
printf "\n" >> ./output.txt
done
echo "100 boid"
printf "\nParra 100 boid 1000 iter\n" >> ./output.txt
for i in {1..10}
do 
./flockBetterPar 100 1000 >> ./output.txt
printf "\n" >> ./output.txt
done
echo "500 boid"
printf "\nParra 500 boid 1000 iter\n" >> ./output.txt
for i in {1..10}
do 
./flockBetterPar 500 1000 >> ./output.txt
printf "\n" >> ./output.txt
done
echo "1000 boid"
printf "\nParra 1000 boid 1000 iter\n" >> ./output.txt
for i in {1..10}
do 
./flockBetterPar 1000 1000 >> ./output.txt
printf "\n" >> ./output.txt
done
echo "10000 boid"
printf "\nParra 10000 boid 1000 iter\n" >> ./output.txt
for i in {1..10}
do 
./flockBetterPar 10000 1000 >> ./output.txt
printf "\n" >> ./output.txt
done
echo "50000 boid"
printf "\nParra 50000 boid 1000 iter\n" >> ./output.txt
for i in {1..10}
do 
./flockBetterPar 50000 1000 >> ./output.txt
printf "\n" >> ./output.txt
done
echo "100000 boid"
printf "\nParra 100000 boid 1000 iter\n" >> ./output.txt
for i in {1..2}
do 
./flockBetterPar 100000 1000 >> ./output.txt
printf "\n" >> ./output.txt
done
echo "500000 boid"
printf "\nParra 500000 boid 1000 iter\n" >> ./output.txt
for i in {1..10}
do 
./flockBetterPar 500000 1000 >> ./output.txt
printf "\n" >> ./output.txt
done

rm ./flockBetterPar