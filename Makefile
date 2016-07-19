Simplify: Simp.o Surface.o SimpVertexClustering.o SimpELEN.o SimpQEM.o Classes.h common.o SimpGPU.o
	nvcc -O3 -std=c++11 -Xcompiler -fopenmp  Simp.o common.o kernel.o SimpQEM.o SimpELEN.o SimpGPU.o SimpVertexClustering.o Surface.o Vector3f.o -o Simplify -lCGAL

Simp.o: Surface.o Simp.cpp
	g++ -O3 -std=c++11 -c Simp.cpp

SimpVertexClustering.o: Surface.o SimpVertexClustering.cpp SimpVertexClustering.h
	g++ -O3 -std=c++11 -c SimpVertexClustering.cpp

SimpELEN.o: Surface.o SimpELEN.cpp SimpELEN.h
	g++ -O3 -fopenmp -std=c++11 -c SimpELEN.cpp

SimpQEM.o: Surface.o SimpELEN.o SimpQEM.cpp SimpQEM.h
	g++ -O3 -fopenmp -std=c++11 -c SimpQEM.cpp

Surface.o: Surface.h Surface.cpp Vector3f.o
	g++ -O3 -std=c++11 -c Surface.cpp -lCGAL -frounding-math

Vector3f.o: Vector3f.h Vector3f.cpp
	g++ -O3 -std=c++11 -c Vector3f.cpp

SimpGPU.o: SimpGPU.h SimpGPU.cpp Surface.h kernel.o
	nvcc -O3 -std=c++11 -c SimpGPU.cpp

kernel.o: kernel.cuh kernel.cu
	nvcc -O3 -std=c++11 -c kernel.cu

common.o: common.h common.cpp
	g++ -O3 -std=c++11 -c common.cpp

clean:
	rm *.o Simplify
