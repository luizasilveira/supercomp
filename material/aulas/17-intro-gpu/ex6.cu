#include <thrust/device_vector.h>
#include <thrust/host_vector.h>
#include <thrust/functional.h>
#include <thrust/transform.h>
#include <iostream>
#include <math.h> 

int main() {
    thrust::device_vector<double> AAPL;
    thrust::device_vector<double> MSFT;
    thrust::device_vector<double> MEAN_DIF(2518,0);
    double stocks_AAPL, stocks_MSFT, mean;

    for(int i =0; i < 2518; i++){
        std::cin >> stocks_AAPL >> stocks_MSFT;
        AAPL.push_back(stocks_AAPL);
        MSFT.push_back(stocks_MSFT);
    }


    thrust::transform(AAPL.begin(), AAPL.end(), MSFT.begin(), MEAN_DIF.begin(), thrust::minus<double>());
    //double val = thrust::reduce(MEAN_DIF.begin(), MEAN_DIF.end());
    double val = thrust::reduce(MEAN_DIF.begin(), MEAN_DIF.end(),0,thrust::plus<double>());
    mean = val/2517;
    std::cout << "Média: " << fabs(mean) << "\n";

    // printf("V1: ");
    // for (thrust::device_vector<double>::iterator i = MEAN_DIF.begin(); i != MEAN_DIF.end(); i++) {
    //     std::cout << *i << " ";
    // }
    // printf("\n");

    // printf("V2: ");
    // for (thrust::device_vector<double>::iterator i = V2.begin(); i != V2.end(); i++) {
    //     std::cout << *i << " ";
    // }
    // printf("\n");

    // printf("V3: ");
    // for (thrust::device_vector<double>::iterator i = V3.begin(); i != V3.end(); i++) {
    //     std::cout << *i << " ";
    // }
    // printf("\n");

    // printf("V4: ");
    // for (thrust::device_vector<double>::iterator i = V4.begin(); i != V4.end(); i++) {
    //     std::cout << *i << " ";
    // }
    // printf("\n");

}
