//
// Created by hkumar on 31.08.20.
//

#pragma once
#include "BoostAdapter.h"
namespace compute = boost::compute;

BoostAdapter::BoostAdapter(BoostCompute *ABC_obj) {
    ABC = ABC_obj;
}

vector<int> BoostAdapter::selection(std::vector<int> data, string operation, int value) {
    compute::device device = compute::system::default_device();
    compute::context context(device);
    compute::command_queue queue(context, device);

    compute::vector<int> deviceData(data.size(),context);
    deviceData = ABC->getBoostGpuData(data,context,queue);

    compute::vector<int> deviceResult(data.size(),context);

    vector<int> result;
//    vector<int> durations;

//    for (int i = 0; i <= execution_factor; i++) {
//        auto start = high_resolution_clock::now();  // start time

    // operation here
    deviceResult = ABC->boostSelection(deviceData,operation,value,queue,context,device);

//        auto stop = high_resolution_clock::now(); // stop time
//        auto duration = duration_cast<nanoseconds>(stop - start); // time taken for performing the operation
//        if(i>0) {
//            durations.push_back(duration.count());  // since the initial load time is high, calculation is started from 2nd iteration
//        }else{
    result = ABC->getBoostCpuData(deviceResult,queue);
//        }
//    }
//    std::cout << "Time taken for selection operation " << operation << "_" <<to_string(value)
//              << " is " <<std::accumulate(durations.begin(),
//                                          durations.end(), 0) / durations.size() << " nanoseconds" << std::endl;

    return result;
}

vector<int> BoostAdapter::filter(std::vector<int> data, string operation, int value) {
    compute::device device = compute::system::default_device();
    compute::context context(device);
    compute::command_queue queue(context, device);

    compute::vector<int> deviceData(data.size(),context);
    deviceData = ABC->getBoostGpuData(data,context,queue);

    compute::vector<int> deviceResult(data.size(),context);

    vector<int> result;
    vector<int> durations;

    // operation here
    deviceResult = ABC->boostFilter(deviceData,operation,value,queue,context,device);
    result = ABC->getBoostCpuData(deviceResult,queue);

    return result;
}

vector<int> BoostAdapter::selectionArrays(vector<int> lhs, string operation, vector<int> rhs) {
    compute::device device = compute::system::default_device();
    compute::context context(device);
    compute::command_queue queue(context, device);

    compute::vector<int> deviceLHS(lhs.size(),context);
    deviceLHS = ABC->getBoostGpuData(lhs,context,queue);

    compute::vector<int> deviceRHS(rhs.size(),context);
    deviceRHS = ABC->getBoostGpuData(rhs,context,queue);

    compute::vector<int> deviceResult(lhs.size(),context);

    vector<int> result;
//    vector<int> durations;
//
//    for (int i = 0; i <= execution_factor; i++) {
//        auto start = high_resolution_clock::now();  // start time

    // operation here
    deviceResult = ABC->boostSelectionArrays(deviceLHS,operation,deviceRHS,queue,context);

//        auto stop = high_resolution_clock::now(); // stop time
//        auto duration = duration_cast<nanoseconds>(stop - start); // time taken for performing the operation
//        if(i>0) {
//            durations.push_back(duration.count());  // since the initial load time is high, calculation is started from 2nd iteration
//        }else{
    result = ABC->getBoostCpuData(deviceResult,queue);
//        }
//    }
//
//
//    std::cout << "Time taken for selection operation is " <<std::accumulate(durations.begin(),
//                                                                            durations.end(), 0) / durations.size() << " nanoseconds" << std::endl;

    return result;
}


