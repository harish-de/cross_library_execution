//
// Created by hkumar on 31.08.20.
//

#pragma once
#include "afComputeOps.cuh"

af::array afCompute::getAFGpuData(std::vector<int> data) {
    int* hostData = &data[0];
    af::array deviceData((dim_t)data.size(), hostData, afHost);
    return deviceData;
}

vector<int> afCompute::getAFCpuData(af::array deviceData) {
    vector<int> hostData(deviceData.elements());
    deviceData.host(hostData.data());
    return hostData;
}

af::array afCompute::afSelection(af::array deviceData, string operation, int value) {

    af::array device_result;

    if(!operation.compare("GE")) {
        device_result = af::where(af::operator>=(deviceData, value));
    }
    else if(!operation.compare("LE")) {

        device_result = af::where(af::operator<=(deviceData, value));
    }
    else if(!operation.compare("G")) {
        device_result = af::where(af::operator>(deviceData, value));
    }
    else if(!operation.compare("L")) {
        device_result = af::where(af::operator<(deviceData, value));
    }
    else if(!operation.compare("EQ")) {
        device_result = af::where(af::operator==(deviceData, value));
    }
    else{
        device_result = af::where(af::operator!=(deviceData, value));
    }

    return device_result;
}

af::array afCompute::afConjunction(af::array deviceLHS, af::array deviceRHS) {
    af::array result = af::setIntersect(deviceLHS,deviceRHS,true);
    return result;
}

af::array afCompute::afProduct(af::array deviceLHS, af::array deviceRHS) {
    af::array result = af::operator*(deviceLHS,deviceRHS);
    return result;
}

int afCompute::afSum(af::array deviceData) {
//    af::array device_result = af::sum<int>(data,(dim_t)0);
//    int result = device_result.row(0).elements();
    int result = af::sum<int>(deviceData,(dim_t)0);
    return result;
}

float afCompute::afAvg(af::array deviceData) {
    float result = af::mean<float>(deviceData);
    return result;
}

int afCompute::afCountIf(af::array deviceData) {
    return af::count<int>(deviceData);
}

int afCompute::afCount(af::array deviceData) {
    return deviceData.elements();
}

af::array afCompute::afJoin(af::array parent, af::array child) {

    af::array A = af::constant(0, parent.elements(), child.elements());
    gfor(af::seq i,parent.elements()){
        for(int j=0;j<child.elements();j++){
            af::array condition = (child(j) == parent(i));
            A(i,j) =  (!condition).as(f32) * 0 + (condition).as(f32) * 1;
        }
    }
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