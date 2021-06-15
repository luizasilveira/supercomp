//g++ -O3 -fopenmp pi-numeric-integration.cpp -o pi

#include <iostream>
#include <chrono>

static long num_steps = 1000000000;
double step;

int main() {
    double pi, sum = 0.0;
    //criar um sum para cada thread
    // double pi, sum1 = 0.0 ,sum2 = 0.0;
    step = 1.0 / (double)num_steps;

    auto start_time = std::chrono::high_resolution_clock::now();
    //cria região paralela
    //COlchete na linha de baixo
    // #pragma omp parallel
    // {
    //     #pragma omp master
    //     {
    //         //Nao pode acessar o mesmo dado em duas threads diferentes
    //         #pragma omp task
    //         {
    //             for (int i = 0; i < num_steps/2; i++) {
    //                 double x = (i + 0.5) * step;
    //                 sum1 = sum1 + 4.0 / (1.0 + x * x);
    //             }
    //         }

    //         #pragma omp task
    //         {
    //             for (int i = num_steps/2; i < num_steps ; i++) {
    //                 double x = (i + 0.5) * step;
    //                 sum2 = sum2 + 4.0 / (1.0 + x * x);
    //             }
    //         }
    //     }

    // }

    #pragma omp parallel for reduction(+:sum)

    for (int i = 0; i < num_steps ; i++) {
        double x = (i + 0.5) * step;
        sum = sum + 4.0 / (1.0 + x * x);
    }


    pi = step * (sum);
    auto end_time = std::chrono::high_resolution_clock::now();
    auto runtime = std::chrono::duration_cast<std::chrono::seconds> (end_time - start_time);
    
    std::cout << "O valor de pi calculado com " << num_steps << " passos levou ";
    std::cout << runtime.count() << " segundo(s) e chegou no valor : ";
    std::cout.precision(17);
    std::cout << pi << std::endl;
}