vector<int> BoostAdapter::conjunction(vector<int> lhs, vector<int> rhs) {

    compute::device device = compute::system::default_device();
    compute::context context(device);
    compute::command_queue queue(context, device);

    compute::vector<int> deviceLHS(lhs.size(),context);
    deviceLHS = ABC->getBoostGpuData(lhs,context,queue);

    compute::vector<int> deviceRHS(rhs.size(),context);
    deviceRHS = ABC->getBoostGpuData(rhs,context,queue);

    compute::vector<int> deviceResult(lhs.size(),context);

    vector<int> result;
//    vector<int> durations;

//    for (int i = 0; i <= execution_factor; i++) {
//        auto start = high_resolution_clock::now();  // start time

    // operation here
    deviceResult = ABC->boostConjunction(deviceLHS,deviceRHS,queue,context);

//        auto stop = high_resolution_clock::now(); // stop time
//        auto duration = duration_cast<nanoseconds>(stop - start); // time taken for performing the operation
//        if(i>0) {
//            durations.push_back(duration.count());  // since the initial load time is high, calculation is started from 2nd iteration
//        }else{
    result = ABC->getBoostCpuData(deviceResult,queue);
//        }
//    }
//
//    std::cout << "Time taken for conjunction operation is " <<std::accumulate(durations.begin(),
//                                                                              durations.end(), 0) / durations.size() << " nanoseconds" << std::endl;
    return result;
}

vector<int> BoostAdapter::product(vector<int> lhs, vector<int> rhs) {

    compute::device device = compute::system::default_device();
    compute::context context(device);
    compute::command_queue queue(context, device);

    compute::vector<int> deviceLHS(lhs.size(),context);
    deviceLHS = ABC->getBoostGpuData(lhs,context,queue);

    compute::vector<int> deviceRHS(rhs.size(),context);
    deviceRHS = ABC->getBoostGpuData(rhs,context,queue);

    compute::vector<int> deviceResult(lhs.size(),context);

    vector<int> result;
//    vector<int> durations;

//    for (int i = 0; i <= execution_factor; i++) {
//        auto start = high_resolution_clock::now();  // start time

    // operation here
    deviceResult = ABC->boostProduct(deviceLHS,deviceRHS,queue,context);

//        auto stop = high_resolution_clock::now(); // stop time
//        auto duration = duration_cast<nanoseconds>(stop - start); // time taken for performing the operation
//        if(i>0) {
//            durations.push_back(duration.count());  // since the initial load time is high, calculation is started from 2nd iteration
//        }else{
    result = ABC->getBoostCpuData(deviceResult,queue);
//        }
//    }
//
//    std::cout << "Time taken for product operation is " <<std::accumulate(durations.begin(),
//                                                                          durations.end(), 0) / durations.size() << " nanoseconds" << std::endl;
    return result;
}

int BoostAdapter::sum(vector<int> data) {

    compute::device device = compute::system::default_device();
    compute::context context(device);
    compute::command_queue queue(context, device);

    compute::vector<int> deviceData(data.size(),context);
    deviceData = ABC->getBoostGpuData(data,context,queue);

    int result;

//    vector<int> durations;

//    for (int i = 0; i <= execution_factor; i++) {
//        auto start = high_resolution_clock::now();  // start time

    // operation here
    result = ABC->boostSum(deviceData,queue,context);

//        auto stop = high_resolution_clock::now(); // stop time
//        auto duration = duration_cast<nanoseconds>(stop - start); // time taken for performing the operation
//        if(i>0) {
//            durations.push_back(duration.count());  // since the initial load time is high, calculation is started from 2nd iteration
//        }
//    }

//    std::cout << "Time taken for sum operation is " <<std::accumulate(durations.begin(),
//                                                                      durations.end(), 0) / durations.size() << " nanoseconds" << std::endl;

    return result;
}

float BoostAdapter::avg(vector<int> data) {

    compute::device device = compute::system::default_device();
    compute::context context(device);
    compute::command_queue queue(context, device);

    compute::vector<int> deviceData(data.size(),context);
    deviceData = ABC->getBoostGpuData(data,context,queue);

    float result;

    vector<int> durations;

    for (int i = 0; i <= execution_factor; i++) {
        auto start = high_resolution_clock::now();  // start time

        // operation here
        result = ABC->boostAvg(deviceData,queue,context);

        auto stop = high_resolution_clock::now(); // stop time
        auto duration = duration_cast<nanoseconds>(stop - start); // time taken for performing the operation
        if(i>0) {
            durations.push_back(duration.count());  // since the initial load time is high, calculation is started from 2nd iteration
        }
    }

    std::cout << "Time taken for average operation is " <<std::accumulate(durations.begin(),
                                                                          durations.end(), 0) / durations.size() << " nanoseconds" << std::endl;

    return result;
}

