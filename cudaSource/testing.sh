#!/bin/bash
nvcc -std=c++11 ./flock.cu -o flockPar
echo -n > ./parra.txt
echo "1 boid"
printf "Parra 1 boid 1000 iter\n" >> ./parra.txt
for i in {1..2}
do 
./flockPar 1 1000 >> ./parra.txt
printf "\n" >> ./parra.txt
done
echo "100 boid"
printf "\nParra 100 boid 1000 iter\n" >> ./parra.txt
for i in {1..2}
do 
./flockPar 100 1000 >> ./parra.txt
printf "\n" >> ./parra.txt
done
echo "500 boid"
printf "\nParra 500 boid 1000 iter\n" >> ./parra.txt
for i in {1..2}
do 
./flockPar 500 1000 >> ./parra.txt
printf "\n" >> ./parra.txt
done
echo "1000 boid"
printf "\nParra 1000 boid 1000 iter\n" >> ./parra.txt
for i in {1..2}
do 
./flockPar 1000 1000 >> ./parra.txt
printf "\n" >> ./parra.txt
done
echo "10000 boid"
printf "\nParra 10000 boid 1000 iter\n" >> ./parra.txt
for i in {1..2}
do 
./flockPar 10000 1000 >> ./parra.txt
printf "\n" >> ./parra.txt
done
echo "50000 boid"
printf "\nParra 50000 boid 1000 iter\n" >> ./parra.txt
for i in {1..2}
do 
./flockPar 50000 1000 >> ./parra.txt
printf "\n" >> ./parra.txt
done
echo "100000 boid"
printf "\nParra 100000 boid 1000 iter\n" >> ./parra.txt
for i in {1..2}
do 
./flockPar 100000 1000 >> ./parra.txt
printf "\n" >> ./parra.txt
done
echo "500000 boid"
printf "\nParra 500000 boid 1000 iter\n" >> ./parra.txt
for i in {1..2}
do 
./flockPar 500000 1000 >> ./parra.txt
printf "\n" >> ./parra.txt
done

rm ./flockPar