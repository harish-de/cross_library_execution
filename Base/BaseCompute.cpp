//
// Created by hkumar on 26.08.20.
//
#pragma once

#include <fstream>
#include <sstream>
#include <algorithm>
#include <array>
#include <iostream>
#include "BaseCompute.h"

vector<int> BaseCompute::selection(vector<int> data,string operation,int value){}

vector<int> BaseCompute::selectionArrays(vector<int> lhs, string operation, vector<int> rhs) {}

vector<int> BaseCompute::conjunction(vector<int> lhs, vector<int> rhs) {}

vector<int> BaseCompute::join(vector<int> parent, vector<int> child) {}

void BaseCompute::join2(vector<int> parent, vector<int> child){}

void BaseCompute::setUnion(vector<int> lhs, vector<int> rhs){}

void BaseCompute::setIntersection(vector<int> lhs, vector<int> rhs){}

void BaseCompute::setDifference(vector<int> lhs, vector<int> rhs){}

vector<int> BaseCompute::sort(vector<int> data,int order){} //0 - ascending, 1 - descending

int BaseCompute::sum(vector<int> data){}

float BaseCompute::avg(vector<int> data) {}

int BaseCompute::countIf(vector<int> data) {}

int BaseCompute::count(vector<int> data) {}

vector<int> BaseCompute::product(vector<int> lhs, vector<int> rhs) {}

int BaseCompute::findMax(vector<int> data){}

int BaseCompute::findMin(vector<int> data){}

vector<int> BaseCompute::prefixSum(vector<int> selData) {}

template <typename T0, typename T1, std::size_t N>
bool operator *(const T0& lhs, const std::array<T1, N>& rhs) {
    return std::find(begin(rhs), end(rhs), lhs) != end(rhs);
}

template<class T0, class...T> std::array<T0, 1+sizeof...(T)> in(T0 arg0, T...args) {
    return {{arg0, args...}};
}

vector<vector<int>> BaseCompute::readLineItem() {
    std::string filename = "/home/hkumar/tpch-dbgen/data/lineitem.tbl";

    std::vector<std::vector<int>> lineitemData;

    std::vector<int> rowVector;

    std::ifstream lineitemFile(filename);

/*    if(!lineitemFile.is_open())
        throw std::runtime_error("could not open file");*/

    std::string row;
    std::string values;

    while (lineitemFile.good()) {
        std::getline(lineitemFile, row);
        std::stringstream ss(row);
        if(!row.empty()) {
            int count = 0;
            while (std::getline(ss, values, '|')) {
                if(count < 8 or (count >=10 and count <=12)){
                    if(count > 4 and count <=7) {
//                        int val = std::stof(values) * 100;
                        values.erase(std::remove(values.begin(), values.end(), '.'), values.end());
                        rowVector.push_back(stoi(values));
                    }
                    else if(count >=10 and count <=12){
                        values.erase(remove(values.begin(), values.end(), '-'), values.end());
                        rowVector.push_back(std::stoi(values));
                    }
                    else{
                        rowVector.push_back(std::stoi(values));
                    }
                }
                count++;
            }
            lineitemData.push_back(rowVector);
            rowVector.clear();
        }
    }
    return lineitemData;
}

vector<vector<int>> BaseCompute::readCustomer() {

    std::string filename = "/home/hkumar/tpch-dbgen/data/customer.tbl";

    std::vector<std::vector<int>> customerData;

    std::vector<int> rowVector;

    std::ifstream customerFile(filename);

    std::string row;
    std::string values;

    while (customerFile.good()) {
        std::getline(customerFile, row);
        std::stringstream ss(row);
        if(!row.empty()) {
            int count = 0;
            while (std::getline(ss, values, '|')) {
                if(count *in(0,3,5)){   //count == 0 or count == 3 or count == 5
                    if(count == 5){
                        values.erase(std::remove(values.begin(), values.end(), '.'), values.end());
                    }
                    rowVector.push_back(stoi(values));
                }
                count++;
            }
            customerData.push_back(rowVector);
            rowVector.clear();
        }
    }
    return customerData;
}

