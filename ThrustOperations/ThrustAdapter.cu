//
// Created by hkumar on 31.08.20.
//

#include "ThrustAdapter.cuh"

ThrustAdapter::ThrustAdapter(ThrustCompute *ATC_obj) {
    ATC = ATC_obj;
}

vector<int> ThrustAdapter::selection(vector<int> data, string operation, int value) {
    thrust::device_vector<int> deviceData = ATC->getThrustGpuData(data);
    thrust::device_vector<int> deviceResult(data.size());

    vector<int> result;
    vector<int> durations;

//    for (int i = 0; i <= execution_factor; i++) {
//    for (int i = 0; i <= execution_factor; i++) {
//        auto start = high_resolution_clock::now();  // start time

    // operation here
    deviceResult = ATC->thrustSelection(deviceData,operation,value);

//        auto stop = high_resolution_clock::now(); // stop time
//        auto duration = duration_cast<nanoseconds>(stop - start); // time taken for performing the operation
//        if(i>0) {
//            durations.push_back(
//                    duration.count());  // since the initial load time is high, calculation is started from 2nd iteration
//        }
//        else{
    result = ATC->getThrustCpuData(deviceResult);
//        }
//    }


//    std::cout << "Time taken for selection operation " << operation << "_" <<to_string(value)
//              << " is " <<  std::accumulate(durations.begin(), durations.end(), 0) / durations.size()
//            << " nanoseconds" << std::endl;


    cout << "Received Thrust selection data" <<endl;
    return result;
}

vector<int> ThrustAdapter::filter(vector<int> data, string operation, int value) {
    thrust::device_vector<int> deviceData = ATC->getThrustGpuData(data);
    thrust::device_vector<int> deviceResult(data.size());
    vector<int> result;
    vector<int> durations;
    // operation here
    deviceResult = ATC->thrustFilter(deviceData,operation,value);
    result = ATC->getThrustCpuData(deviceResult);
    return result;
}


vector<int> ThrustAdapter::selectionArrays(vector<int> lhs, string operation, vector<int> rhs)  {
    thrust::device_vector<int> deviceLHS = ATC->getThrustGpuData(lhs);
    thrust::device_vector<int> deviceRHS = ATC->getThrustGpuData(rhs);
    thrust::device_vector<int> deviceResult(lhs.size());

    vector<int> result;
//    vector<int> durations;

//    for (int i = 0; i <= execution_factor; i++) {
//        auto start = high_resolution_clock::now();  // start time

    // operation here
    deviceResult = ATC->thrustSelectionArrays(deviceLHS,operation,deviceRHS);

//        auto stop = high_resolution_clock::now(); // stop time
//        auto duration = duration_cast<nanoseconds>(stop - start); // time taken for performing the operation
//        if(i>0) {
//            durations.push_back(
//                    duration.count());  // since the initial load time is high, calculation is started from 2nd iteration
//        }
//        else{
    result = ATC->getThrustCpuData(deviceResult);
//        }
//    }
//
//    std::cout << "Time taken for selection operation is " <<std::accumulate(durations.begin(),
//                                                                            durations.end(), 0) / durations.size() << " nanoseconds" << std::endl;

    return result;
}

vector<int> ThrustAdapter::conjunction(vector<int> lhs, vector<int> rhs) {
    thrust::device_vector<int> deviceLHS = ATC->getThrustGpuData(lhs);
    thrust::device_vector<int> deviceRHS = ATC->getThrustGpuData(rhs);
    thrust::device_vector<int> deviceResult(lhs.size());

    vector<int> result;
//    vector<int> durations;


//    for (int i = 0; i <= execution_factor; i++) {
//        auto start = high_resolution_clock::now();  // start time

    // operation here
    deviceResult = ATC->thrustConjunction(deviceLHS,deviceRHS);

//        auto stop = high_resolution_clock::now(); // stop time
//        auto duration = duration_cast<nanoseconds>(stop - start); // time taken for performing the operation
//        if(i>0) {
//            durations.push_back(duration.count());  // since the initial load time is high, calculation is started from 2nd iteration
//        }else{
    result = ATC->getThrustCpuData(deviceResult);
//        }
//    }
//
//    std::cout << "Time taken for conjunction operation is " <<std::accumulate(durations.begin(),
//                                                                              durations.end(), 0) / durations.size() << " nanoseconds" << std::endl;
    return result;
}

