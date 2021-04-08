#pragma once
#include "evaluation/executeQueries.h"
#include "evaluation/microBenchmark.h"
#include <iostream>
#include <cstdlib>


int main(){
//int main(int argc, char *argv[]){
//    int queryNum = atoi(argv[1]);//Percent value


    auto queries = new executeTpchQueries();
//    auto queries = new evalOperators();
//    queries->callOperators(percent);

//    queries->generate_uniform_random(pow(2,10),8);
//    queries->callOperators(percent);
    queries->call_tpch_query(6);
//    queries->transfer_time();

}

/*int main(void ){
    vector<int> vec_data;
    int *a;
    int *gpu_a;
    int N = 50;

    for (int i=0; i<N; i++) {
        vec_data[i] = i;
    }

    cout << vec_data.size() << endl;

}*/

