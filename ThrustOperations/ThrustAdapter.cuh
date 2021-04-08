//
// Created by hkumar on 31.08.20.
//

#ifndef CROSS_LIBRARY_EXECUTION_THRUSTADAPTER_CUH
#define CROSS_LIBRARY_EXECUTION_THRUSTADAPTER_CUH

#pragma once

#include <numeric>
#include "../Base/BaseCompute.h"
#include "ThrustComputeOps.cuh"
#include <boost/range/adaptor/sliced.hpp>
using boost::adaptors::sliced;
#include <vector>

class ThrustAdapter: public BaseCompute {
public:
    int execution_factor = BaseCompute::execution_factor;
    ThrustCompute *ATC;
    ThrustAdapter(ThrustCompute *ATC_obj);
    vector<int> selection(vector<int> data,string operation,int value);
    vector<int> filter(vector<int> data,string operation,int value);
    vector<int> selectionArrays(vector<int> lhs,string operation,vector<int> rhs);
    vector<int> conjunction(vector<int> lhs, vector<int> rhs);
    vector<int> product(vector<int> lhs,vector<int> rhs);
    int sum(vector<int> data);
    vector<int> sort(vector<int> data,int order);
    vector<int> sortByKey(vector<int> data, vector<int> dependent_data, int order);
    float avg(vector<int> data);
    int countIf(vector<int> data,int value);
    int count(vector<int> data);
    vector<int> join(vector<int> parent, vector<int> child);
    vector<int> prefixSum(vector<int> data);
    vector<int> prefixSum(vector<int> bitmapdata,vector<int> colData);
    int findMax(vector<int> data);
    int findMin(vector<int> data);
//    vector<int> block_nested_join(vector<int> parent, vector<int> child);
//    vector<int> hash_join(vector<int> parent, vector<int> child);
//    vector<int> IN(vector<int> dataToFilter,
//                           vector<int> refData,
//                           vector<int> prefixSum);
    vector<int> groupby(vector<int> keys,
                                       vector<int> values);
    vector<int> countByKey(vector<int> data);
    vector<float> avgByKey(vector<int> keys, vector<int> values);
//    vector<int> gather(vector<int> index, vector<int> values);
    vector<int> sumOfVectors(vector<int> array1, vector<int> array2);

    vector<int> getGPUData(vector<int> cpudata);
    vector<int> getCPUData(vector<int> gpudata);
    vector<int> cpu2gpu(vector<int> cpudata);
    vector<int> gpu2cpu(vector<int> gpudata); 
    void scatter(vector<int> data, vector<int> map);
    void gather(vector<int> data, vector<int> map);
};

#endif //CROSS_LIBRARY_EXECUTION_THRUSTADAPTER_CUH