vector<int> ThrustAdapter::product(vector<int> lhs, vector<int> rhs) {
    thrust::device_vector<int> deviceLHS = ATC->getThrustGpuData(lhs);
    thrust::device_vector<int> deviceRHS = ATC->getThrustGpuData(rhs);
    thrust::device_vector<int> deviceResult(lhs.size());

    vector<int> result;
//    vector<int> durations;
//
//
//    for (int i = 0; i <= execution_factor; i++) {
//        auto start = high_resolution_clock::now();  // start time

    // operation here
    deviceResult = ATC->thrustProduct(deviceLHS,deviceRHS);

//        auto stop = high_resolution_clock::now(); // stop time
//        auto duration = duration_cast<nanoseconds>(stop - start); // time taken for performing the operation
//        if(i>0) {
//            durations.push_back(duration.count());  // since the initial load time is high, calculation is started from 2nd iteration
//        }else{
    result = ATC->getThrustCpuData(deviceResult);
//        }
//    }

//    std::cout << "Time taken for product operation is " <<std::accumulate(durations.begin(),
//                                                                          durations.end(), 0) / durations.size() << " nanoseconds" << std::endl;
    return result;
}

int ThrustAdapter::sum(vector<int> data) {

    thrust::device_vector<int> deviceData = ATC->getThrustGpuData(data);
    int result;

//    vector<int> durations;
//
//    for (int i = 0; i <= execution_factor; i++) {
//        auto start = high_resolution_clock::now();  // start time

    // operation here
    result = ATC->thrustSum(deviceData);

//        auto stop = high_resolution_clock::now(); // stop time
//        auto duration = duration_cast<nanoseconds>(stop - start); // time taken for performing the operation
//        if(i>0) {
//            durations.push_back(duration.count());  // since the initial load time is high, calculation is started from 2nd iteration
//        }
//    }

//    std::cout << "Time taken for sum operation is " <<std::accumulate(durations.begin(),
//                                                                      durations.end(),
//                                                                      0) / durations.size() << " nanoseconds" << std::endl;
    return result;
}

vector<int> ThrustAdapter::sort(vector<int> data, int order) {

    thrust::device_vector<int> deviceData = ATC->getThrustGpuData(data);

    thrust::device_vector<int> deviceResult(data.size());

    vector<int> result(data.size());
//    vector<int> durations;
//
//    for (int i = 0; i <= execution_factor; i++) {
//        auto start = high_resolution_clock::now();  // start time

    // operation here
    deviceResult = ATC->thrustSort(deviceData,order);

//        auto stop = high_resolution_clock::now(); // stop time
//        auto duration = duration_cast<nanoseconds>(stop - start); // time taken for performing the operation
//        if(i>0) {
//            durations.push_back(duration.count());  // since the initial load time is high, calculation is started from 2nd iteration
//        }else{
//            cout << "before conversion" <<endl;
//            thrust::copy(deviceResult.begin(),deviceResult.end(),result.begin());
    result = ATC->getThrustCpuData(deviceResult);
//            cout << "after conversion" <<endl;
//        }
//    }
//
//
//    std::cout << "Time taken for sort operation is " <<std::accumulate(durations.begin(),
//                                                                       durations.end(), 0) / durations.size() << " nanoseconds" << std::endl;

    return result;
}

vector<int> ThrustAdapter::sortByKey(vector<int> data, vector<int> dependent_data, int order) {

    thrust::device_vector<int> deviceData = ATC->getThrustGpuData(data);
    thrust::device_vector<int> dependentData = ATC->getThrustGpuData(dependent_data);

    thrust::device_vector<int> deviceResult(dependent_data.size());

    vector<int> result(dependent_data.size());
//    vector<int> durations;
//
//    for (int i = 0; i <= execution_factor; i++) {
//        auto start = high_resolution_clock::now();  // start time

    // operation here
    deviceResult = ATC->thrustSortByKey(deviceData, dependentData, order);

//        auto stop = high_resolution_clock::now(); // stop time
//        auto duration = duration_cast<nanoseconds>(stop - start); // time taken for performing the operation
//        if(i>0) {
//            durations.push_back(duration.count());  // since the initial load time is high, calculation is started from 2nd iteration
//        }else{
    result = ATC->getThrustCpuData(deviceResult);
//        }
//    }
//
//
//    std::cout << "Time taken for sort before group by operation is " <<std::accumulate(durations.begin(),
//                                                                                       durations.end(), 0) / durations.size() << " nanoseconds" << std::endl;

    return result;
}

