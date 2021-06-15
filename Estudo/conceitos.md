# Paralelismo

## Tarefa:
Faço em paralelo duas tarefas independentes.
Se houver dependencias quebro em partes independentes e rodo em ordem

* Tarefa - bloco de codigo (entre {})
* Uma tarefa pode gerar novas tarefas
* Cada thread pode ser alocada para rodar uma tarefa
* Não existe ordenaçao no inicio das tarefas
* Tarefas são unidades de trabalho independentes

* #pragma omp parallel - Cria conjunto de threads
* #pragma omp master - Thread 0 organiza as tarefas (codigo roda 
somente na thread de id 0)
* #pragma omp task - Criação de tarefas - Tarefas executadas por alguma thread em alguma ordem


## Dados:
faço em paralelo a mesma operação(lenta) para todos os elementos em um conjunto de dados(Grande)

## Modelo fork-join

* Todas as threads rodam a mesma função
* Espero todos acabarem para recolher os resultados
* Digo explicitamnete quais variaveis são usadas em cada thread e se elas são locais da thread ou se são compartilhadas
# 

# GPU 

* compila: nvcc -arch=sm_70 -std=c++14 ex4.cu -o ex4
* Cria vetor Host(CPU) - thrust::host_vector<double> host()
* Cria vetor Device(GPU) - thrust::host_vector<double> host()
* dados são copiados para GPU - thrust::host_vector<double> dev(host)
* Adiciona Seuqencia de numero - thrust::sequence(V1.begin(), V1.end());
* Preenche com o valor escolhido - thrust::fill(V2.begin()+5, V2.end(), 10);
* Soma dois vetores (v1 e v2) e salva no v3 - thrust::transform(V1.begin(), V1.end(), V2.begin(), V3.begin(), thrust::plus<double>());
    thrust::minus<double>()
    thrust::constant_iterator<double>(0.5)
    thrust::multiplies<double>()

* for (thrust::device_vector<double>::iterator i = V1.begin(); i != V1.end(); i++) {
            std::cout << *i << " ";
       }

* struct is_greater
{
  __host__ __device__
  bool operator()(const double &x)
  {
    return x > 0;
  }
};

* struct is_negative
{
  __host__ __device__
  bool operator()(const double &x)
  {
    return x < 0;
  }
};

* Conta os valores que satisfazem o struct - thrust::count_if(ganho_diario.begin(), ganho_diario.end(), is_greater());

* Substitui os valores que satisfazem o struct - thrust::replace_if(thrust::device, ganho_diario.begin(), ganho_diario.end(), ganho_diario.begin(), is_negative(), 0);


