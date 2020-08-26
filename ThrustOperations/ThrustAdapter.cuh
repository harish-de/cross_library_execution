//
// Created by hkumar on 26.08.20.
//

#ifndef CROSS_LIBRARY_EXECUTION_THRUSTADAPTER_CUH
#define CROSS_LIBRARY_EXECUTION_THRUSTADAPTER_CUH

#pragma once

#include "../Base/BaseCompute.h"
#include "ThrustComputeOps.cuh"

class ThrustAdapter: public BaseCompute{
public:
    ThrustCompute *ATC;
    ThrustAdapter(ThrustCompute *ATC_obj){
        ATC = ATC_obj;
    }

    void selection(vector<int> data,string operation,int value){
        int new_value = 1;
        ATC->thrustSelection(data,operation,value,new_value);
    }

    void setUnion(vector<int> lhs, vector<int> rhs){
        ATC->thrustSetUnion(lhs,rhs);
    }

    void setIntersection(vector<int> lhs, vector<int> rhs){
        ATC->thrustSetIntersection(lhs,rhs);
    }

    void setDifference(vector<int> lhs, vector<int> rhs){
        ATC->thrustSetDifference(lhs,rhs);
    }

    void sort(vector<int> data, int order) override{
        ATC->thrustSort(data,order);
    }

    void sum(vector<int> data){
        ATC->thrustSum(data);
    }

    void findMax(vector<int> data){
        ATC->thrustFindMax(data);
    }
};

#endif //CROSS_LIBRARY_EXECUTION_THRUSTADAPTER_CUH
