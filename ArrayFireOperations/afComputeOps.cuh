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
#include <chrono>
using namespace std::chrono;
using namespace std;

class afCompute{
public:
    int iteration = 1;
    // begin of changes for unified interface
    af::array virtual getAfFromCuda(int *device_data);
    // end of changes for unified interface
    af::array virtual getAFGpuData(vector<int> data);
    af::array virtual afcpu2gpu(vector<int> data);
    af::array virtual getAFGpuData(vector<float> data);
    vector<int> virtual getAFCpuData(af::array deviceData);
    vector<int> virtual afgpu2cpu(af::array deviceData);
    vector<float> virtual getAFFloatCpuData(af::array deviceData);
    af::array virtual afSelection(af::array deviceData, string operation, int value);
    af::array virtual afFilter(af::array deviceData, string operation, int value);
    af::array virtual afSelectionArrays(af::array lhs, string operation, af::array rhs);
    af::array virtual afConjunction(af::array deviceLHS, af::array deviceRHS);
    af::array virtual afProduct(af::array deviceLHS, af::array deviceRHS);
    int virtual afSum(af::array deviceData);
    float virtual afAvg(af::array deviceData);
    int virtual afCountIf(af::array deviceData,int value);
    int virtual afCount(af::array deviceData);
    af::array virtual afJoin(af::array parent, af::array child);
    af::array virtual afPrefixSum(af::array deviceSelData);
    int virtual afFindMax(af::array deviceData);
    int virtual afFindMin(af::array deviceData);
    af::array virtual afSort(af::array deviceData,int order);
    af::array virtual afGroupBy(af::array keys, af::array values);
    af::array virtual afCountByKey(af::array data);
    af::array virtual afSumOfVectors(af::array vec1,af::array vec2);
    af::array virtual afSortByKey(af::array data, af::array dependent_data, int order);
    af::array virtual afAvgByKey(af::array keys, af::array values);
};

#endif //CROSS_LIBRARY_EXECUTION_AFCOMPUTEOPS_CUH
