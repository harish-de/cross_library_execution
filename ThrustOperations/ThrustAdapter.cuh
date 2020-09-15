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
    ThrustCompute *ATC;
    ThrustAdapter(ThrustCompute *ATC_obj);
    vector<int> selection(vector<int> data,string operation,int value);
    vector<int> conjunction(vector<int> lhs, vector<int> rhs);
    vector<int> product(vector<int> lhs,vector<int> rhs);
    int sum(vector<int> data);
    vector<int> sort(vector<int> data,int order);
    float avg(vector<int> data);
    int countIf(vector<int> data);
    int count(vector<int> data);
    vector<int> join(vector<int> parent, vector<int> child);
    vector<int> prefixSum(vector<int> data);
    int findMax(vector<int> data);
    int findMin(vector<int> data);
    void join2(vector<int> parent, vector<int> child);
};

#endif //CROSS_LIBRARY_EXECUTION_THRUSTADAPTER_CUH

