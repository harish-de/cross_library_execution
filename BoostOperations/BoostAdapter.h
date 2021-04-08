//
// Created by hkumar on 31.08.20.
//

#pragma once
#include "BoostComputeOps.h"
#include "../Base/BaseCompute.h"

#ifndef CROSS_LIBRARY_EXECUTION_BOOSTADAPTER_H
#define CROSS_LIBRARY_EXECUTION_BOOSTADAPTER_H

class BoostAdapter: public BaseCompute {
public:
    int execution_factor = BaseCompute::execution_factor;
    BoostCompute *ABC;
    BoostAdapter(BoostCompute *ABC_obj);
    vector<int> selection(vector<int> data,string operation,int value);
    vector<int> filter(vector<int> data,string operation,int value);
    vector<int> selectionArrays(vector<int> lhs,string operation,vector<int> rhs);
    vector<int> conjunction(vector<int> lhs, vector<int> rhs);
    vector<int> product(vector<int> lhs, vector<int> rhs);
    int sum(vector<int> data);
    float avg(vector<int> data);
    int countIf(vector<int> data,int value);
    int count(vector<int> data);
    vector<int> prefixSum(vector<int> data);
    int findMax(vector<int> data);
    int findMin(vector<int> data);
    vector<int> sort(vector<int> data,int order);
    vector<int> sortByKey(vector<int> data, vector<int> dependent_data, int order);
    vector<int> groupby(vector<int> keys,vector<int> values);
    vector<int> countByKey(vector<int> data);
    vector<int> join(vector<int> parent, vector<int> child);
    vector<float> virtual avgByKey(vector<int> keys, vector<int> values);
    vector<int> sumOfVectors(vector<int> array1, vector<int> array2);
    vector<int> getGPUData(vector<int> cpudata);
    vector<int> cpu2gpu(vector<int> cpudata);
    vector<int> getCPUData(vector<int> gpudata);
    vector<int> gpu2cpu(vector<int> gpudata);
    void scatter(vector<int> data, vector<int> map);
    void gather(vector<int> data,vector<int> map);
};

#endif //CROSS_LIBRARY_EXECUTION_BOOSTADAPTER_H

