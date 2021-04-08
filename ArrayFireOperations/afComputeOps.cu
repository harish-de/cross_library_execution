//
// Created by hkumar on 31.08.20.
//

#pragma once

#include <numeric>
#include "afComputeOps.cuh"

// begin of changes for unified interface

af::array afCompute::getAfFromCuda(int *device_data){
    cout << sizeof(device_data);
}

// end of changes for unified interface

af::array afCompute::getAFGpuData(std::vector<int> data) {

//    af::array deviceDummy;
//
//    auto start = high_resolution_clock::now();  // start time
//    for (int i = 0; i <= iteration; i++) {
    int* hostData = &data[0];
    af::array deviceData((dim_t)data.size(), hostData, afHost);
//    }
//    auto stop = high_resolution_clock::now(); // stop time
//    auto duration = duration_cast<nanoseconds>(stop - start); // time taken for performing the operation
//
//    std::cout << duration.count()/iteration << std::endl;

//    return deviceDummy;
    return deviceData;
}

af::array afCompute::afcpu2gpu(std::vector<int> data) {

    auto start = high_resolution_clock::now();  // start time
    for (int i = 0; i <= iteration; i++) {
        int* hostData = &data[0];
        af::array deviceData((dim_t)data.size(), hostData, afHost);
    }
    auto stop = high_resolution_clock::now(); // stop time
    auto duration = duration_cast<nanoseconds>(stop - start); // time taken for performing the operation

    std::cout << duration.count()/iteration << "\t";

    int* hostData = &data[0];
    af::array deviceData((dim_t)data.size(), hostData, afHost);
    return deviceData;
}

af::array afCompute::getAFGpuData(std::vector<float> data) {
    float * hostData = &data[0];
    af::array deviceData((dim_t)data.size(), hostData, afHost);
    return deviceData;
}

vector<int> afCompute::getAFCpuData(af::array deviceData) {
//    vector<int> hostDummy(deviceData.elements());
//    auto start = high_resolution_clock::now();  // start time
//    for (int i = 0; i <= iteration; i++) {
    vector<int> hostData(deviceData.elements());
    deviceData.host(hostData.data());
//    }
//    auto stop = high_resolution_clock::now(); // stop time
//    auto duration = duration_cast<nanoseconds>(stop - start); // time taken for performing the operation
//
//    std::cout << duration.count()/iteration << std::endl;
//    return hostDummy;
    return hostData;
}

vector<int> afCompute::afgpu2cpu(af::array deviceData) {
//    vector<int> hostDummy(deviceData.elements());
    auto start = high_resolution_clock::now();  // start time
    for (int i = 0; i <= iteration; i++) {
        vector<int> hostData(deviceData.elements());
        deviceData.host(hostData.data());
    }
    auto stop = high_resolution_clock::now(); // stop time
    auto duration = duration_cast<nanoseconds>(stop - start); // time taken for performing the operation

    std::cout << duration.count()/iteration << std::endl;
    vector<int> hostData(deviceData.elements());
    deviceData.host(hostData.data());
    return hostData;
}

vector<float> afCompute::getAFFloatCpuData(af::array deviceData) {
    vector<float> hostData(deviceData.elements());
    deviceData.host(hostData.data());
    return hostData;
}