float ThrustAdapter::avg(vector<int> data) {

    thrust::device_vector<int> deviceData = ATC->getThrustGpuData(data);
    float result;

    vector<int> durations;

    for (int i = 0; i <= execution_factor; i++) {
        auto start = high_resolution_clock::now();  // start time

        // operation here
        result = ATC->thrustAvg(deviceData);

        auto stop = high_resolution_clock::now(); // stop time
        auto duration = duration_cast<nanoseconds>(stop - start); // time taken for performing the operation
        if(i>0) {
            durations.push_back(duration.count());  // since the initial load time is high, calculation is started from 2nd iteration
        }
    }

    std::cout << "Time taken for average operation is " <<std::accumulate(durations.begin(),
                                                                          durations.end(),
                                                                          0) / durations.size() << " nanoseconds" << std::endl;
    return result;
}

int ThrustAdapter::countIf(vector<int> data,int value) {

    thrust::device_vector<int> deviceData = ATC->getThrustGpuData(data);
    int result;

    vector<int> durations;

    for (int i = 0; i <= execution_factor; i++) {
        auto start = high_resolution_clock::now();  // start time

        // operation here
        result = ATC->thrustCountIf(deviceData,value);

        auto stop = high_resolution_clock::now(); // stop time
        auto duration = duration_cast<nanoseconds>(stop - start); // time taken for performing the operation
        if(i>0) {
            durations.push_back(duration.count());  // since the initial load time is high, calculation is started from 2nd iteration
        }
    }

    std::cout << "Time taken for count operation is " <<std::accumulate(durations.begin(),
                                                                        durations.end(),
                                                                        0) / durations.size() << " nanoseconds" << std::endl;

    return result;
}

int ThrustAdapter::count(vector<int> data) {

    thrust::device_vector<int> deviceData = ATC->getThrustGpuData(data);
    int result;

    vector<int> durations;

    for (int i = 0; i <= execution_factor; i++) {
        auto start = high_resolution_clock::now();  // start time

        // operation here
        result = ATC->thrustCount(deviceData);

        auto stop = high_resolution_clock::now(); // stop time
        auto duration = duration_cast<nanoseconds>(stop - start); // time taken for performing the operation
        if(i>0) {
            durations.push_back(duration.count());  // since the initial load time is high, calculation is started from 2nd iteration
        }
    }

    std::cout << "Time taken for count operation is " <<std::accumulate(durations.begin(),
                                                                        durations.end(),
                                                                        0) / durations.size() << " nanoseconds" << std::endl;
    return result;
}


vector<int> ThrustAdapter::join(vector<int> parent, vector<int> child) {
    thrust::device_vector<int> deviceLHS = ATC->getThrustGpuData(parent);
    thrust::device_vector<int> deviceRHS = ATC->getThrustGpuData(child);

    thrust::device_vector<int> deviceResult(child.size());
    vector<int> result;
    deviceResult = ATC->thrustJoin(deviceLHS,deviceRHS);

    result = ATC->getThrustCpuData(deviceResult);
    return result;
}

vector<int> ThrustAdapter::prefixSum(vector<int> data) {
    thrust::device_vector<int> deviceData = ATC->getThrustGpuData(data);
    int count = ATC->thrustCountIf(deviceData,1);
    thrust::device_vector<int> deviceResult(count);

//    vector<int> durations;
    vector<int> result;

//    for (int i = 0; i <= execution_factor; i++) {
//        auto start = high_resolution_clock::now();  // start time

    // operation here
    deviceResult = ATC->thrustPrefixSum(deviceData);

//        auto stop = high_resolution_clock::now(); // stop time
//        auto duration = duration_cast<nanoseconds>(stop - start); // time taken for performing the operation
//        if(i>0) {
//            durations.push_back(duration.count());  // since the initial load time is high, calculation is started from 2nd iteration
//        }else{
    result = ATC->getThrustCpuData(deviceResult);
//        }
//    }
//
//    std::cout << "Time taken for prefix sum operation is " <<std::accumulate(durations.begin(),
//                                                                             durations.end(),
//                                                                             0) / durations.size() << " nanoseconds" << std::endl;

    return result;
}

