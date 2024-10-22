#include<stdio.h>
#include<cuda_runtime.h>
__global__ void compute(double *a,double *l,int ind,int n){
    __shared__ double rowi[500];
    __shared__ double rowp[500];
    int i=blockIdx.y;
    int j=threadIdx.x;
    if(j<n){
        rowi[j]=a[i*n+j];
        rowp[j]=a[ind*n+j];
    }
    __syncthreads();
    if(i>ind&&j<n){
        if(j==ind){
            l[i*n+ind]=rowi[ind]/rowp[ind];
        }
        rowi[j]-=(rowi[ind]/rowp[ind])*rowp[j];
        rowi[ind]=0.0;
    }
    __syncthreads();
    if(j<n){
        a[i*n+j]=rowi[j];
    }
    if(i==ind&&j==ind){
        l[i*n+j]=1.0;
    }
    if(j>i)
    l[i*n+j]=0.0;
}

void forward(double *l,double *y,double *b,int n){
    for(int i=0;i<n;i++){
        y[i]=b[i];
        for(int j=0;j<i;j++){
            y[i]-=l[i*n+j]*y[j];
        }
    }
}

void backward(double *u,double *x,double *y,int n){
    for(int i=n-1;i>-1;i--){
        x[i]=y[i];
        for(int j=n-1;j>i;j--){
            x[i]-=u[i*n+j]*x[j];
        }
        x[i]/=u[i*n+i];
    }
}

int main(){
    int n;
    scanf("%d",&n);

    double* a=(double*)malloc(n*n*sizeof(double));
    for(int i=0;i<n;i++)
    for(int j=0;j<n;j++)
    scanf("%lf",&a[i*n+j]);
    
    double* b=(double*)malloc(n*sizeof(double));
    for(int i=0;i<n;i++)
    scanf("%lf",&b[i]);

    double* l=(double*)malloc(n*n*sizeof(double));
    double* y=(double*)malloc(n*sizeof(double));
    double* x=(double*)malloc(n*sizeof(double));

    double *dl,*da;
    cudaMalloc((void**)&dl,sizeof(double)*n*n);
    cudaMalloc((void**)&da,sizeof(double)*n*n);

    dim3 tpb(1,n,1);
    dim3 bpg(n,1,1);

    cudaMemcpy(da,a,sizeof(double)*n*n,cudaMemcpyHostToDevice);

    for(int i=0;i<n;i++){
        compute<<<tpb,bpg>>>(da,dl,i,n);
        cudaDeviceSynchronize();
    }

    cudaMemcpy(a,da,sizeof(double)*n*n,cudaMemcpyDeviceToHost);
    cudaMemcpy(l,dl,sizeof(double)*n*n,cudaMemcpyDeviceToHost);
    
    printf("%d\n",n);
    //printf("L Matrix:\n");
    for(int i=0;i<n;i++){
        for(int j=0;j<n;j++){
            printf("%lf ",l[i*n+j]);
        }
        printf("\n");
    }

    //printf("U Matrix:\n");
    for(int i=0;i<n;i++){
        for(int j=0;j<n;j++){
            printf("%lf ",a[i*n+j]);
        }
        printf("\n");
    }

    forward(l,y,b,n);
    backward(a,x,y,n);

    //printf("Solution:\n");
    for(int i=0;i<n;i++){
        printf("%lf\n",x[i]);
    }
    return 0;
}