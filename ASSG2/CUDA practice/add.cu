#include <iostream>
#include <cuda_runtime.h>

__global__ void add(int* a, int* b, int* c, int n) {
    int index = threadIdx.x + blockIdx.x * blockDim.x;
    if (index < n) {
        c[index] = a[index] + b[index];
    }
}

int main() {
    int n = 5;
    int a[n] = {1, 1, 1, 1, 1};
    int b[n] = {3, 4, 5, 4, 3};
    int c[n] = {0};
    int *da, *db, *dc;

    // Allocate device memory
    cudaError_t err;
    err = cudaMalloc((void**)&da, n * sizeof(int));
    if (err != cudaSuccess) {
        std::cerr << "CUDA error: " << cudaGetErrorString(err) << std::endl;
        return -1;
    }
    err = cudaMalloc((void**)&db, n * sizeof(int));
    if (err != cudaSuccess) {
        cudaFree(da);
        std::cerr << "CUDA error: " << cudaGetErrorString(err) << std::endl;
        return -1;
    }
    err = cudaMalloc((void**)&dc, n * sizeof(int));
    if (err != cudaSuccess) {
        cudaFree(da);
        cudaFree(db);
        std::cerr << "CUDA error: " << cudaGetErrorString(err) << std::endl;
        return -1;
    }

    // Copy data to device
    cudaMemcpy(da, a, n * sizeof(int), cudaMemcpyHostToDevice);
    cudaMemcpy(db, b, n * sizeof(int), cudaMemcpyHostToDevice);

    // Kernel launch
    int tpb = 256;
    int bpg = (n + tpb - 1) / tpb;
    add<<<bpg, tpb>>>(da, db, dc, n);

    // Copy result back to host
    cudaMemcpy(c, dc, n * sizeof(int), cudaMemcpyDeviceToHost);

    // Print results
    for (int i = 0; i < n; i++) {
        std::cout << c[i] << ' ';
    }
    std::cout << std::endl;

    // Free device memory
    cudaFree(da);
    cudaFree(db);
    cudaFree(dc);

    return 0;
}
