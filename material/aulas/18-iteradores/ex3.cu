#include <thrust/device_vector.h>
#include <thrust/host_vector.h>
#include <thrust/functional.h>
#include <thrust/transform.h>
#include <iostream>
#include <math.h> 

// thrust::device_vector<int> v(5, 0); // vetor de 5 ints zerado
// // v = {0, 0, 0, 0, 0}
// thrust::sequence(v.begin(), v.end()); // preenche com 0, 1, 2, ....
// // v = {0, 1, 2, 3, 4}
// thrust::fill(v.begin(), v.begin()+2, 13); // dois primeiros elementos = 13
// // v = {13, 13, 2, 3, 4}

int main() {
    thrust::device_vector<double> stocks;
    // thrust::device_vector<double> s_dif(2518,0);
    double stock;

    for(int i =0; i < 2518; i++){
        std::cin >> stock;
        stocks.push_back(stock);
        
    }

    thrust::device_vector<double> ganho_diario(stocks.size() -1);

    thrust::transform(stocks.begin() + 1, stocks.end(), stocks.begin(), ganho_diario.begin(), thrust::minus<double>());

    printf("Ganho: ");
    for (thrust::device_vector<double>::iterator i = ganho_diario.begin(); i != ganho_diario.end(); i++) {
        std::cout << *i << " ";
        std::cout << "\n";
    }
    // printf("\n");
    //std::cout << "DIferença: " << s_dif << "\n";

    // int N = AAPL.size();
    // thrust::transform(AAPL.begin(), AAPL.end(), MSFT.begin(), MEAN_DIF.begin(), thrust::minus<double>());
    // //double val = thrust::reduce(MEAN_DIF.begin(), MEAN_DIF.end());
    // double val = thrust::reduce(MEAN_DIF.begin(), MEAN_DIF.end(),0,thrust::plus<double>());
    // mean = val/2517;
    // std::cout << "Média: " << fabs(mean) << "\n";

    // thrust::device_vector<double> MV_DIF(N); // vetor de 5 ints zerado
    // //thrust::fill(MV_DIF.begin(), MV_DIF.end(), mean); // dois primeiros elementos = 13


    // // minus a constant (mean)
    // thrust::transform(MEAN_DIF.begin(), MEAN_DIF.end(), thrust::constant_iterator<double>(mean), MV_DIF.begin(), thrust::minus<double>());
    // // thrust::transform(MEAN_DIF.begin(), MEAN_DIF.end(), MV.begin(), MV_DIF.begin(), thrust::minus<double>());

    // // multiplica por ele mesmo (**2)
    // thrust::transform(MV_DIF.begin(), MV_DIF.end(), MV_DIF.begin(), MV_DIF.begin(), thrust::multiplies<double>());

    // // Somatoria
    // //thrust::reduce(MEAN_DIF.begin(), MEAN_DIF.end(),0,thrust::plus<double>());
    // double val2 = thrust::reduce(MV_DIF.begin(), MV_DIF.end(), 0,thrust::plus<double>());
    // var = val2/N;
    // std::cout << "Variância: " << var << "\n";

}
