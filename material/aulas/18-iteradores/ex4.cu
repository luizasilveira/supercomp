#include <thrust/device_vector.h>
#include <thrust/host_vector.h>
#include <thrust/functional.h>
#include <thrust/transform.h>
#include <iostream>
#include <math.h> 
#include <thrust/iterator/constant_iterator.h>

struct is_greater
{
  __host__ __device__
  bool operator()(const double &x)
  {
    return x > 0;
  }
};

struct is_negative
{
  __host__ __device__
  bool operator()(const double &x)
  {
    return x < 0;
  }
};

int main() {
    thrust::device_vector<double> AAPL;    
    double stocks_AAPL;

    while(std::cin){
        std::cin >> stocks_AAPL;
        AAPL.push_back(stocks_AAPL);
    }

    int N = AAPL.size();
    thrust::device_vector<double> ganho_diario(N-1);

    thrust::transform(AAPL.begin()+1, AAPL.end(), AAPL.begin(), ganho_diario.begin(), thrust::minus<double>());
    
    // conta quantos números positivos tem no vetor
    int subiu = thrust::count_if(ganho_diario.begin(), ganho_diario.end(), is_greater());
    std::cout << "As ações subiram "<< subiu << " vezes";
    // printf("Ganho: ");
    // for (thrust::device_vector<double>::iterator i = ganho_diario.begin(); i != ganho_diario.end(); i++) {
    //     std::cout << *i << " ";
    // }
    printf("\n");

    // zera elementos negativos
    thrust::replace_if(thrust::device, ganho_diario.begin(), ganho_diario.end(), ganho_diario.begin(), is_negative(), 0);

    double aumento = thrust::reduce(ganho_diario.begin(), ganho_diario.end());
    double aumento_medio = aumento/subiu;
    std::cout << "O aumento médio foi de "<< aumento_medio;

    printf("\n");


}
