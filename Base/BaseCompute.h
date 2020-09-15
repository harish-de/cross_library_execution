//
// Created by hkumar on 26.08.20.
//

#ifndef CROSS_LIBRARY_EXECUTION_BASECOMPUTE_H
#define CROSS_LIBRARY_EXECUTION_BASECOMPUTE_H

#pragma once

#include <vector>
#include <string>
#include <chrono>
using namespace std::chrono;
using namespace std;

class BaseCompute{

public:
    vector<int> virtual selection(vector<int> data,string operation,int value);

    vector<int> virtual selectionArrays(vector<int> lhs,string operation,vector<int> rhs);

    vector<int> virtual conjunction(vector<int> lhs, vector<int> rhs);

    vector<int> virtual join(vector<int> parent, vector<int> child);

    void virtual join2(vector<int> parent, vector<int> child);

    void virtual setUnion(vector<int> lhs, vector<int> rhs);

    void virtual setIntersection(vector<int> lhs, vector<int> rhs);

    void virtual setDifference(vector<int> lhs, vector<int> rhs);

    vector<int> virtual sort(vector<int> data,int order); //0 - ascending, 1 - descending

    int virtual sum(vector<int> data);

    float virtual avg(vector<int> data);

    int virtual countIf(vector<int> data);

    int virtual count(vector<int> data);

    vector<int> virtual product(vector<int> lhs, vector<int> rhs);

    int virtual findMax(vector<int> data);

    int virtual findMin(vector<int> data);

    vector<int> virtual prefixSum(vector<int> selData);

    vector<vector<int>> virtual readLineItem();

    vector<vector<int>> virtual readCustomer();

    vector<vector<int>> virtual readOrders();

    vector<vector<int>> virtual readNation();

    vector<vector<int>> virtual readRegion();

    vector<vector<int>> virtual readPart();

    vector<vector<int>> virtual readSupplier();

    vector<vector<int>> virtual readPartSupp();

    vector<vector<int>> virtual getTransposedVector(vector<vector<int>> &tableData);

    vector<int> virtual getPKColumn(int PK_size, vector<int> selResult);

    vector<int> virtual getFKColumn(int FK_size, vector<int> selResult);

    vector<vector<int>> virtual deleteTuples(vector<vector<int>> data, vector<int> index);

//    vector<vector<int>> virtual joinTuples(vector<vector<int>> PK_data,vector<vector<int>> FK_data,
//                                           int PK_size, vector<int> joinIndex);

    vector<vector<int>> virtual joinTuples(vector<int> PK_data,vector<int> FK_data,
                                           int PK_size, vector<int> joinIndex,
                                           int i, int j, int offset);
};

#endif //CROSS_LIBRARY_EXECUTION_BASECOMPUTE_H
