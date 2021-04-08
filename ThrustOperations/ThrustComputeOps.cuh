//
// Created by hkumar on 26.08.20.
//

#ifndef CROSS_LIBRARY_EXECUTION_THRUSTCOMPUTEOPS_CUH
#define CROSS_LIBRARY_EXECUTION_THRUSTCOMPUTEOPS_CUH

#pragma once

#include <thrust/host_vector.h>
#include <thrust/device_vector.h>
//#include <thrust/detail/for_each.inl>
#include <thrust/binary_search.h>
#include <thrust/fill.h>
#include <thrust/gather.h>
#include <thrust/functional.h>
#include <thrust/iterator/constant_iterator.h>
#include <thrust/iterator/zip_iterator.h>
#include <thrust/pair.h>
#include <thrust/tuple.h>
#include <vector>
#include <string>
#include <chrono>
using namespace std::chrono;

using namespace std;

class ThrustCompute{
public:
    int iteration = 1;

    thrust::device_vector<int> virtual getThrustGpuData(vector<int> data);

    thrust::device_vector<int> virtual thrustcpu2gpu(vector<int> data);

    vector<int> virtual getThrustCpuData(thrust::device_vector<int> d_data);

    vector<int> virtual thrustgpu2cpu(thrust::device_vector<int> d_data);

    vector<float> virtual getThrustCpuData(thrust::device_vector<float> d_data);

    thrust::device_vector<int> virtual thrustSelection(thrust::device_vector<int> deviceData, string operation, int value);

    thrust::device_vector<int> virtual thrustFilter(thrust::device_vector<int> deviceData, string operation, int value);

    thrust::device_vector<int> virtual thrustSelectionArrays(thrust::device_vector<int> deviceLHS, string operation, thrust::device_vector<int> deviceRHS);

    thrust::device_vector<int> virtual thrustConjunction(thrust::device_vector<int> deviceLHS, thrust::device_vector<int> deviceRHS);

    thrust::device_vector<int> virtual thrustJoin(thrust::device_vector<int> parent, thrust::device_vector<int> child);

    thrust::device_vector<int> virtual thrustHashJoin(thrust::device_vector<int> parent, thrust::device_vector<int> child);

//    thrust::device_vector<int> virtual thrustJoin2(thrust::device_reference<int> parent, thrust::device_reference<int> child);

    int virtual thrustSum(thrust::device_vector<int> deviceData);

    float virtual thrustAvg(thrust::device_vector<int> deviceData);

    int virtual thrustCountIf(thrust::device_vector<int> deviceData,int value);

    int virtual thrustCount(thrust::device_vector<int> deviceData);

    thrust::device_vector<int> virtual thrustSort(thrust::device_vector<int> deviceData,int order);

    thrust::device_vector<int> virtual thrustSortByKey(thrust::device_vector<int> deviceData,
                                                       thrust::device_vector<int> dependentData,
                                                       int order);

    thrust::device_vector<int> virtual thrustProduct(thrust::device_vector<int> deviceLHS, thrust::device_vector<int> deviceRHS);

    thrust::device_vector<int> virtual thrustPrefixSum(thrust::device_vector<int> deviceSelData);

    thrust::device_vector<int> virtual thrustPrefixSum(thrust::device_vector<int> deviceSelData,
                                                       thrust::device_vector<int> data);

    int virtual thrustFindMax(thrust::device_vector<int> data);

    int virtual thrustFindMin(thrust::device_vector<int> data);

    thrust::device_vector<int> virtual thrustIN(thrust::device_vector<int> dataToFilter,
                                                thrust::device_vector<int> refData,
                                                thrust::device_vector<int> prefixSum);

    thrust::device_vector<int> virtual thrustGroupBy(thrust::device_vector<int> keys,
                                                thrust::device_vector<int> values);

    thrust::device_vector<int> virtual thrustCountByKey(thrust::device_vector<int> data);

    thrust::device_vector<float> virtual thrustAvgByKey(thrust::device_vector<int> keys,
                                                      thrust::device_vector<int> values);

//    thrust::device_vector<int> virtual thrustGather(thrust::device_vector<int> index,
//                                                    thrust::device_vector<int> values);

    thrust::device_vector<int> virtual thrustSumOfVectors(thrust::device_vector<int> array1,
                                                          thrust::device_vector<int> array2);

    void virtual thrustScatter(thrust::device_vector<int> data,
                               thrust::device_vector<int> map);

    void virtual thrustGather(thrust::device_vector<int> data,
                              thrust::device_vector<int> map);
};

#endif //CROSS_LIBRARY_EXECUTION_THRUSTCOMPUTEOPS_CUH
