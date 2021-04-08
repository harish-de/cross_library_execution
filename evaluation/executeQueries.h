//
// Created by hkumar on 26.08.20.
//

#ifndef CROSS_LIBRARY_EXECUTION_EXECUTEQUERIES_H
#define CROSS_LIBRARY_EXECUTION_EXECUTEQUERIES_H

#pragma once
#include "../Base/BaseCompute.h"
#include "../ThrustOperations/ThrustComputeOps.cuh"
//#include "../BoostOperations/BoostComputeOps.h"
#include "../ArrayFireOperations/afComputeOps.cuh"

class executeTpchQueries{
public:
    int execution_factor = 2;
    void call_tpch_query(int queryNum);
    void transfer_time(int scalefactor);

    void data_transfer(std::string filename, BaseCompute *adapter);

    void executeQ1(BaseCompute *adapter);

    void executeQ3(BaseCompute *adapter);

    void executeQ4(BaseCompute *adapter);

    void executeQ6(BaseCompute *adapter);
};

#endif //CROSS_LIBRARY_EXECUTION_EXECUTEQUERIES_H
