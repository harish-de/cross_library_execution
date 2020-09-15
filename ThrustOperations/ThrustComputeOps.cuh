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
#include <vector>
#include <string>

using namespace std;

class ThrustCompute{
public:
    thrust::device_vector<int> virtual getThrustGpuData(vector<int> data);

    vector<int> virtual getThrustCpuData(thrust::device_vector<int> d_data);

    thrust::device_vector<int> virtual thrustSelection(thrust::device_vector<int> deviceData, string operation, int value);

    thrust::device_vector<int> virtual thrustSelectionArrays(thrust::device_vector<int> deviceLHS, string operation, thrust::device_vector<int> deviceRHS);

    thrust::device_vector<int> virtual thrustConjunction(thrust::device_vector<int> deviceLHS, thrust::device_vector<int> deviceRHS);

    thrust::device_vector<int> virtual thrustJoin(thrust::device_vector<int> parent, thrust::device_vector<int> child);

//    thrust::device_vector<int> virtual thrustJoin2(thrust::device_reference<int> parent, thrust::device_reference<int> child);


    int virtual thrustSum(thrust::device_vector<int> deviceData);

    float virtual thrustAvg(thrust::device_vector<int> deviceData);

    int virtual thrustCountIf(thrust::device_vector<int> deviceData);

    int virtual thrustCount(thrust::device_vector<int> deviceData);

    //    void virtual thrustSetUnion(vector<int> lhs, vector<int> rhs);
//
//    void virtual thrustSetIntersection(vector<int> lhs, vector<int> rhs);
//
//    void virtual thrustSetDifference(vector<int> lhs, vector<int> rhs);
//
    thrust::device_vector<int> virtual thrustSort(thrust::device_vector<int> deviceData,int order);

    thrust::device_vector<int> virtual thrustProduct(thrust::device_vector<int> deviceLHS, thrust::device_vector<int> deviceRHS);

    thrust::device_vector<int> virtual thrustPrefixSum(thrust::device_vector<int> deviceSelData);

    int virtual thrustFindMax(thrust::device_vector<int> data);

    int virtual thrustFindMin(thrust::device_vector<int> data);
};

#endif //CROSS_LIBRARY_EXECUTION_THRUSTCOMPUTEOPS_CUH