int BoostAdapter::countIf(vector<int> data,int value) {

    compute::device device = compute::system::default_device();
    compute::context context(device);
    compute::command_queue queue(context, device);

    compute::vector<int> deviceData(data.size(),context);
    deviceData = ABC->getBoostGpuData(data,context,queue);

    int result;

    vector<int> durations;

    for (int i = 0; i <= execution_factor; i++) {
        auto start = high_resolution_clock::now();  // start time

        // operation here
        result = ABC->boostCountIf(deviceData,queue,context,value);

        auto stop = high_resolution_clock::now(); // stop time
        auto duration = duration_cast<nanoseconds>(stop - start); // time taken for performing the operation
        if(i>0) {
            durations.push_back(duration.count());  // since the initial load time is high, calculation is started from 2nd iteration
        }
    }

    std::cout << "Time taken for count operation is " <<std::accumulate(durations.begin(),
                                                                        durations.end(), 0) / durations.size() << " nanoseconds" << std::endl;

    return result;
}

int BoostAdapter::count(vector<int> data) {

    compute::device device = compute::system::default_device();
    compute::context context(device);
    compute::command_queue queue(context, device);

    compute::vector<int> deviceData(data.size(),context);
    deviceData = ABC->getBoostGpuData(data,context,queue);

    int result;

    vector<int> durations;

    for (int i = 0; i <= execution_factor; i++) {
        auto start = high_resolution_clock::now();  // start time

        // operation here
        result = ABC->boostCount(deviceData);

        auto stop = high_resolution_clock::now(); // stop time
        auto duration = duration_cast<nanoseconds>(stop - start); // time taken for performing the operation
        if(i>0) {
            durations.push_back(duration.count());  // since the initial load time is high, calculation is started from 2nd iteration
        }
    }

    std::cout << "Time taken for count operation is " <<std::accumulate(durations.begin(),
                                                                        durations.end(), 0) / durations.size() << " nanoseconds" << std::endl;

    return result;
}


vector<int> BoostAdapter::prefixSum(vector<int> data) {
    compute::device device = compute::system::default_device();
    compute::context context(device);
    compute::command_queue queue(context, device);

    compute::vector<int> deviceData = ABC->getBoostGpuData(data,context,queue);
    int count = ABC->boostCountIf(deviceData,queue,context,1);
    compute::vector<int> deviceResult(count,context);

//    vector<int> durations;
    vector<int> result;

//    for (int i = 0; i <= execution_factor; i++) {
//        auto start = high_resolution_clock::now();  // start time

    // operation here
    deviceResult = ABC->boostPrefixSum(deviceData,queue,context);

//        auto stop = high_resolution_clock::now(); // stop time
//        auto duration = duration_cast<nanoseconds>(stop - start); // time taken for performing the operation
//        if(i>0) {
//            durations.push_back(duration.count());  // since the initial load time is high, calculation is started from 2nd iteration
//        }else{
    result = ABC->getBoostCpuData(deviceResult,queue);
//        }
//    }
//
//    std::cout << "Time taken for prefix sum operation is " <<std::accumulate(durations.begin(),
//                                                                             durations.end(),
//                                                                             0) / durations.size() << " nanoseconds" << std::endl;

    return result;
}

int BoostAdapter::findMax(vector<int> data) {

    compute::device device = compute::system::default_device();
    compute::context context(device);
    compute::command_queue queue(context, device);

    compute::vector<int> deviceData(data.size(),context);
    deviceData = ABC->getBoostGpuData(data,context,queue);

    int result;

    vector<int> durations;

    for (int i = 0; i <= execution_factor; i++) {
        auto start = high_resolution_clock::now();  // start time

        // operation here
        result = ABC->boostFindMax(deviceData,queue,context);

        auto stop = high_resolution_clock::now(); // stop time
        auto duration = duration_cast<nanoseconds>(stop - start); // time taken for performing the operation
        if(i>0) {
            durations.push_back(duration.count());  // since the initial load time is high, calculation is started from 2nd iteration
        }
    }

    std::cout << "Time taken for findMax operation is " <<std::accumulate(durations.begin(),
                                                                          durations.end(), 0) / durations.size() << " nanoseconds" << std::endl;

    return result;
}

