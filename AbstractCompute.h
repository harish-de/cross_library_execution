//
// Created by hkumar on 21.08.20.
//
#pragma once

#include <vector>
#include <string>

using namespace std;

class AbstractCompute{
public:
    void virtual selection(vector<int> data,string operation,int value){}

    void virtual setUnion(vector<int> lhs, vector<int> rhs){}

    void virtual setIntersection(vector<int> lhs, vector<int> rhs){}

    void virtual setDifference(vector<int> lhs, vector<int> rhs){}

    void virtual sort(vector<int> data,int order){} //0 - ascending, 1 - descending

    void virtual sum(vector<int> data){}

    void virtual findMax(vector<int> data){}
};
