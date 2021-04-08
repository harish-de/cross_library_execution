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
    int execution_factor = 10;

    vector<int> virtual getGPUData(vector<int> cpudata);

    vector<int> virtual getCPUData(vector<int> gpudata);

    vector<int> virtual cpu2gpu(vector<int> cpudata);

    vector<int> virtual gpu2cpu(vector<int> gpudata);

    vector<int> virtual selection(vector<int> data,string operation,int value);

    vector<int> virtual filter(vector<int> data,string operation,int value);

    vector<int> virtual selectionArrays(vector<int> lhs,string operation,vector<int> rhs);

    vector<int> virtual conjunction(vector<int> lhs, vector<int> rhs);

    vector<int> virtual join(vector<int> parent, vector<int> child);

    vector<int> virtual block_nested_join(vector<int> parent, vector<int> child);

    vector<int> virtual hash_join(vector<int> parent, vector<int> child);

//    void virtual join2(vector<int> parent, vector<int> child);

    void virtual setUnion(vector<int> lhs, vector<int> rhs);

    void virtual setIntersection(vector<int> lhs, vector<int> rhs);

    void virtual setDifference(vector<int> lhs, vector<int> rhs);

    vector<int> virtual sort(vector<int> data,int order); //0 - ascending, 1 - descending

    vector<int> virtual sortByKey(vector<int> data, vector<int> dependent_data, int order);

    int virtual sum(vector<int> data);

    float virtual avg(vector<int> data);

    int virtual countIf(vector<int> data,int value);

    int virtual count(vector<int> data);

    vector<int> virtual product(vector<int> lhs, vector<int> rhs);

    int virtual findMax(vector<int> data);

    int virtual findMin(vector<int> data);

    vector<int> virtual prefixSum(vector<int> selData);

    vector<int> virtual prefixSum(vector<int> bitmapdata,vector<int> colData);

    vector<vector<int>> virtual readLineItem(std::string filepath);

    vector<vector<int>> virtual readCustomer(std::string filepath);

    vector<vector<int>> virtual readOrders(std::string filepath);

    vector<vector<int>> virtual readNation(std::string filepath);

    vector<vector<int>> virtual readRegion(std::string filepath);

    vector<vector<int>> virtual readPart(std::string filepath);

    vector<vector<int>> virtual readSupplier(std::string filepath);

    vector<vector<int>> virtual readPartSupp(std::string filepath);

    vector<vector<int>> virtual getTransposedVector(vector<vector<int>> &tableData);

    vector<int> virtual getPKColumn(int PK_size, vector<int> selResult);

    vector<int> virtual getFKColumn(int FK_size, vector<int> selResult);

    vector<vector<int>> virtual deleteTuples(vector<vector<int>> data, vector<int> index);

    vector<vector<int>> virtual joinTuples(vector<vector<int>> PK_data,vector<vector<int>> FK_data,
                                           vector<int> joinIndex);

    vector<vector<int>> virtual joinTuples(vector<int> PK_data,vector<int> FK_data,
                                           int PK_size, vector<int> joinIndex,
                                           int i, int j, int offset);

    vector<int> virtual IN(vector<int> dataToFilter,
                                        vector<int> refData,
                                        vector<int> prefixSum);

    vector<int> virtual groupby(vector<int> keys,
                                vector<int> values);

    vector<int> virtual countByKey(vector<int> data);

    vector<float> virtual avgByKey(vector<int> keys, vector<int> values);

    vector<vector<int>> virtual joinTables(vector<int> FK_index,vector<int> PK_column, vector<int> FK_match);

//    vector<int> virtual gather(vector<int> index, vector<int> values);

    vector<int> virtual sumOfVectors(vector<int> array1, vector<int> array2);

    vector<int> virtual concatVectors(vector<int> array1, vector<int> array2);

    void virtual scatter(vector<int> data, vector<int> map);

    void virtual gather(vector<int> data,vector<int> map);
};

#endif //CROSS_LIBRARY_EXECUTION_BASECOMPUTE_H
