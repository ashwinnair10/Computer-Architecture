#include<bits/stdc++.h>
using namespace std;
class Inverse {
public:
    int n;
    vector<vector<double>> a;
    vector<vector<double>> inv;
    Inverse(int ni, vector<vector<double>> ai,vector<vector<double>> i) {
        n = ni;
        a = ai;
        inv = i;
    }
    void getCofactor(const vector<vector<double>>& a, vector<vector<double>>& temp, int p, int q, int n) {
        int i = 0, j = 0;
        for (int row = 0; row < n; row++) {
            for (int col = 0; col < n; col++) {
                if (row != p && col != q) {
                    temp[i][j++] = a[row][col];
                    if (j == n - 1) {
                        j = 0;
                        i++;
                    }
                }
            }
        }
    }
    double determinant(const vector<vector<double>>& a, int n) {
        double d = 0;
        if (n == 1)
            return a[0][0];
        vector<vector<double>> temp(n, vector<double>(n));
        int sign = 1;
        for (int f = 0; f < n; f++) {
            getCofactor(a, temp, 0, f, n);
            d += sign * a[0][f] * determinant(temp, n - 1);
            sign = -sign;
        }
        return d;
    }
    void adjoint(const vector<vector<double>>& a, vector<vector<double>>& adj) {
        if (n == 1) {
            adj[0][0] = 1;
            return;
        }
        int sign = 1;
        vector<vector<double>> temp(n, vector<double>(n));
        for (int i = 0; i < n; i++) {
            for (int j = 0; j < n; j++) {
                getCofactor(a, temp, i, j, n);
                sign = ((i + j) % 2 == 0) ? 1 : -1;
                adj[j][i] = (sign) * (determinant(temp, n - 1));
            }
        }
    }
    vector<vector<double>> inverse() {
        double det = determinant(a, n);
        if (det == 0) {
            cout << "Singular Inverse, can't find its inverse" << endl;
            return {{}};
        }
        vector<vector<double>> adj(n, vector<double>(n));
        adjoint(a, adj);
        for (int i = 0; i < n; i++)
            for (int j = 0; j < n; j++)
                inv[i][j] = adj[i][j] / det;
        return inv;
    }
    void display() {
        for (const auto& row : inv) {
            for (const auto& val : row)
                cout << val << " ";
            cout << endl;
        }
    }
};
class MatrixMult{
public:
    vector<vector<double>> a;
    vector<vector<double>> b;
    vector<vector<double>> c;
    MatrixMult(vector<vector<double>> ai,vector<vector<double>> bi, vector<vector<double>> ci){
        a=ai;
        b=bi;
        c=ci;
    }
    vector<vector<double>> mult(){
        if(a[0].size()!=b.size()){
            cout<<"Multiplication not possible";
            return {{}};
        }
        for(int i=0;i<a.size();i++){
            for(int j=0;j<b[0].size();j++){
                for(int k=0;k<a[0].size();k++){
                    c[i][j]+=a[i][k]*b[k][j];
                }
            }
        }
        return c;
    }
};
int main(){
    int n;
    cin>>n;
    vector<vector<double>> a(n,vector<double>(n));
    for(int i=0;i<n;i++){
        for(int j=0;j<n;j++){
            cin>>a[i][j];
        }
    }
    vector<vector<double>> ai(n,vector<double>(n));
    Inverse* in=new Inverse(n,a,ai);
    ai=in->inverse();
    vector<vector<double>> b(n,vector<double>(1));
    for(int i=0;i<n;i++){
        cin>>b[i][0];
    }
    vector<vector<double>> op(n,vector<double>(1));
    MatrixMult* mm=new MatrixMult(ai,b,op);
    op=mm->mult();
    for(int i=0;i<n;i++)
    cout<<op[i][0]<<' ';
    cout<<'\n';
    return 0;
}