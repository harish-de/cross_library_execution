//
// Created by hkumar on 01.09.20.
//

#include <numeric>
#include "ArrayFireAdapter.cuh"
#include "../ThrustOperations/ThrustAdapter.cuh"
#include "../ThrustOperations/ThrustComputeOps.cuh"

afAdapter::afAdapter(afCompute *AAFC_obj) {
    AAFC = AAFC_obj;
}

vector<int> afAdapter::selection(vector<int> data, string operation, int value) {
    af::array deviceData = AAFC->getAFGpuData(data);
    af::array deviceResult;

    vector<int> result;
//    vector<int> durations;
//
//    for (int i = 0; i <= execution_factor; i++) {
//        auto start = high_resolution_clock::now();  // start time

    // operation here
    deviceResult = AAFC->afSelection(deviceData,operation,value);

//        auto stop = high_resolution_clock::now(); // stop time
//        auto duration = duration_cast<nanoseconds>(stop - start); // time taken for performing the operation
//        if(i>0) {
//            durations.push_back(duration.count());  // since the initial load time is high, calculation is started from 2nd iteration
//        }else{
    result = AAFC->getAFCpuData(deviceResult);
//        }
//    }
//
//    std::cout << "Time taken for selection operation " << operation << "_" <<to_string(value)
//              << " is " <<std::accumulate(durations.begin(),
//                                          durations.end(), 0) / durations.size() << " nanoseconds" << std::endl;

    return result;
}


vector<int> afAdapter::filter(vector<int> data, string operation, int value) {
    af::array deviceData = AAFC->getAFGpuData(data);
    af::array deviceResult;

    vector<int> result;
    vector<int> durations;

    // operation here
    deviceResult = AAFC->afFilter(deviceData,operation,value);

    result = AAFC->getAFCpuData(deviceResult);

    return result;
}

vector<int> afAdapter::selectionArrays(vector<int> lhs,string operation,vector<int> rhs){
    af::array deviceLHS = AAFC->getAFGpuData(lhs);
    af::array deviceRHS = AAFC->getAFGpuData(rhs);
    af::array deviceResult;

    vector<int> result;
//    vector<int> durations;
//
//    for (int i = 0; i <= execution_factor; i++) {
//        auto start = high_resolution_clock::now();  // start time

    // operation here
    deviceResult = AAFC->afSelectionArrays(deviceLHS,operation,deviceRHS);

//        auto stop = high_resolution_clock::now(); // stop time
//        auto duration = duration_cast<nanoseconds>(stop - start); // time taken for performing the operation
//        if(i>0) {
//            durations.push_back(duration.count());  // since the initial load time is high, calculation is started from 2nd iteration
//        }else{
    result = AAFC->getAFCpuData(deviceResult);
//        }
//    }

//    std::cout << "Time taken for selection operation is " <<std::accumulate(durations.begin(),
//                                                                            durations.end(), 0) / durations.size() << " nanoseconds" << std::endl;
    return result;

}

vector<int> afAdapter::conjunction(vector<int> lhs, vector<int> rhs) {
    af::array deviceLHS = AAFC->getAFGpuData(lhs);
    af::array deviceRHS = AAFC->getAFGpuData(rhs);
    af::array deviceResult;

    vector<int> result;
//    vector<int> durations;
//
//    for (int i = 0; i <= execution_factor; i++) {
//        auto start = high_resolution_clock::now();  // start time

    // operation here
    deviceResult = AAFC->afConjunction(deviceLHS,deviceRHS);

//        auto stop = high_resolution_clock::now(); // stop time
//        auto duration = duration_cast<nanoseconds>(stop - start); // time taken for performing the operation
//        if(i>0) {
//            durations.push_back(duration.count());  // since the initial load time is high, calculation is started from 2nd iteration
//        }else{
    result = AAFC->getAFCpuData(deviceResult);
//        }
//    }
//
//    std::cout << "Time taken for conjunction operation is " <<std::accumulate(durations.begin(),
//                                                                              durations.end(), 0) / durations.size() << " nanoseconds" << std::endl;
    return result;
}