af::array afCompute::afSelection(af::array deviceData, string operation, int value) {

    af::array device_result;

    if(!operation.compare("GE")) {
        auto start = high_resolution_clock::now();
        for (int i = 0; i <= iteration; i++) {
            device_result = af::where(af::operator>=(deviceData, value));
        }
        auto stop = high_resolution_clock::now(); // stop time
        auto duration = duration_cast<nanoseconds>(stop - start);

        std::cout << "selection: " << duration.count()/iteration << endl;
    }
    else if(!operation.compare("LE")) {
        auto start = high_resolution_clock::now();
        for (int i = 0; i <= iteration; i++) {
            device_result = af::where(af::operator<=(deviceData, value));
        }
        auto stop = high_resolution_clock::now(); // stop time
        auto duration = duration_cast<nanoseconds>(stop - start);

        std::cout << "selection: " << duration.count()/iteration << endl;
    }
    else if(!operation.compare("G")) {
        auto start = high_resolution_clock::now();
        for (int i = 0; i <= iteration; i++) {
            device_result = af::where(af::operator>(deviceData, value));
        }
        auto stop = high_resolution_clock::now(); // stop time
        auto duration = duration_cast<nanoseconds>(stop - start);

        std::cout << "selection: " << duration.count()/iteration << endl;
    }
    else if(!operation.compare("L")) {
        auto start = high_resolution_clock::now();
        for (int i = 0; i <= iteration; i++) {
            device_result = af::where(af::operator<(deviceData, value));
        }
        auto stop = high_resolution_clock::now(); // stop time
        auto duration = duration_cast<nanoseconds>(stop - start);

        std::cout << "selection: " << duration.count()/iteration << endl;
    }
    else if(!operation.compare("EQ")) {
        auto start = high_resolution_clock::now();
        for (int i = 0; i <= iteration; i++) {
            device_result = af::where(af::operator==(deviceData, value));
        }
        auto stop = high_resolution_clock::now(); // stop time
        auto duration = duration_cast<nanoseconds>(stop - start);

        std::cout << "selection: " << duration.count()/iteration << endl;
    }
    else{
        auto start = high_resolution_clock::now();
        for (int i = 0; i <= iteration; i++) {
            device_result = af::where(af::operator!=(deviceData, value));
        }
        auto stop = high_resolution_clock::now(); // stop time
        auto duration = duration_cast<nanoseconds>(stop - start);

        std::cout << "selection: " << duration.count()/iteration << endl;
    }

    return device_result;
}


af::array afCompute::afFilter(af::array deviceData, string operation, int value) {

    af::array device_result;

    auto start = high_resolution_clock::now();
    for (int i = 0; i <= iteration; i++) {
        device_result = af::where(af::operator<=(deviceData, value));
    }
    auto stop = high_resolution_clock::now(); // stop time
    auto duration = duration_cast<nanoseconds>(stop - start);
    cout << duration.count()/iteration << endl;

    return device_result;
}

af::array afCompute::afSelectionArrays(af::array lhs, string operation, af::array rhs) {

    af::array device_result;

    if(!operation.compare("GE")) {
        auto start = high_resolution_clock::now();
        for (int i = 0; i <= iteration; i++) {
            device_result = af::where(af::operator>=(lhs, rhs));
        }
        auto stop = high_resolution_clock::now(); // stop time
        auto duration = duration_cast<nanoseconds>(stop - start);
        std::cout << "selectionArrays: " << duration.count()/iteration << endl;
    }
    else if(!operation.compare("LE")) {
        auto start = high_resolution_clock::now();
        for (int i = 0; i <= iteration; i++) {
            device_result = af::where(af::operator<=(lhs, rhs));
        }
        auto stop = high_resolution_clock::now(); // stop time
        auto duration = duration_cast<nanoseconds>(stop - start);
        std::cout << "selectionArrays: " << duration.count()/iteration << endl;
    }
    else if(!operation.compare("G")) {
        auto start = high_resolution_clock::now();
        for (int i = 0; i <= iteration; i++) {
            device_result = af::where(af::operator>(lhs, rhs));
        }
        auto stop = high_resolution_clock::now(); // stop time
        auto duration = duration_cast<nanoseconds>(stop - start);
        std::cout << "selectionArrays: " << duration.count()/iteration << endl;
    }
    else if(!operation.compare("L")) {
        auto start = high_resolution_clock::now();
        for (int i = 0; i <= iteration; i++) {
            device_result = af::where(af::operator<(lhs, rhs));
        }
        auto stop = high_resolution_clock::now(); // stop time
        auto duration = duration_cast<nanoseconds>(stop - start);
        std::cout << "selectionArrays: " << duration.count()/iteration << endl;
    }
    else if(!operation.compare("EQ")) {
        auto start = high_resolution_clock::now();
        for (int i = 0; i <= iteration; i++) {
            device_result = af::where(af::operator==(lhs, rhs));
        }
        auto stop = high_resolution_clock::now(); // stop time
        auto duration = duration_cast<nanoseconds>(stop - start);
        std::cout << "selectionArrays: " << duration.count()/iteration << endl;
    }
    else{
        auto start = high_resolution_clock::now();
        for (int i = 0; i <= iteration; i++) {
            device_result = af::where(af::operator!=(lhs, rhs));
        }
        auto stop = high_resolution_clock::now(); // stop time
        auto duration = duration_cast<nanoseconds>(stop - start);
        std::cout << "selectionArrays: " << duration.count()/iteration << endl;
    }

    return device_result;
}

