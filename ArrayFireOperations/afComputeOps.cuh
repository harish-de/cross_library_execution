//
// Created by hkumar on 31.08.20.
//

#ifndef CROSS_LIBRARY_EXECUTION_AFCOMPUTEOPS_CUH
#define CROSS_LIBRARY_EXECUTION_AFCOMPUTEOPS_CUH

#pragma once
#include <af/array.h>
#include <arrayfire.h>
#include <vector>
#include <iostream>
using namespace std;

class afCompute{
public:
    af::array virtual getAFGpuData(vector<int> data);
    vector<int> virtual getAFCpuData(af::array deviceData);
    af::array virtual afSelection(af::array deviceData, string operation, int value);
    af::array virtual afConjunction(af::array deviceLHS, af::array deviceRHS);
    af::array virtual afProduct(af::array deviceLHS, af::array deviceRHS);
    int virtual afSum(af::array deviceData);
    float virtual afAvg(af::array deviceData);
    int virtual afCountIf(af::array deviceData);
    int virtual afCount(af::array deviceData);
    af::array virtual afJoin(af::array parent, af::array child);
    af::array virtual afPrefixSum(af::array deviceSelData);
    int virtual afFindMax(af::array deviceData);
    int virtual afFindMin(af::array deviceData);
};

#endif //CROSS_LIBRARY_EXECUTION_AFCOMPUTEOPS_CUH