vector<vector<int>> BaseCompute::readOrders() {
    std::string filename = "/home/hkumar/tpch-dbgen/data/orders.tbl";

    std::vector<std::vector<int>> ordersData;

    std::vector<int> rowVector;

    std::ifstream ordersFile(filename);

    std::string row;
    std::string values;

    while (ordersFile.good()) {
        std::getline(ordersFile, row);
        std::stringstream ss(row);
        if(!row.empty()) {
            int count = 0;
            while (std::getline(ss, values, '|')) {
                if(count *in(0,1,3,4,7)){   //count == 0 or count == 3 or count == 5
                    if(count == 3){
                        values.erase(std::remove(values.begin(), values.end(), '.'), values.end());
                    }else if(count == 4){
                        values.erase(remove(values.begin(), values.end(), '-'), values.end());
                    }
                    rowVector.push_back(stoi(values));
                }
                count++;
            }
            ordersData.push_back(rowVector);
            rowVector.clear();
        }
    }
    return ordersData;
}

vector<vector<int>> BaseCompute::readNation() {
    std::string filename = "/home/hkumar/tpch-dbgen/data/nation.tbl";

    std::vector<std::vector<int>> nationsData;

    std::vector<int> rowVector;

    std::ifstream nationsFile(filename);

    std::string row;
    std::string values;

    while (nationsFile.good()) {
        std::getline(nationsFile, row);
        std::stringstream ss(row);
        if(!row.empty()) {
            int count = 0;
            while (std::getline(ss, values, '|')) {
                if(count *in(0,2)){   //count == 0 or count == 3 or count == 5
                    rowVector.push_back(stoi(values));
                }
                count++;
            }
            nationsData.push_back(rowVector);
            rowVector.clear();
        }
    }
    return nationsData;
}

vector<vector<int>> BaseCompute::readRegion() {
    std::string filename = "/home/hkumar/tpch-dbgen/data/region.tbl";

    std::vector<std::vector<int>> regionData;

    std::vector<int> rowVector;

    std::ifstream regionFile(filename);

    std::string row;
    std::string values;

    while (regionFile.good()) {
        std::getline(regionFile, row);
        std::stringstream ss(row);
        if(!row.empty()) {
            int count = 0;
            while (std::getline(ss, values, '|')) {
                if(count *in(0)){   //count == 0 or count == 3 or count == 5
                    rowVector.push_back(stoi(values));
                }
                count++;
            }
            regionData.push_back(rowVector);
            rowVector.clear();
        }
    }
    return regionData;
}


vector<vector<int>> BaseCompute::readPart() {
    std::string filename = "/home/hkumar/tpch-dbgen/data/part.tbl";

    std::vector<std::vector<int>> partData;

    std::vector<int> rowVector;

    std::ifstream partFile(filename);

    std::string row;
    std::string values;

    while (partFile.good()) {
        std::getline(partFile, row);
        std::stringstream ss(row);
        if(!row.empty()) {
            int count = 0;
            while (std::getline(ss, values, '|')) {
                if(count *in(0,5,7)){   //count == 0 or count == 3 or count == 5
                    if(count == 7){
                        values.erase(std::remove(values.begin(), values.end(), '.'), values.end());
                    }
                    rowVector.push_back(stoi(values));
                }
                count++;
            }
            partData.push_back(rowVector);
            rowVector.clear();
        }
    }
    return partData;
}

vector<vector<int>> BaseCompute::readSupplier() {
    std::string filename = "/home/hkumar/tpch-dbgen/data/supplier.tbl";

    std::vector<std::vector<int>> supplierData;

    std::vector<int> rowVector;

    std::ifstream supplierFile(filename);

    std::string row;
    std::string values;

    while (supplierFile.good()) {
        std::getline(supplierFile, row);
        std::stringstream ss(row);
        if(!row.empty()) {
            int count = 0;
            while (std::getline(ss, values, '|')) {
                if(count *in(0,3,5)){   //count == 0 or count == 3 or count == 5
                    if(count == 5){
                        values.erase(std::remove(values.begin(), values.end(), '.'), values.end());
                    }
                    rowVector.push_back(stoi(values));
                }
                count++;
            }
            supplierData.push_back(rowVector);
            rowVector.clear();
        }
    }
    return supplierData;
}