vector<int> ThrustAdapter::prefixSum(vector<int> bitmapdata, vector<int> colData)  {
    thrust::device_vector<int> deviceBitmapData = ATC->getThrustGpuData(bitmapdata);
    thrust::device_vector<int> deviceColumnData = ATC->getThrustGpuData(colData);
    int count = ATC->thrustCountIf(deviceBitmapData,1);
    thrust::device_vector<int> deviceResult(count);

    vector<int> durations;
    vector<int> result;

    for (int i = 0; i <= execution_factor; i++) {
        auto start = high_resolution_clock::now();  // start time

        // operation here
        deviceResult = ATC->thrustPrefixSum(deviceBitmapData,deviceColumnData);

        auto stop = high_resolution_clock::now(); // stop time
        auto duration = duration_cast<nanoseconds>(stop - start); // time taken for performing the operation
        if(i>0) {
            durations.push_back(duration.count());  // since the initial load time is high, calculation is started from 2nd iteration
        }else{
            result = ATC->getThrustCpuData(deviceResult);
        }
    }

    std::cout << "Time taken for scattering operation is " <<std::accumulate(durations.begin(),
                                                                             durations.end(),
                                                                             0) / durations.size() << " nanoseconds" << std::endl;

    return result;
}

int ThrustAdapter::findMax(vector<int> data) {

    thrust::device_vector<int> deviceData = ATC->getThrustGpuData(data);
    int result;

    vector<int> durations;

    for (int i = 0; i <= execution_factor; i++) {
        auto start = high_resolution_clock::now();  // start time

        // operation here
        result = ATC->thrustFindMax(deviceData);

        auto stop = high_resolution_clock::now(); // stop time
        auto duration = duration_cast<nanoseconds>(stop - start); // time taken for performing the operation
        if(i>0) {
            durations.push_back(duration.count());  // since the initial load time is high, calculation is started from 2nd iteration
        }
    }

    std::cout << "Time taken for findMax operation is " <<std::accumulate(durations.begin(),
                                                                          durations.end(),
                                                                          0) / durations.size() << " nanoseconds" << std::endl;
    return result;
}

int ThrustAdapter::findMin(vector<int> data) {

    thrust::device_vector<int> deviceData = ATC->getThrustGpuData(data);
    int result;

    vector<int> durations;

    for (int i = 0; i <= execution_factor; i++) {
        auto start = high_resolution_clock::now();  // start time

        // operation here
        result = ATC->thrustFindMin(deviceData);

        auto stop = high_resolution_clock::now(); // stop time
        auto duration = duration_cast<nanoseconds>(stop - start); // time taken for performing the operation
        if(i>0) {
            durations.push_back(duration.count());  // since the initial load time is high, calculation is started from 2nd iteration
        }
    }

    std::cout << "Time taken for findMin operation is " <<std::accumulate(durations.begin(),
                                                                          durations.end(),
                                                                          0) / durations.size() << " nanoseconds" << std::endl;
    return result;
}

//vector<int> ThrustAdapter::hash_join(vector<int> parent, vector<int> child) {
//    thrust::device_vector<int> deviceLHS = ATC->getThrustGpuData(parent);
//    thrust::device_vector<int> deviceRHS = ATC->getThrustGpuData(child);
//
//    thrust::device_vector<int> deviceResult(child.size());
//
//    vector<int> result;
//    vector<int> durations;
//
//    for (int i = 0; i < execution_factor; i++) {
//        auto start = high_resolution_clock::now();  // start time
//
//        // operation here
//        deviceResult = ATC->thrustHashJoin(deviceLHS,deviceRHS);
//
//        auto stop = high_resolution_clock::now(); // stop time
//        auto duration = duration_cast<nanoseconds>(stop - start); // time taken for performing the operation
//
////        cout << "Time taken for hash join: " << duration.count() << endl;
//
//        if(i>0) {
//            durations.push_back(duration.count());  // since the initial load time is high, calculation is started from 2nd iteration
//        }else{
//            result = ATC->getThrustCpuData(deviceResult);
//        }
//    }
//
//
//
//    std::cout << "Time taken for hash join operation is " <<std::accumulate(durations.begin(),
//                                                                       durations.end(), 0) / durations.size() << " nanoseconds" << std::endl;
//    return result;
//}