int BoostAdapter::findMin(vector<int> data) {

    compute::device device = compute::system::default_device();
    compute::context context(device);
    compute::command_queue queue(context, device);

    compute::vector<int> deviceData(data.size(),context);
    deviceData = ABC->getBoostGpuData(data,context,queue);

    int result;

    vector<int> durations;

    for (int i = 0; i <= execution_factor; i++) {
        auto start = high_resolution_clock::now();  // start time

        // operation here
        result = ABC->boostFindMin(deviceData,queue,context);

        auto stop = high_resolution_clock::now(); // stop time
        auto duration = duration_cast<nanoseconds>(stop - start); // time taken for performing the operation
        if(i>0) {
            durations.push_back(duration.count());  // since the initial load time is high, calculation is started from 2nd iteration
        }
    }

    std::cout << "Time taken for findMin operation is " <<std::accumulate(durations.begin(),
                                                                          durations.end(), 0) / durations.size() << " nanoseconds" << std::endl;

    return result;
}

vector<int> BoostAdapter::sort(vector<int> data, int order) {
    compute::device device = compute::system::default_device();
    compute::context context(device);
    compute::command_queue queue(context, device);

    compute::vector<int> deviceData = ABC->getBoostGpuData(data,context,queue);
//    int count = ABC->boostCountIf(deviceData,queue,context,1);
    compute::vector<int> deviceResult(data.size(),context);

//    vector<int> durations;
    vector<int> result;

//    for (int i = 0; i <= execution_factor; i++) {
//        auto start = high_resolution_clock::now();  // start time

    // operation here
    deviceResult = ABC->boostSort(deviceData,order,queue,context);

//        auto stop = high_resolution_clock::now(); // stop time
//        auto duration = duration_cast<nanoseconds>(stop - start); // time taken for performing the operation
//        if(i>0) {
//            durations.push_back(duration.count());  // since the initial load time is high, calculation is started from 2nd iteration
//        }else{
    result = ABC->getBoostCpuData(deviceResult,queue);
//        }
//    }
//
//    std::cout << "Time taken for sort operation is " <<std::accumulate(durations.begin(),
//                                                                       durations.end(),
//                                                                       0) / durations.size() << " nanoseconds" << std::endl;

    return result;
}

vector<int> BoostAdapter::groupby(vector<int> keys, vector<int> values) {

    compute::device device = compute::system::default_device();
    compute::context context(device);
    compute::command_queue queue(context, device);

    compute::vector<int> deviceKeys = ABC->getBoostGpuData(keys,context,queue);
    compute::vector<int> deviceVals = ABC->getBoostGpuData(values,context,queue);

    compute::vector<int> deviceResult(keys.size(),context);

//    vector<int> durations;
    vector<int> result;

//    for (int i = 0; i <= execution_factor; i++) {
//        auto start = high_resolution_clock::now();  // start time

    // operation here
    deviceResult = ABC->boostGroupBy(deviceKeys,deviceVals,queue,context);

//        auto stop = high_resolution_clock::now(); // stop time
//        auto duration = duration_cast<nanoseconds>(stop - start); // time taken for performing the operation
//        if(i>0) {
//            durations.push_back(duration.count());  // since the initial load time is high, calculation is started from 2nd iteration
//        }else{
    result = ABC->getBoostCpuData(deviceResult,queue);
//        }
//    }
//
//    std::cout << "Time taken for GroupBy operation is " <<std::accumulate(durations.begin(),
//                                                                          durations.end(),
//                                                                          0) / durations.size() << " nanoseconds" << std::endl;

    return result;
}

