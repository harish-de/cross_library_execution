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
    vector<int> durations;

    for (int i = 0; i <= 100; i++) {
        auto start = high_resolution_clock::now();  // start time

        // operation here
        deviceResult = ABC->boostSelection(deviceData,operation,value,queue,context,device);

        auto stop = high_resolution_clock::now(); // stop time
        auto duration = duration_cast<microseconds>(stop - start); // time taken for performing the operation
        if(i>0) {
            durations.push_back(duration.count());  // since the initial load time is high, calculation is started from 2nd iteration
        }else{
            result = ABC->getBoostCpuData(deviceResult,queue);
        }
    }


    std::cout << "Time taken for selection operation " << operation << "_" <<to_string(value)
              << " is " <<std::accumulate(durations.begin(),
                                          durations.end(), 0) / durations.size() << " microseconds" << std::endl;

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
    vector<int> durations;

    for (int i = 0; i <= 100; i++) {
        auto start = high_resolution_clock::now();  // start time

        // operation here
        deviceResult = ABC->boostConjunction(deviceLHS,deviceRHS,queue,context);

        auto stop = high_resolution_clock::now(); // stop time
        auto duration = duration_cast<microseconds>(stop - start); // time taken for performing the operation
        if(i>0) {
            durations.push_back(duration.count());  // since the initial load time is high, calculation is started from 2nd iteration
        }else{
            result = ABC->getBoostCpuData(deviceResult,queue);
        }
    }

    std::cout << "Time taken for conjunction operation is " <<std::accumulate(durations.begin(),
                                                                                     durations.end(), 0) / durations.size() << " microseconds" << std::endl;
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
    vector<int> durations;

    for (int i = 0; i <= 100; i++) {
        auto start = high_resolution_clock::now();  // start time

        // operation here
        deviceResult = ABC->boostProduct(deviceLHS,deviceRHS,queue,context);

        auto stop = high_resolution_clock::now(); // stop time
        auto duration = duration_cast<microseconds>(stop - start); // time taken for performing the operation
        if(i>0) {
            durations.push_back(duration.count());  // since the initial load time is high, calculation is started from 2nd iteration
        }else{
            result = ABC->getBoostCpuData(deviceResult,queue);
        }
    }

    std::cout << "Time taken for product operation is " <<std::accumulate(durations.begin(),
                                                                                     durations.end(), 0) / durations.size() << " microseconds" << std::endl;
    return result;
}

int BoostAdapter::sum(vector<int> data) {

    compute::device device = compute::system::default_device();
    compute::context context(device);
    compute::command_queue queue(context, device);

    compute::vector<int> deviceData(data.size(),context);
    deviceData = ABC->getBoostGpuData(data,context,queue);

    int result;

    vector<int> durations;

    for (int i = 0; i <= 100; i++) {
        auto start = high_resolution_clock::now();  // start time

        // operation here
        result = ABC->boostSum(deviceData,queue,context);

        auto stop = high_resolution_clock::now(); // stop time
        auto duration = duration_cast<microseconds>(stop - start); // time taken for performing the operation
        if(i>0) {
            durations.push_back(duration.count());  // since the initial load time is high, calculation is started from 2nd iteration
        }
    }

    std::cout << "Time taken for sum operation is " <<std::accumulate(durations.begin(),
                                          durations.end(), 0) / durations.size() << " microseconds" << std::endl;

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

    for (int i = 0; i <= 100; i++) {
        auto start = high_resolution_clock::now();  // start time

        // operation here
        result = ABC->boostAvg(deviceData,queue,context);

        auto stop = high_resolution_clock::now(); // stop time
        auto duration = duration_cast<microseconds>(stop - start); // time taken for performing the operation
        if(i>0) {
            durations.push_back(duration.count());  // since the initial load time is high, calculation is started from 2nd iteration
        }
    }

    std::cout << "Time taken for average operation is " <<std::accumulate(durations.begin(),
                                                                      durations.end(), 0) / durations.size() << " microseconds" << std::endl;

    return result;
}