//vector<int> ThrustAdapter::IN(vector<int> dataToFilter,
//                              vector<int> refData,
//                              vector<int> prefixSum){
//
//    thrust::device_vector<int> deviceData= ATC->getThrustGpuData(dataToFilter);
//    thrust::device_vector<int> deviceRefData = ATC->getThrustGpuData(refData);
//    thrust::device_vector<int> devicePS = ATC->getThrustGpuData(prefixSum);
//
//    thrust::device_vector<int> deviceResult(dataToFilter.size());
//
//    vector<int> result;
//    vector<int> durations;
//
//    for (int i = 0; i < execution_factor; i++) {
//        auto start = high_resolution_clock::now();  // start time
//
//        // operation here
//        deviceResult = ATC->thrustIN(deviceData,deviceRefData,devicePS);
//
//        auto stop = high_resolution_clock::now(); // stop time
//        auto duration = duration_cast<nanoseconds>(stop - start); // time taken for performing the operation
//
////        cout << "Time taken for IN operation: " << duration.count() << endl;
//
//        if(i>0) {
//            durations.push_back(duration.count());  // since the initial load time is high, calculation is started from 2nd iteration
//        }else{
//            result = ATC->getThrustCpuData(deviceResult);
//        }
//    }
//
//
//
//    std::cout << "Time taken for IN operation is " <<std::accumulate(durations.begin(),
//                                                                       durations.end(), 0) / durations.size() << " nanoseconds" << std::endl;
//    return result;
//
//}

vector<int> ThrustAdapter::groupby(vector<int> keys,
                                   vector<int> values){

    thrust::device_vector<int> deviceKeys= ATC->getThrustGpuData(keys);
    thrust::device_vector<int> deviceData = ATC->getThrustGpuData(values);

    thrust::device_vector<int>deviceResult;

    vector<int> result;

//    vector<int> durations;

//    for (int i = 0; i < execution_factor; i++) {
//        auto start = high_resolution_clock::now();  // start time

    // operation here
    deviceResult = ATC->thrustGroupBy(deviceKeys,deviceData);
//
//        auto stop = high_resolution_clock::now(); // stop time
//        auto duration = duration_cast<nanoseconds>(stop - start); // time taken for performing the operation
//
////        cout << "Time taken for IN operation: " << duration.count() << endl;
//
//        if(i>0) {
//            durations.push_back(duration.count());  // since the initial load time is high, calculation is started from 2nd iteration
//        }else{
    result = ATC->getThrustCpuData(deviceResult);
//        }
//    }
//
//    std::cout << "Time taken for group by operation is " <<std::accumulate(durations.begin(),
//                                                                           durations.end(), 0) / durations.size() << " nanoseconds" << std::endl;

    return result;
}

vector<int> ThrustAdapter::countByKey(vector<int> data) {

    thrust::device_vector<int> deviceData = ATC->getThrustGpuData(data);

    thrust::device_vector<int>deviceResult;

    vector<int> result;
//    vector<int> durations;
//
//    for (int i = 0; i < execution_factor; i++) {
//        auto start = high_resolution_clock::now();  // start time
    // operation here
    deviceResult = ATC->thrustCountByKey(deviceData);

//        auto stop = high_resolution_clock::now(); // stop time
//        auto duration = duration_cast<nanoseconds>(stop - start); // time taken for performing the operation
//
////        cout << "Time taken for IN operation: " << duration.count() << endl;
//
//        if(i>0) {
//            durations.push_back(duration.count());  // since the initial load time is high, calculation is started from 2nd iteration
//        }else{
    result = ATC->getThrustCpuData(deviceResult);
//        }
//    }
//
//    std::cout << "Time taken for count by key operation is "
//              <<std::accumulate(durations.begin(),durations.end(), 0) / durations.size() << " nanoseconds" << std::endl;

    return result;
}

