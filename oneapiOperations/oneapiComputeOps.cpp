//
// Created by hkumar on 03.09.20.
//

#pragma once


#include "oneapiComputeOps.h"

sycl::buffer<int,1> oneapiCompute::getOneapiGPUData(vector<int> data, sycl::device device, sycl::range<1> numOfItems) {
    cl::sycl::buffer<int, 1> bufferA(data.data(), numOfItems);
//    bufferA.get_access<sycl::host>()
    return bufferA;
}

//vector<int> oneapiCompute::getGOneapiCPUData(sycl::buffer<int, 1> device_data) {
//    auto hBuf = device_data.get_access<sycl::access::mode::write>();
////    vector<int> data;
//    cout << hBuf.get_size() << endl;
//}