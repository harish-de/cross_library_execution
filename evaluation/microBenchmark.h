//
// Created by hkumar on 20.01.21.
//

#ifndef CROSS_LIBRARY_EXECUTION_MICROBENCHMARK_H
#define CROSS_LIBRARY_EXECUTION_MICROBENCHMARK_H

#pragma once
#include "../Base/BaseCompute.h"
#include "../ThrustOperations/ThrustComputeOps.cuh"
#include "../ArrayFireOperations/afComputeOps.cuh"
#include "../ThrustOperations/ThrustAdapter.cuh"
#include "../ArrayFireOperations/ArrayFireAdapter.cuh"
#include <random>

class evalOperators {
public:
    size_t datasize = pow(2, 20);
//    size_t datasize = 6000000;

    void evaluateFilter(BaseCompute *adapter);

    void evalJoin(BaseCompute *adapter, int percent);

    void evalGroupBy(BaseCompute *adapter,int percent);

    void evalScatterGather(BaseCompute *adapter);

    void evalTransferTime(BaseCompute *adapter);

    void callOperators(int percent);

   void generate_uniform_random(unsigned int* agg_input, size_t size, size_t ul){
        int current = 0;
        std::random_device rd;
        std::mt19937 mte(rd());
        uniform_int_distribution<int> dist(0+ current,ul+ current);
        std::generate_n(agg_input,datasize,[&] () {return dist(mte);});
    }

};
#endif //CROSS_LIBRARY_EXECUTION_MICROBENCHMARK_H