vector<int> BoostAdapter::countByKey(vector<int> data) {

    compute::device device = compute::system::default_device();
    compute::context context(device);
    compute::command_queue queue(context, device);

    compute::vector<int> deviceData = ABC->getBoostGpuData(data,context,queue);

    compute::vector<int> deviceResult(data.size(),context);

    vector<int> result;
//    vector<int> durations;

//    for (int i = 0; i <= execution_factor; i++) {
//        auto start = high_resolution_clock::now();  // start time

    // operation here
    deviceResult = ABC->boostCountByKey(deviceData, queue, context);

//        auto stop = high_resolution_clock::now(); // stop time
//        auto duration = duration_cast<nanoseconds>(stop - start); // time taken for performing the operation
//        if(i>0) {
//            durations.push_back(duration.count());  // since the initial load time is high, calculation is started from 2nd iteration
//        }else{
    result = ABC->getBoostCpuData(deviceResult,queue);
//        }
//    }
//
//    std::cout << "Time taken for count by key operation is " <<
//              std::accumulate(durations.begin(),durations.end(),0) / durations.size() << " nanoseconds" << std::endl;

    return result;
}

vector<int> BoostAdapter::join(vector<int> parent, vector<int> child)  {

    compute::device device = compute::system::default_device();
    compute::context context(device);
    compute::command_queue queue(context, device);

    compute::vector<int> deviceParent = ABC->getBoostGpuData(parent,context,queue);
    compute::vector<int> deviceChild = ABC->getBoostGpuData(child,context,queue);

    compute::vector<int> deviceResult(child.size(),context);

//    vector<int> durations;
    vector<int> result;

    // operation here
    deviceResult = ABC->boostJoin(deviceParent,deviceChild,queue,context);

    result = ABC->getBoostCpuData(deviceResult,queue);

    return result;
}

vector<float> BoostAdapter::avgByKey(vector<int> keys, vector<int> values) {

    compute::device device = compute::system::default_device();
    compute::context context(device);
    compute::command_queue queue(context, device);

    compute::vector<int> deviceKeys = ABC->getBoostGpuData(keys,context,queue);
    compute::vector<int> deviceVals = ABC->getBoostGpuData(values,context,queue);

    compute::vector<float> deviceResult(context);

//    vector<int> durations;
    vector<float> result;

//    for (int i = 0; i <= execution_factor; i++) {
//        auto start = high_resolution_clock::now();  // start time

    // operation here
    deviceResult = ABC->boostAvgByKey(deviceKeys,deviceVals,queue,context);

//        auto stop = high_resolution_clock::now(); // stop time
//        auto duration = duration_cast<nanoseconds>(stop - start); // time taken for performing the operation
//        if(i>0) {
//            durations.push_back(duration.count());  // since the initial load time is high, calculation is started from 2nd iteration
//        }else{
    result = ABC->getBoostCpuData(deviceResult,queue);
//        }
//    }
//
//    std::cout << "Time taken for Average By Key operation is " <<std::accumulate(durations.begin(),
//                                                                                 durations.end(),
//                                                                                 0) / durations.size() << " nanoseconds" << std::endl;

    return result;
}

vector<int> BoostAdapter::sortByKey(vector<int> data, vector<int> dependent_data, int order){

    compute::device device = compute::system::default_device();
    compute::context context(device);
    compute::command_queue queue(context, device);

    compute::vector<int> deviceData = ABC->getBoostGpuData(data,context,queue);
    compute::vector<int> dependentData = ABC->getBoostGpuData(dependent_data,context,queue);

    compute::vector<int> deviceResult(dependent_data.size(),context);

//    vector<int> durations;
    vector<int> result;

//    for (int i = 0; i <= execution_factor; i++) {
//        auto start = high_resolution_clock::now();  // start time

    // operation here
    deviceResult = ABC->boostSortByKey(deviceData, dependentData, order, queue, context);

//        auto stop = high_resolution_clock::now(); // stop time
//        auto duration = duration_cast<nanoseconds>(stop - start); // time taken for performing the operation
//        if(i>0) {
//            durations.push_back(duration.count());  // since the initial load time is high, calculation is started from 2nd iteration
//        }else{
    result = ABC->getBoostCpuData(deviceResult,queue);
//        }
//    }
//
//    std::cout << "Time taken for Sorting based on another vector operation is " <<std::accumulate(durations.begin(),
//                                                                                                  durations.end(),
//                                                                                                  0) / durations.size() << " nanoseconds" << std::endl;

    return result;
}

