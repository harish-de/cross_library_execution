//
// Created by hkumar on 01.09.20.
//

#include <numeric>
#include "ArrayFireAdapter.cuh"

afAdapter::afAdapter(afCompute *AAFC_obj) {
    AAFC = AAFC_obj;
}

vector<int> afAdapter::selection(vector<int> data, string operation, int value) {
    af::array deviceData = AAFC->getAFGpuData(data);
    af::array deviceResult;

    vector<int> result;
    vector<int> durations;

    for (int i = 0; i <= 100; i++) {
        auto start = high_resolution_clock::now();  // start time

        // operation here
        deviceResult = AAFC->afSelection(deviceData,operation,value);

        auto stop = high_resolution_clock::now(); // stop time
        auto duration = duration_cast<microseconds>(stop - start); // time taken for performing the operation
        if(i>0) {
            durations.push_back(duration.count());  // since the initial load time is high, calculation is started from 2nd iteration
        }else{
            result = AAFC->getAFCpuData(deviceResult);
        }
    }

    std::cout << "Time taken for selection operation " << operation << "_" <<to_string(value)
              << " is " <<std::accumulate(durations.begin(),
                                          durations.end(), 0) / durations.size() << " microseconds" << std::endl;

    return result;
}

vector<int> afAdapter::conjunction(vector<int> lhs, vector<int> rhs) {
    af::array deviceLHS = AAFC->getAFGpuData(lhs);
    af::array deviceRHS = AAFC->getAFGpuData(rhs);
    af::array deviceResult;

    vector<int> result;
    vector<int> durations;

    for (int i = 0; i <= 100; i++) {
        auto start = high_resolution_clock::now();  // start time

        // operation here
        deviceResult = AAFC->afConjunction(deviceLHS,deviceRHS);

        auto stop = high_resolution_clock::now(); // stop time
        auto duration = duration_cast<microseconds>(stop - start); // time taken for performing the operation
        if(i>0) {
            durations.push_back(duration.count());  // since the initial load time is high, calculation is started from 2nd iteration
        }else{
            result = AAFC->getAFCpuData(deviceResult);
        }
    }

    std::cout << "Time taken for conjunction operation is " <<std::accumulate(durations.begin(),
                                                                                     durations.end(), 0) / durations.size() << " microseconds" << std::endl;
    return result;
}

vector<int> afAdapter::join(vector<int> parent, vector<int> child) {
    af::array deviceLHS = AAFC->getAFGpuData(parent);
    af::array deviceRHS = AAFC->getAFGpuData(child);
    af::array deviceResult;

    vector<int> result;
    vector<int> durations;

    for (int i = 0; i <= 100; i++) {
        auto start = high_resolution_clock::now();  // start time

        // operation here
        deviceResult = AAFC->afJoin(deviceLHS,deviceRHS);

        auto stop = high_resolution_clock::now(); // stop time
        auto duration = duration_cast<microseconds>(stop - start); // time taken for performing the operation
        if(i>0) {
            durations.push_back(duration.count());  // since the initial load time is high, calculation is started from 2nd iteration
        }else{
            result = AAFC->getAFCpuData(deviceResult);
        }
    }

    std::cout << "Time taken for join operation is " <<std::accumulate(durations.begin(),
                                                                              durations.end(), 0) / durations.size() << " microseconds" << std::endl;
    return result;
}

vector<int> afAdapter::product(vector<int> lhs, vector<int> rhs) {
    af::array deviceLHS = AAFC->getAFGpuData(lhs);
    af::array deviceRHS = AAFC->getAFGpuData(rhs);
    af::array deviceResult;

    vector<int> result;
    vector<int> durations;

    for (int i = 0; i <= 100; i++) {
        auto start = high_resolution_clock::now();  // start time

        // operation here
        deviceResult = AAFC->afProduct(deviceLHS,deviceRHS);

        auto stop = high_resolution_clock::now(); // stop time
        auto duration = duration_cast<microseconds>(stop - start); // time taken for performing the operation
        if(i>0) {
            durations.push_back(duration.count());  // since the initial load time is high, calculation is started from 2nd iteration
        }else{
            result = AAFC->getAFCpuData(deviceResult);
        }
    }

    std::cout << "Time taken for product operation is " <<std::accumulate(durations.begin(),
                                                                                 durations.end(), 0) / durations.size() << " microseconds" << std::endl;
    return result;
}

int afAdapter::sum(vector<int> data) {

    af::array deviceData = AAFC->getAFGpuData(data);
//    af::array deviceResult;
    int result;

//    vector<int> result;
    vector<int> durations;

    for (int i = 0; i <= 100; i++) {
        auto start = high_resolution_clock::now();  // start time

        // operation here
        result = AAFC->afSum(deviceData);

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

float afAdapter::avg(vector<int> data) {

    af::array deviceData = AAFC->getAFGpuData(data);
//    af::array deviceResult;
    float result;

//    vector<int> result;
    vector<int> durations;

    for (int i = 0; i <= 100; i++) {
        auto start = high_resolution_clock::now();  // start time

        // operation here
        result = AAFC->afAvg(deviceData);

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

int afAdapter::countIf(vector<int> data) {

    af::array deviceData = AAFC->getAFGpuData(data);
//    af::array deviceResult;
    int result;

//    vector<int> result;
    vector<int> durations;

    for (int i = 0; i <= 100; i++) {
        auto start = high_resolution_clock::now();  // start time

        // operation here
        result = AAFC->afCountIf(deviceData);

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


int afAdapter::count(vector<int> data) {

    af::array deviceData = AAFC->getAFGpuData(data);
//    af::array deviceResult;
    int result;

//    vector<int> result;
    vector<int> durations;

    for (int i = 0; i <= 100; i++) {
        auto start = high_resolution_clock::now();  // start time

        // operation here
        result = AAFC->afCount(deviceData);

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

vector<int> afAdapter::prefixSum(vector<int> data) {

//    af::array deviceData = AAFC->getAFGpuData(data);
//
//    int result;
//
////    vector<int> result;
//    vector<int> durations;
//
//    for (int i = 0; i <= 100; i++) {
//        auto start = high_resolution_clock::now();  // start time
//
//        // operation here
//        result = AAFC->afCount(deviceData);
//
//        auto stop = high_resolution_clock::now(); // stop time
//        auto duration = duration_cast<microseconds>(stop - start); // time taken for performing the operation
//        if(i>0) {
//            durations.push_back(duration.count());  // since the initial load time is high, calculation is started from 2nd iteration
//        }
//    }
//
//    std::cout << "Time taken for count operation is " <<std::accumulate(durations.begin(),
//                                                                        durations.end(), 0) / durations.size() << " microseconds" << std::endl;

    return data;
}

int afAdapter::findMax(vector<int> data) {

    af::array deviceData = AAFC->getAFGpuData(data);
    int result;

    vector<int> durations;

    for (int i = 0; i <= 100; i++) {
        auto start = high_resolution_clock::now();  // start time

        // operation here
        result = AAFC->afFindMax(deviceData);

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

int afAdapter::findMin(vector<int> data) {

    af::array deviceData = AAFC->getAFGpuData(data);
    int result;

    vector<int> durations;

    for (int i = 0; i <= 100; i++) {
        auto start = high_resolution_clock::now();  // start time

        // operation here
        result = AAFC->afFindMin(deviceData);

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