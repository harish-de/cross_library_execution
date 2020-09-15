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
    BoostCompute *ABC;
    BoostAdapter(BoostCompute *ABC_obj);
    vector<int> selection(vector<int> data,string operation,int value);
    vector<int> conjunction(vector<int> lhs, vector<int> rhs);
    vector<int> product(vector<int> lhs, vector<int> rhs);
    int sum(vector<int> data);
    float avg(vector<int> data);
    int countIf(vector<int> data);
    int count(vector<int> data);
    vector<int> prefixSum(vector<int> data);
    int findMax(vector<int> data);
    int findMin(vector<int> data);
};

#endif //CROSS_LIBRARY_EXECUTION_BOOSTADAPTER_H