vector<int> BoostAdapter::sumOfVectors(vector<int> array1, vector<int> array2) {

    compute::device device = compute::system::default_device();
    compute::context context(device);
    compute::command_queue queue(context, device);

    compute::vector<int> deviceVec1 = ABC->getBoostGpuData(array1,context,queue);
    compute::vector<int> deviceVec2 = ABC->getBoostGpuData(array2,context,queue);

    compute::vector<int> deviceResult(array1.size(),context);

//    vector<int> durations;
    vector<int> result;

//    for (int i = 0; i <= execution_factor; i++) {
//        auto start = high_resolution_clock::now();  // start time

    // operation here
    deviceResult = ABC->boostSumOfVectors(deviceVec1,deviceVec2,queue,context);

//        auto stop = high_resolution_clock::now(); // stop time
//        auto duration = duration_cast<nanoseconds>(stop - start); // time taken for performing the operation
//        if(i>0) {
//            durations.push_back(duration.count());  // since the initial load time is high, calculation is started from 2nd iteration
//        }else{
    result = ABC->getBoostCpuData(deviceResult,queue);
//        }
//    }
//
//    std::cout << "Time taken for concatenating vectors operation is " <<std::accumulate(durations.begin(),
//                                                                                        durations.end(),
//                                                                                        0) / durations.size() << " nanoseconds" << std::endl;

    return result;
}

vector<int> BoostAdapter::getGPUData(vector<int> cpudata) {

    compute::device device = compute::system::default_device();
    compute::context context(device);
    compute::command_queue queue(context, device);


    vector<int> result;

    // operation here
    compute::vector<int> deviceVec1 = ABC->getBoostGpuData(cpudata,context,queue);

    return result;
}

vector<int> BoostAdapter::cpu2gpu(vector<int> cpudata) {

    compute::device device = compute::system::default_device();
    compute::context context(device);
    compute::command_queue queue(context, device);


    vector<int> result;

    // operation here
    compute::vector<int> deviceVec1 = ABC->boostcpu2gpu(cpudata,context,queue);

    return result;
}

vector<int> BoostAdapter::getCPUData(vector<int> data) {

    compute::device device = compute::system::default_device();
    compute::context context(device);
    compute::command_queue queue(context, device);

    vector<int> result;

    compute::vector<int> gpudata = ABC->getBoostGpuData(data,context,queue);

    // operation here
    result = ABC->getBoostCpuData(gpudata,queue);

    return result;
}

vector<int> BoostAdapter::gpu2cpu(vector<int> data) {

    compute::device device = compute::system::default_device();
    compute::context context(device);
    compute::command_queue queue(context, device);

    vector<int> result;

    compute::vector<int> gpudata = ABC->boostcpu2gpu(data,context,queue);

    // operation here
    result = ABC->boostgpu2cpu(gpudata,queue);

    return result;
}

void BoostAdapter::scatter(vector<int> data, vector<int> map) {

    compute::device device = compute::system::default_device();
    compute::context context(device);
    compute::command_queue queue(context, device);

    compute::vector<int> gpudata = ABC->getBoostGpuData(data,context,queue);
    compute::vector<int> gpumap = ABC->getBoostGpuData(map,context,queue);

    ABC->boostScatter(data,map,queue,context);
}

void BoostAdapter::gather(vector<int> data, vector<int> map) {

    compute::device device = compute::system::default_device();
    compute::context context(device);
    compute::command_queue queue(context, device);

    compute::vector<int> gpudata = ABC->getBoostGpuData(data,context,queue);
    compute::vector<int> gpumap = ABC->getBoostGpuData(map,context,queue);
    ABC->boostGather(data,map,queue,context);
}