int BoostAdapter::countIf(vector<int> data) {

    compute::device device = compute::system::default_device();
    compute::context context(device);
    compute::command_queue queue(context, device);

    compute::vector<int> deviceData(data.size(),context);
    deviceData = ABC->getBoostGpuData(data,context,queue);

    int result;

    vector<int> durations;

    for (int i = 0; i <= 100; i++) {
        auto start = high_resolution_clock::now();  // start time

        // operation here
        result = ABC->boostCountIf(deviceData,queue,context);

        auto stop = high_resolution_clock::now(); // stop time
        auto duration = duration_cast<microseconds>(stop - start); // time taken for performing the operation
        if(i>0) {
            durations.push_back(duration.count());  // since the initial load time is high, calculation is started from 2nd iteration
        }
    }

    std::cout << "Time taken for count operation is " <<std::accumulate(durations.begin(),
                                                                      durations.end(), 0) / durations.size() << " microseconds" << std::endl;

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

    for (int i = 0; i <= 100; i++) {
        auto start = high_resolution_clock::now();  // start time

        // operation here
        result = ABC->boostCount(deviceData);

        auto stop = high_resolution_clock::now(); // stop time
        auto duration = duration_cast<microseconds>(stop - start); // time taken for performing the operation
        if(i>0) {
            durations.push_back(duration.count());  // since the initial load time is high, calculation is started from 2nd iteration
        }
    }

    std::cout << "Time taken for count operation is " <<std::accumulate(durations.begin(),
                                                                        durations.end(), 0) / durations.size() << " microseconds" << std::endl;

    return result;
}


vector<int> BoostAdapter::prefixSum(vector<int> data) {
    compute::device device = compute::system::default_device();
    compute::context context(device);
    compute::command_queue queue(context, device);

    compute::vector<int> deviceData = ABC->getBoostGpuData(data,context,queue);
    int count = ABC->boostCountIf(deviceData,queue,context);
    compute::vector<int> deviceResult(count,context);

    vector<int> durations;
    vector<int> result;

    for (int i = 0; i <= 100; i++) {
        auto start = high_resolution_clock::now();  // start time

        // operation here
        deviceResult = ABC->boostPrefixSum(deviceData,queue,context);

        auto stop = high_resolution_clock::now(); // stop time
        auto duration = duration_cast<microseconds>(stop - start); // time taken for performing the operation
        if(i>0) {
            durations.push_back(duration.count());  // since the initial load time is high, calculation is started from 2nd iteration
        }else{
            result = ABC->getBoostCpuData(deviceResult,queue);
        }
    }

    std::cout << "Time taken for prefix sum operation is " <<std::accumulate(durations.begin(),
                                                                             durations.end(),
                                                                             0) / durations.size() << " microseconds" << std::endl;

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

    for (int i = 0; i <= 100; i++) {
        auto start = high_resolution_clock::now();  // start time

        // operation here
        result = ABC->boostFindMax(deviceData,queue,context);

        auto stop = high_resolution_clock::now(); // stop time
        auto duration = duration_cast<microseconds>(stop - start); // time taken for performing the operation
        if(i>0) {
            durations.push_back(duration.count());  // since the initial load time is high, calculation is started from 2nd iteration
        }
    }

    std::cout << "Time taken for findMax operation is " <<std::accumulate(durations.begin(),
                                                                        durations.end(), 0) / durations.size() << " microseconds" << std::endl;

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

    for (int i = 0; i <= 100; i++) {
        auto start = high_resolution_clock::now();  // start time

        // operation here
        result = ABC->boostFindMin(deviceData,queue,context);

        auto stop = high_resolution_clock::now(); // stop time
        auto duration = duration_cast<microseconds>(stop - start); // time taken for performing the operation
        if(i>0) {
            durations.push_back(duration.count());  // since the initial load time is high, calculation is started from 2nd iteration
        }
    }

    std::cout << "Time taken for findMin operation is " <<std::accumulate(durations.begin(),
                                                                          durations.end(), 0) / durations.size() << " microseconds" << std::endl;

    return result;
}