vector<vector<int>> BaseCompute::readPartSupp() {
    std::string filename = "/home/hkumar/tpch-dbgen/data/partsupp.tbl";

    std::vector<std::vector<int>> partsuppData;

    std::vector<int> rowVector;

    std::ifstream partsuppFile(filename);

    std::string row;
    std::string values;

    while (partsuppFile.good()) {
        std::getline(partsuppFile, row);
        std::stringstream ss(row);
        if(!row.empty()) {
            int count = 0;
            while (std::getline(ss, values, '|')) {
                if(count <= 3){   //count == 0 or count == 3 or count == 5
                    if(count == 3){
                        values.erase(std::remove(values.begin(), values.end(), '.'), values.end());
                    }
                    rowVector.push_back(stoi(values));
                }
                count++;
            }
            partsuppData.push_back(rowVector);
            rowVector.clear();
        }
    }
    return partsuppData;
}

vector<vector<int>> BaseCompute::getTransposedVector(vector<vector<int>> &tableData) {
    vector<vector<int>> transposedVec(tableData[0].size(),
                                      vector<int>(tableData.size()));
    for (size_t i = 0; i < tableData.size(); ++i)
        for (size_t j = 0; j < tableData[0].size(); ++j)
            transposedVec[j][i] = tableData[i][j];
    return transposedVec;
}

auto removeByIndex =
        []<class T>(std::vector<T> &vec, int index)
        {
            vec.erase(vec.begin() + index);
        };



vector<int> BaseCompute::getPKColumn(int PK_size,  vector<int> selResult) {
    vector<int> PKColIndex;
    int pk_col = 0;

    for (int i = 0; i < selResult.size(); i++) {
        if (selResult[i] != 0) {
            if (i > 0) {
                pk_col = i % PK_size;
            }
            PKColIndex.push_back(pk_col);
        }
    }
    return PKColIndex;
}

vector<int> BaseCompute::getFKColumn(int FK_size, vector<int> selResult) {
    vector<int> FKColIndex;
    int fk_col = 0;

    for (int i = 0; i < selResult.size(); i++) {
        if (selResult[i] != 0) {
            if (i > 0) {
                fk_col = i / FK_size;
            }
            FKColIndex.push_back(fk_col);
        }
    }
    return FKColIndex;
}

//vector<vector<int>> BaseCompute::joinTuples(vector<vector<int>> PK_data, vector<vector<int>> FK_data, int PK_size,
//                                            vector<int> joinIndex) {
//    int pk_col = 0;
//    int fk_col = 0;
//
//    vector<vector<int>> result;
//    vector<int> temp;
//
//    for (int i = 0; i < joinIndex.size(); i++) {
//        if (joinIndex[i] != 0) {
//            pk_col = i % PK_size;
//            fk_col = i / PK_size;
//            temp.clear();
////            temp.insert(temp.end(),PK_data[pk_col].begin(),PK_data[pk_col].end());
////            temp.insert(temp.end(),FK_data[fk_col].begin(),FK_data[fk_col].end());
//            temp.insert(temp.end(),pk_col);
//            temp.insert(temp.end(),fk_col);
//            result.push_back(temp);
//        }
//    }
//
//    return result;
//}

vector<vector<int>> BaseCompute::joinTuples(vector<int> PK_data, vector<int> FK_data, int PK_size, vector<int> joinIndex, int i,
                                    int j, int offset) {
    int pk_col = 0;
    int fk_col = 0;

    vector<int> temp;
    vector<vector<int>> result;

    for (int index = 0; index < joinIndex.size(); index++) {
        if (joinIndex[index] != 0) {
            pk_col = index % PK_size;
            fk_col = index / PK_size;

            pk_col = i*offset + pk_col;
            fk_col = j*offset + fk_col;

            temp.clear();
            temp.insert(temp.end(),pk_col,PK_data[pk_col]);
            temp.insert(temp.end(),fk_col);
            result.push_back(temp);
        }
    }
    return result;
}



vector<vector<int>> BaseCompute::deleteTuples(vector<vector<int>> tableData, vector<int> vecIndex) {
    vector<vector<int>> filteredTable;

    for(int i=0; i < vecIndex.size(); i++){
        filteredTable.push_back(tableData[vecIndex[i]]);
    }
    return filteredTable;
}