vector<float> ThrustAdapter::avgByKey(vector<int> keys, vector<int> values) {

    thrust::device_vector<int> deviceKeys = ATC->getThrustGpuData(keys);
    thrust::device_vector<int> deviceVals = ATC->getThrustGpuData(values);

    thrust::device_vector<float>deviceResult;

    vector<float> result;

//    vector<int> durations;
//
//    for (int i = 0; i < execution_factor; i++) {
//        auto start = high_resolution_clock::now();  // start time

    // operation here
    deviceResult = ATC->thrustAvgByKey(deviceKeys,deviceVals);

//        auto stop = high_resolution_clock::now(); // stop time
//        auto duration = duration_cast<nanoseconds>(stop - start); // time taken for performing the operation
//
//        if(i>0) {
//            durations.push_back(duration.count());  // since the initial load time is high, calculation is started from 2nd iteration
//        }else{
    result = ATC->getThrustCpuData(deviceResult);
//        }
//    }
//
//    std::cout << "Time taken for average by key operation is " <<std::accumulate(durations.begin(),
//                                                                                 durations.end(), 0) / durations.size() << " nanoseconds" << std::endl;

    return result;
}


vector<int> ThrustAdapter::sumOfVectors(vector<int> array1, vector<int> array2) {

    thrust::device_vector<int> deviceVec1 = ATC->getThrustGpuData(array1);
    thrust::device_vector<int> deviceVec2 = ATC->getThrustGpuData(array2);
    thrust::device_vector<int>deviceResult;
    vector<int> result;
//    vector<int> durations;
//
//    for (int i = 0; i < execution_factor; i++) {
//        auto start = high_resolution_clock::now();  // start time

    // operation here
    deviceResult = ATC->thrustSumOfVectors(deviceVec1,deviceVec2);

//        auto stop = high_resolution_clock::now(); // stop time
//        auto duration = duration_cast<nanoseconds>(stop - start); // time taken for performing the operation
//
//        if(i>0) {
//            durations.push_back(duration.count());  // since the initial load time is high, calculation is started from 2nd iteration
//        }else{
    result = ATC->getThrustCpuData(deviceResult);
//        }
//    }
//    std::cout << "Time taken for Vector concatenation operation is " <<std::accumulate(durations.begin(),
//                                                                                       durations.end(), 0) / durations.size() << " nanoseconds" << std::endl;
    return result;
}

vector<int> ThrustAdapter::getGPUData(vector<int> cpudata) {

    vector<int> result;
    thrust::device_vector<int> deviceResult = ATC->getThrustGpuData(cpudata);
    cpudata.clear();
    cpudata.shrink_to_fit();
    return result;
}

vector<int> ThrustAdapter::cpu2gpu(vector<int> cpudata) {
    vector<int> result;
    thrust::device_vector<int> deviceResult = ATC->thrustcpu2gpu(cpudata);
    cpudata.clear();
    cpudata.shrink_to_fit();
    return result;
}

vector<int> ThrustAdapter::getCPUData(vector<int> data) {

    thrust::device_vector<int> gpudata = ATC->getThrustGpuData(data);
    vector<int> result;
    result = ATC->getThrustCpuData(gpudata);
    return result;
}

vector<int> ThrustAdapter::gpu2cpu(vector<int> data) {
    thrust::device_vector<int> gpudata = ATC->thrustcpu2gpu(data);
    vector<int> result;
    result = ATC->thrustgpu2cpu(gpudata);
    return result;
}

void ThrustAdapter::scatter(vector<int> data, vector<int> map) {
    thrust::device_vector<int> gpudata = ATC->getThrustGpuData(data);
    thrust::device_vector<int> gpumap = ATC->getThrustGpuData(map);
    ATC->thrustScatter(data,map);
}

void ThrustAdapter::gather(vector<int> data, vector<int> map) {
    thrust::device_vector<int> gpudata = ATC->getThrustGpuData(data);
    thrust::device_vector<int> gpumap = ATC->getThrustGpuData(map);
    ATC->thrustGather(data,map);
}
