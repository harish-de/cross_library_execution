//
// Created by hkumar on 26.08.20.
//

#ifndef CROSS_LIBRARY_EXECUTION_BASECOMPUTE_H
#define CROSS_LIBRARY_EXECUTION_BASECOMPUTE_H

#pragma once

#include <vector>
#include <string>

using namespace std;

class BaseCompute{
public:
    void virtual selection(vector<int> data,string operation,int value);

    void virtual setUnion(vector<int> lhs, vector<int> rhs);

    void virtual setIntersection(vector<int> lhs, vector<int> rhs);

    void virtual setDifference(vector<int> lhs, vector<int> rhs);

    void virtual sort(vector<int> data,int order); //0 - ascending, 1 - descending

    void virtual sum(vector<int> data);

    void virtual findMax(vector<int> data);
};

#endif //CROSS_LIBRARY_EXECUTION_BASECOMPUTE_H