vector<int> afAdapter::join(vector<int> parent, vector<int> child) {

    ThrustAdapter *thrustAdapter = new ThrustAdapter(new ThrustCompute);
    vector<int> result = thrustAdapter->join(parent,child);

//    af::array deviceLHS = AAFC->getAFGpuData(parent);
//    af::array deviceRHS = AAFC->getAFGpuData(child);
//    af::array deviceResult;
//
//    vector<int> result;
//    vector<int> durations;
//
//    for (int i = 0; i <= execution_factor; i++) {
//        auto start = high_resolution_clock::now();  // start time
//
//        // operation here
//        deviceResult = AAFC->afJoin(deviceLHS,deviceRHS);
//
//        auto stop = high_resolution_clock::now(); // stop time
//        auto duration = duration_cast<nanoseconds>(stop - start); // time taken for performing the operation
//
//        if(i>0) {
//            durations.push_back(duration.count());  // since the initial load time is high, calculation is started from 2nd iteration
//
//        }else{
//            result = AAFC->getAFCpuData(deviceResult);
//        }
//    }
//
//    std::cout << "Time taken for join operation is " <<std::accumulate(durations.begin(),
//                                                                              durations.end(), 0) / durations.size() << " nanoseconds" << std::endl;
    return result;
}

vector<int> afAdapter::product(vector<int> lhs, vector<int> rhs) {
    af::array deviceLHS = AAFC->getAFGpuData(lhs);
    af::array deviceRHS = AAFC->getAFGpuData(rhs);
    af::array deviceResult;

    vector<int> result;
//    vector<int> durations;
//
//    for (int i = 0; i <= execution_factor; i++) {
//        auto start = high_resolution_clock::now();  // start time

    // operation here
    deviceResult = AAFC->afProduct(deviceLHS,deviceRHS);

//        auto stop = high_resolution_clock::now(); // stop time
//        auto duration = duration_cast<nanoseconds>(stop - start); // time taken for performing the operation
//        if(i>0) {
//            durations.push_back(duration.count());  // since the initial load time is high, calculation is started from 2nd iteration
//        }else{
    result = AAFC->getAFCpuData(deviceResult);
//        }
//    }
//
//    std::cout << "Time taken for product operation is " <<std::accumulate(durations.begin(),
//                                                                          durations.end(), 0) / durations.size() << " nanoseconds" << std::endl;
    return result;
}

int afAdapter::sum(vector<int> data) {

    af::array deviceData = AAFC->getAFGpuData(data);
//    af::array deviceResult;
    int result;

//    vector<int> result;
//    vector<int> durations;

//    for (int i = 0; i <= execution_factor; i++) {
//        auto start = high_resolution_clock::now();  // start time

    // operation here
    result = AAFC->afSum(deviceData);

//        auto stop = high_resolution_clock::now(); // stop time
//        auto duration = duration_cast<nanoseconds>(stop - start); // time taken for performing the operation
//        if(i>0) {
//            durations.push_back(duration.count());  // since the initial load time is high, calculation is started from 2nd iteration
//        }
//    }
//
//    std::cout << "Time taken for sum operation is " <<std::accumulate(durations.begin(),
//                                                                      durations.end(), 0) / durations.size() << " nanoseconds" << std::endl;

    return result;
}

