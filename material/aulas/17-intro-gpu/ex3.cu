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
    auto start = std::chrono::steady_clock::now();   
    thrust::device_vector<double> dev(host);  
    auto end = std::chrono::steady_clock::now();
    std::chrono::duration<double> elapsed_seconds = end-start;
    
    printf("Host vector: ");
    for (auto i = host.begin(); i != host.end(); i++) {
        std::cout << *i << " "; // este acesso é rápido -- CPU
    }
    printf("\n");
    
    printf("Device vector: ");
    for (auto i = dev.begin(); i != dev.end(); i++) {
        std::cout << *i << " "; // este acesso é lento! -- GPU
    }
    printf("\n");

    std::cerr << "elapsed time: " << elapsed_seconds.count() << "s\n";  

}
