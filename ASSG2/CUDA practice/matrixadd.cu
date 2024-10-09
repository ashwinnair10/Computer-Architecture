#include<bits/stdc++.h>
#include<cuda_runtime.h>
using namespace std;
__global__ void matrixadd(int *a,int *b, int *c,int n){
    int i=blockIdx.y*blockDim.y+threadIdx.y;
    int j=blockIdx.x*blockDim.x+threadIdx.x;
    if(i<n&&j<n){
        c[n*n+j]=a[n*n+j]+b[n*n+j];
    }
}
int main(){
    int n=3;
    int a[3][3]={{1,1,1},{2,2,2},{3,3,3}};
    int b[3][3]={{-11,1,1},{2,2,2},{3,3,3}};
    int c[3][3]={{0}};
    int *da,*db,*dc;
    cudaMalloc((void**)&da,n*n*sizeof(int));
    cudaMalloc((void**)&db,n*n*sizeof(int));
    cudaMalloc((void**)&dc,n*n*sizeof(int));
    cudaMemcpy(da,a,n*n*sizeof(int),cudaMemcpyDeviceToHost);
    cudaMemcpy(db,b,n*n*sizeof(int),cudaMemcpyDeviceToHost);
    dim3 blockSize(16,16);
    dim3 gridSize((n+blockSize.x-1)/blockSize.x,(n+blockSize.y-1)/blockSize.y);
    matrixadd<<<gridSize,blockSize>>>(da,db,dc,n);
    cudaMemcpy(c,dc,n*n*sizeof(int),cudaMemcpyHostToDevice);
    for(int i=0;i<n;i++){
        for(int j=0;j<n;j++){
            cout<<c[i][j]<<' ';
        }
        cout<<'\n';
    }
    cudaFree(da);
    cudaFree(db);
    cudaFree(dc);
    return 0;
}