float afAdapter::avg(vector<int> data) {

    af::array deviceData = AAFC->getAFGpuData(data);
//    af::array deviceResult;
    float result;

//    vector<int> result;
    vector<int> durations;

    for (int i = 0; i <= execution_factor; i++) {
        auto start = high_resolution_clock::now();  // start time

        // operation here
        result = AAFC->afAvg(deviceData);

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

int afAdapter::countIf(vector<int> data,int value) {

    af::array deviceData = AAFC->getAFGpuData(data);
//    af::array deviceResult;
    int result;

//    vector<int> result;
    vector<int> durations;

    for (int i = 0; i <= execution_factor; i++) {
        auto start = high_resolution_clock::now();  // start time

        // operation here
        result = AAFC->afCountIf(deviceData,value);

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


int afAdapter::count(vector<int> data) {

    af::array deviceData = AAFC->getAFGpuData(data);
//    af::array deviceResult;
    int result;

//    vector<int> result;
    vector<int> durations;

    for (int i = 0; i <= execution_factor; i++) {
        auto start = high_resolution_clock::now();  // start time

        // operation here
        result = AAFC->afCount(deviceData);

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

vector<int> afAdapter::prefixSum(vector<int> data) {

//    af::array deviceData = AAFC->getAFGpuData(data);
//
//    int result;
//
////    vector<int> result;
//    vector<int> durations;
//
//    for (int i = 0; i <= execution_factor; i++) {
//        auto start = high_resolution_clock::now();  // start time
//
//        // operation here
//        result = AAFC->afCount(deviceData);
//
//        auto stop = high_resolution_clock::now(); // stop time
//        auto duration = duration_cast<nanoseconds>(stop - start); // time taken for performing the operation
//        if(i>0) {
//            durations.push_back(duration.count());  // since the initial load time is high, calculation is started from 2nd iteration
//        }
//    }
//
//    std::cout << "Time taken for count operation is " <<std::accumulate(durations.begin(),
//                                                                        durations.end(), 0) / durations.size() << " nanoseconds" << std::endl;

    return data;
}

int afAdapter::findMax(vector<int> data) {

    af::array deviceData = AAFC->getAFGpuData(data);
    int result;

    vector<int> durations;

    for (int i = 0; i <= execution_factor; i++) {
        auto start = high_resolution_clock::now();  // start time

        // operation here
        result = AAFC->afFindMax(deviceData);

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

int afAdapter::findMin(vector<int> data) {

    af::array deviceData = AAFC->getAFGpuData(data);
    int result;

    vector<int> durations;

    for (int i = 0; i <= execution_factor; i++) {
        auto start = high_resolution_clock::now();  // start time

        // operation here
        result = AAFC->afFindMin(deviceData);

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

vector<int> afAdapter::sort(vector<int> data, int order) {
    af::array deviceData = AAFC->getAFGpuData(data);
    af::array deviceResult;

    vector<int> result;
//    vector<int> durations;
//
//    for (int i = 0; i <= execution_factor; i++) {
//        auto start = high_resolution_clock::now();  // start time

    // operation here
    deviceResult = AAFC->afSort(deviceData,order);

//        auto stop = high_resolution_clock::now(); // stop time
//        auto duration = duration_cast<nanoseconds>(stop - start); // time taken for performing the operation
//        if(i>0) {
//            durations.push_back(duration.count());  // since the initial load time is high, calculation is started from 2nd iteration
//        }else{
    result = AAFC->getAFCpuData(deviceResult);
//        }
//    }
//
//    std::cout << "Time taken for sort operation is " <<std::accumulate(durations.begin(),
//                                                                       durations.end(), 0) / durations.size() << " nanoseconds" << std::endl;

    return result;
}

vector<int> afAdapter::groupby(vector<int> keys, vector<int> values) {
    af::array deviceKeys = AAFC->getAFGpuData(keys);
    af::array deviceVals = AAFC->getAFGpuData(values);
    af::array deviceResult;

    vector<int> result;
//    vector<int> durations;
//
//    for (int i = 0; i <= execution_factor; i++) {
//        auto start = high_resolution_clock::now();  // start time

    // operation here
    deviceResult = AAFC->afGroupBy(deviceKeys,deviceVals);

//        auto stop = high_resolution_clock::now(); // stop time
//        auto duration = duration_cast<nanoseconds>(stop - start); // time taken for performing the operation
//        if(i>0) {
//            durations.push_back(duration.count());  // since the initial load time is high, calculation is started from 2nd iteration
//        }else{
    result = AAFC->getAFCpuData(deviceResult);
//        }
//    }
//
//    std::cout << "Time taken for GroupBy operation is " <<std::accumulate(durations.begin(),
//                                                                          durations.end(), 0) / durations.size() << " nanoseconds" << std::endl;

    return result;
}

vector<int> afAdapter::countByKey(vector<int> data) {

    af::array deviceData = AAFC->getAFGpuData(data);
    af::array deviceResult;

    vector<int> result;
//    vector<int> durations;
//
//    for (int i = 0; i <= execution_factor; i++) {
//        auto start = high_resolution_clock::now();

    // operation here
    deviceResult = AAFC->afCountByKey(deviceData);
//        auto stop = high_resolution_clock::now(); // stop time
//        auto duration = duration_cast<nanoseconds>(stop - start); // time taken for performing the operation
//        if(i>0) {
//            durations.push_back(duration.count());  // since the initial load time is high, calculation is started from 2nd iteration
//        }else{
    result = AAFC->getAFCpuData(deviceResult);
//        }
//    }
//
//    std::cout << "Time taken for count by key operation is " <<
//              std::accumulate(durations.begin(),durations.end(), 0) / durations.size() << " nanoseconds" << std::endl;

    return result;
}

vector<int> afAdapter::sumOfVectors(vector<int> array1, vector<int> array2) {

    af::array deviceVec1 = AAFC->getAFGpuData(array1);
    af::array deviceVec2 = AAFC->getAFGpuData(array2);

    af::array deviceResult;
    vector<int> result;
//    vector<int> durations;

//    for (int i = 0; i <= execution_factor; i++) {
//        auto start = high_resolution_clock::now();  // start time

    // operation here
    deviceResult = AAFC->afSumOfVectors(deviceVec1,deviceVec2);

//        auto stop = high_resolution_clock::now(); // stop time
//        auto duration = duration_cast<nanoseconds>(stop - start); // time taken for performing the operation
//        if(i>0) {
//            durations.push_back(duration.count());  // since the initial load time is high, calculation is started from 2nd iteration
//        }else{
    result = AAFC->getAFCpuData(deviceResult);
//        }
//    }
//    std::cout << "Time taken for concatenation of vectors operation is " <<std::accumulate(durations.begin(),
//                                                                                           durations.end(), 0) / durations.size() << " nanoseconds" << std::endl;

    return result;
}

vector<int> afAdapter::sortByKey(vector<int> data, vector<int> dependent_data, int order) {

//    vector<float> temp_data(data.begin(),data.end());
//    vector<float> temp(dependent_data.begin(),dependent_data.end());

    af::array deviceData = AAFC->getAFGpuData(data);
    af::array dependentData = AAFC->getAFGpuData(dependent_data);

//    vector<float> index(dependent_data.size());
//    std::iota(index.begin(),index.end(),0);

//    af::array deviceIndex = AAFC->getAFGpuData(index);

    af::array deviceResult;
    vector<int> result;
//    vector<int> durations;

//    for (int i = 0; i <= execution_factor; i++) {
//        auto start = high_resolution_clock::now();  // start time

    // operation here
    deviceResult = AAFC->afSortByKey(deviceData, dependentData, order);

//        auto stop = high_resolution_clock::now(); // stop time
//        auto duration = duration_cast<nanoseconds>(stop - start); // time taken for performing the operation
//        if(i>0) {
//            durations.push_back(duration.count());  // since the initial load time is high, calculation is started from 2nd iteration
//        }else{
    result = AAFC->getAFCpuData(deviceResult);
//        }
//    }
//
//    std::cout << "Time taken for Sort based on another vector"
//                 " operation is " <<std::accumulate(durations.begin(),
//                                                    durations.end(), 0) / durations.size() << " nanoseconds" << std::endl;

    return result;
}

vector<float> afAdapter::avgByKey(vector<int> keys, vector<int> values) {

    af::array deviceKeys = AAFC->getAFGpuData(keys);
    af::array deviceVals = AAFC->getAFGpuData(values);

    af::array deviceResult;
    vector<int> result;
    ;
//    vector<int> durations;
//
//    for (int i = 0; i <= execution_factor; i++) {
//        auto start = high_resolution_clock::now();  // start time

    // operation here
    deviceResult = AAFC->afAvgByKey(deviceKeys,deviceVals);

//        auto stop = high_resolution_clock::now(); // stop time
//        auto duration = duration_cast<nanoseconds>(stop - start); // time taken for performing the operation
//        if(i>0) {
//            durations.push_back(duration.count());  // since the initial load time is high, calculation is started from 2nd iteration
//        }else{
    result = AAFC->getAFCpuData(deviceResult);
//        }
//    }
//
//    std::cout << "Time taken for Average by key operation is " <<std::accumulate(durations.begin(),
//                                                                                 durations.end(), 0) / durations.size() << " nanoseconds" << std::endl;

    vector<float> avg_result(result.begin(),result.end());
    return avg_result;
}

vector<int> afAdapter::getGPUData(vector<int> cpudata) {

    vector<int> result;
    vector<int> durations;


    // operation here
    af::array gpudata = AAFC->getAFGpuData(cpudata);
    cpudata.clear();

    return result;
}

vector<int> afAdapter::cpu2gpu(vector<int> cpudata) {

    vector<int> result;
    vector<int> durations;
    // operation here
    af::array gpudata = AAFC->afcpu2gpu(cpudata);
    cpudata.clear();

    return result;
}

vector<int> afAdapter::getCPUData(vector<int> data) {

    af::array gpudata = AAFC->getAFGpuData(data);

    vector<int> result;

    // operation here
    result = AAFC->getAFCpuData(gpudata);

    return result;
}

vector<int> afAdapter::gpu2cpu(vector<int> data) {

    af::array gpudata = AAFC->afcpu2gpu(data);

    vector<int> result;

    // operation here
    result = AAFC->afgpu2cpu(gpudata);

    return result;
}

