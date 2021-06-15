//nvcc -arch=sm_70 -std=c++14 ex3.cu -o ex3
#include <thrust/device_vector.h>
#include <thrust/host_vector.h>
#include <iostream>
#include <chrono>

int main() {
    double stocks;
    std::cin >> stocks;
    thrust::host_vector<double> host;

    for(int i =0; i < 2517; i++){
        std::cin >> stocks;
        host.push_back(stocks);
    }

    /* na linha abaixo os dados são copiados
       para GPU */
    thrust::device_vector<double> dev(host);  

    double val = thrust::reduce(dev.begin(), dev.end(),0,thrust::plus<double>());
    double mean = val/2517;
    std::cout << "Média: " << mean << "\n";

    double val2 = thrust::reduce(dev.begin()+2152, dev.end());
    double mean365 = val2/365;
    std::cout << "Média último ano: " << mean365 << "\n";

    // auto result = thrust::minmax_element(dev.begin(), dev.end());
    auto result = thrust::minmax_element(dev.begin(), dev.end());
    auto result2 = thrust::minmax_element(dev.end() - 365, dev.end());
    std::cout << "Mínimo 10 anos: " << *(result.first) << "\n";  
    std::cout << "Máximo 10 anos: " << *(result.second) << "\n";  
    std::cout << "Mínimo último ano: " << *(result2.first) << "\n";  
    std::cout << "Máximo último ano: " << *(result2.second)<< "\n";  


    // std::cerr << "elapsed time: " << elapsed_seconds.count() << "s\n";  

}