af::array afCompute::afConjunction(af::array deviceLHS, af::array deviceRHS) {
    auto start = high_resolution_clock::now();
    for (int i = 0; i <= iteration; i++) {
        af::array result = af::setIntersect(deviceLHS, deviceRHS, true);
    }
    auto stop = high_resolution_clock::now(); // stop time
    auto duration = duration_cast<nanoseconds>(stop - start);
    std::cout << "conjunction: " << duration.count()/iteration << endl;

    af::array result = af::setIntersect(deviceLHS, deviceRHS, true);
    return result;
}

af::array afCompute::afProduct(af::array deviceLHS, af::array deviceRHS) {
    auto start = high_resolution_clock::now();
    for (int i = 0; i <= iteration; i++) {
        af::array result = af::operator*(deviceLHS,deviceRHS);
    }
    auto stop = high_resolution_clock::now(); // stop time
    auto duration = duration_cast<nanoseconds>(stop - start);
    std::cout << "product: " << duration.count()/iteration << endl;

    af::array result = af::operator*(deviceLHS,deviceRHS);
    return result;
}

int afCompute::afSum(af::array deviceData) {
    auto start = high_resolution_clock::now();
    for (int i = 0; i <= iteration; i++) {
        int result = af::sum<int>(deviceData,(dim_t)0);
    }
    auto stop = high_resolution_clock::now(); // stop time
    auto duration = duration_cast<nanoseconds>(stop - start);
    std::cout << "sum: " << duration.count()/iteration << endl;

    int result = af::sum<int>(deviceData,(dim_t)0);
    return result;
}

float afCompute::afAvg(af::array deviceData) {
    float sum = af::sum<float>(deviceData,(dim_t)0);
    float result = sum/deviceData.elements();
    return result;
}

int afCompute::afCountIf(af::array deviceData,int value) {
//        return af::count<int>(deviceData);
    af::array index = af::where(af::operator==(deviceData,value));
    return af::count<int>(index);
}

int afCompute::afCount(af::array deviceData) {
    return deviceData.elements();
}


af::array test_nested_loop(af::array::array_proxy result,af::array::array_proxy child,af::array parent) { //

    for(int j=0 ; j < parent.elements(); j++){
        result = af::select(child==parent(j),j,result);
    }
    return result;
}


//af::array nested_loop_join(af::array::array_proxy child,
//                           af::array parent,
//                           af::array::array_proxy result) {
//
//    for (int j = 0; j < parent.elements(); j++){
//        result = af::select(child==parent(j),j,result);
//    }
//    return result;
//}

af::array afCompute::afJoin(af::array parent, af::array child) {

// Why arrayfire join is slow:
// https://stackoverflow.com/questions/50242141/arrayfire-cuda-application-is-extremely-slow-in-the-first-minute
// https://github.com/arrayfire/arrayfire-python/issues/140

/*
 *          condition = (child(i) == parent(j));
            A(i) = (condition)*j + (!condition)*A(i);
 */
    af::array A = af::constant(-1,child.elements());

    gfor(af::seq i, child.elements()) { //
        test_nested_loop(A(i),child(i),parent);
    }
//
    A = A.as(af::dtype::s32);

    return A;
}

// Please note arrayfire does not need prefix sum operation as it already returns the indices in selection operation
// the function has been added below for consistency to run all libraries in sequence
af::array afCompute::afPrefixSum(af::array deviceSelData) {
    return deviceSelData;
}

