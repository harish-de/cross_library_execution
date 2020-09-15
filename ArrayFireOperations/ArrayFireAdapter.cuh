//
// Created by hkumar on 01.09.20.
//

#ifndef CROSS_LIBRARY_EXECUTION_ARRAYFIREADAPTER_CUH
#define CROSS_LIBRARY_EXECUTION_ARRAYFIREADAPTER_CUH

#pragma once
#include "afComputeOps.cuh"
#include "../Base/BaseCompute.h"

class afAdapter: public BaseCompute {
public:
    afCompute *AAFC;
    afAdapter(afCompute *AAFC_obj);
    vector<int> selection(vector<int> data,string operation,int value);
    vector<int> conjunction(vector<int> lhs, vector<int> rhs);
    vector<int> product(vector<int> lhs,vector<int> rhs);
    int sum(vector<int> data);
    float avg(vector<int> data);
    int countIf(vector<int> data);
    int count(vector<int> data);
    vector<int> join(vector<int> parent,vector<int> child);
    vector<int> prefixSum(vector<int> data);
    int findMax(vector<int> data);
    int findMin(vector<int> data);
};

#endif //CROSS_LIBRARY_EXECUTION_ARRAYFIREADAPTER_CUH
