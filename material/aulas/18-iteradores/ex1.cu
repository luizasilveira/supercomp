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
    thrust::device_vector<double> AAPL;
    thrust::device_vector<double> MSFT;
    thrust::device_vector<double> MEAN_DIF(2518,0);
    double stocks_AAPL, stocks_MSFT, mean, var;

    for(int i =0; i < 2518; i++){
        std::cin >> stocks_AAPL >> stocks_MSFT;
        AAPL.push_back(stocks_AAPL);
        MSFT.push_back(stocks_MSFT);
    }

    int N = AAPL.size();
    thrust::transform(AAPL.begin(), AAPL.end(), MSFT.begin(), MEAN_DIF.begin(), thrust::minus<double>());
    //double val = thrust::reduce(MEAN_DIF.begin(), MEAN_DIF.end());
    double val = thrust::reduce(MEAN_DIF.begin(), MEAN_DIF.end(),0,thrust::plus<double>());
    mean = val/2517;
    std::cout << "Média: " << fabs(mean) << "\n";

    thrust::device_vector<double> MV_DIF(N); // vetor de 5 ints zerado
    //thrust::fill(MV_DIF.begin(), MV_DIF.end(), mean); // dois primeiros elementos = 13


    // minus a constant (mean)
    thrust::transform(MEAN_DIF.begin(), MEAN_DIF.end(), thrust::constant_iterator<double>(mean), MV_DIF.begin(), thrust::minus<double>());
    // thrust::transform(MEAN_DIF.begin(), MEAN_DIF.end(), MV.begin(), MV_DIF.begin(), thrust::minus<double>());

    // multiplica por ele mesmo (**2)
    thrust::transform(MV_DIF.begin(), MV_DIF.end(), MV_DIF.begin(), MV_DIF.begin(), thrust::multiplies<double>());

    // Somatoria
    //thrust::reduce(MEAN_DIF.begin(), MEAN_DIF.end(),0,thrust::plus<double>());
    double val2 = thrust::reduce(MV_DIF.begin(), MV_DIF.end(), 0,thrust::plus<double>());
    var = val2/N;
    std::cout << "Variância: " << var << "\n";

}