int afCompute::afFindMax(af::array deviceData) {
    return af::max<int>(deviceData);
}

int afCompute::afFindMin(af::array deviceData) {
    return af::min<int>(deviceData);
}

af::array afCompute::afSort(af::array deviceData, int order) {

    af::array sorted_data;
    auto start = high_resolution_clock::now();
    for (int i = 0; i <= iteration; i++) {
        if(order){
            sorted_data = af::sort(deviceData,0, false);
        }else{
            sorted_data = af::sort(deviceData);
        }
    }
    auto stop = high_resolution_clock::now(); // stop time
    auto duration = duration_cast<nanoseconds>(stop - start);
    std::cout << "sort: " << duration.count()/iteration << endl;
    return sorted_data;
}

af::array afCompute::afGroupBy(af::array keys, af::array values) {
    af::array keys_out;
    af::array values_out;
    auto start = high_resolution_clock::now();
    for (int i = 0; i <= iteration; i++) {
        af::sumByKey(keys_out, values_out, keys, values);
    }
    auto stop = high_resolution_clock::now(); // stop time
    auto duration = duration_cast<nanoseconds>(stop - start);
    cout << "sumByKey: " << duration.count()/iteration << endl;
//    af::sumByKey(keys_out, values_out, keys, values);
    return values_out;
}

af::array afCompute::afCountByKey(af::array data){
    af::array values_out;

//    auto start1 = high_resolution_clock::now();
//    for (int i = 0; i <= iteration; i++) {
//        data = afSort(data,0);
//    }
//    auto stop1 = high_resolution_clock::now(); // stop time
//    auto duration1 = duration_cast<nanoseconds>(stop1 - start1);

    auto start = high_resolution_clock::now();
    for (int i = 0; i <= iteration; i++) {
        // start time
        af::array keys_out;
        af::array temp = data;

        af::sumByKey(keys_out,values_out,data,temp);
        values_out = af::operator/(values_out,keys_out);
    }
    auto stop = high_resolution_clock::now(); // stop time
    auto duration = duration_cast<nanoseconds>(stop - start);

    cout << "countByKey: " << duration.count()/iteration << endl;

    return values_out;
}

af::array afCompute::afSumOfVectors(af::array vec1, af::array vec2) {
    af::array result(vec1.elements());

    auto start = high_resolution_clock::now();
    for (int i = 0; i <= iteration; i++) {
        gfor(af::seq i, vec1.elements()){
            result(i) = vec1(i) + vec2(i);
        }

        result = result.as(af::dtype::s32);
    }

    auto stop = high_resolution_clock::now(); // stop time
    auto duration = duration_cast<nanoseconds>(stop - start);

    std::cout << "grouping: " << duration.count()/iteration << endl;

    return result;
}

af::array afCompute::afSortByKey(af::array data, af::array dependent_data, int order) {

    af::array sorted_index;
    af::array sorted_value;

    auto start = high_resolution_clock::now();
    for (int i = 0; i <= iteration; i++) {
        if (order) {
            af::sort(sorted_index, sorted_value, data, dependent_data,0,false);
        }else{
            af::sort(sorted_index, sorted_value, data, dependent_data);
        }
    }

    auto stop = high_resolution_clock::now(); // stop time
    auto duration = duration_cast<nanoseconds>(stop - start);

    std::cout << "sortbykey: " << duration.count()/iteration << endl;
    return sorted_value;
}

af::array afCompute::afAvgByKey(af::array keys, af::array values) {
    auto start = high_resolution_clock::now();
    for (int i = 0; i <= iteration; i++) {
        af::array sums = afGroupBy(keys,values);

        af::array counts = afCountByKey(keys);

        af::array average = af::operator/(sums,counts);
    }

    auto stop = high_resolution_clock::now(); // stop time
    auto duration = duration_cast<nanoseconds>(stop - start);

    std::cout << "avgByKey: " << duration.count()/iteration << endl;

    af::array sums = afGroupBy(keys,values);

    af::array counts = afCountByKey(keys);

    af::array average = af::operator/(sums,counts);
    return average;
}