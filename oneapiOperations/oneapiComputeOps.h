//
// Created by hkumar on 03.09.20.
//

#ifndef CROSS_LIBRARY_EXECUTION_ONEAPICOMPUTEOPS_H
#define CROSS_LIBRARY_EXECUTION_ONEAPICOMPUTEOPS_H

#pragma once
#include <CL/sycl.hpp>
#include <SYCL/vec.h>
#include <vector>
#include <iostream>

using namespace std;
namespace sycl = cl::sycl;

class oneapiCompute{
    sycl::buffer<int,1> virtual getOneapiGPUData(vector<int> data,sycl::device device,sycl::range<1> numOfItems);
//    vector<int> virtual getGOneapiCPUData(sycl::buffer<int,1> data);
};

#endif //CROSS_LIBRARY_EXECUTION_ONEAPICOMPUTEOPS_H
