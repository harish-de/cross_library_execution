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

    for (int i = 0; i <= 100; i++) {
        auto start = high_resolution_clock::now();  // start time

        // operation here
        deviceResult = ATC->thrustSelection(deviceData,operation,value);

        auto stop = high_resolution_clock::now(); // stop time
        auto duration = duration_cast<microseconds>(stop - start); // time taken for performing the operation
        if(i>0) {
            durations.push_back(
                    duration.count());  // since the initial load time is high, calculation is started from 2nd iteration
        }
        else{
            result = ATC->getThrustCpuData(deviceResult);
        }
    }


    std::cout << "Time taken for selection operation " << operation << "_" <<to_string(value)
              << " is " <<std::accumulate(durations.begin(),
                                          durations.end(), 0) / durations.size() << " microseconds" << std::endl;

    thrust::device_vector<int> buffer = result;
    thrust::exclusive_scan(buffer.begin(),buffer.end(),buffer.begin());

//    vector<int> host_buffer = ATC->getThrustCpuData(buffer);
//    int size = host_buffer.back();

    return result;
}

vector<int> ThrustAdapter::conjunction(vector<int> lhs, vector<int> rhs) {
    thrust::device_vector<int> deviceLHS = ATC->getThrustGpuData(lhs);
    thrust::device_vector<int> deviceRHS = ATC->getThrustGpuData(rhs);
    thrust::device_vector<int> deviceResult(lhs.size());

    vector<int> result;
    vector<int> durations;


    for (int i = 0; i <= 100; i++) {
        auto start = high_resolution_clock::now();  // start time

        // operation here
        deviceResult = ATC->thrustConjunction(deviceLHS,deviceRHS);

        auto stop = high_resolution_clock::now(); // stop time
        auto duration = duration_cast<microseconds>(stop - start); // time taken for performing the operation
        if(i>0) {
            durations.push_back(duration.count());  // since the initial load time is high, calculation is started from 2nd iteration
        }else{
            result = ATC->getThrustCpuData(deviceResult);
        }
    }

    std::cout << "Time taken for conjunction operation is " <<std::accumulate(durations.begin(),
                                                                              durations.end(), 0) / durations.size() << " microseconds" << std::endl;
    return result;
}

vector<int> ThrustAdapter::product(vector<int> lhs, vector<int> rhs) {
    thrust::device_vector<int> deviceLHS = ATC->getThrustGpuData(lhs);
    thrust::device_vector<int> deviceRHS = ATC->getThrustGpuData(rhs);
    thrust::device_vector<int> deviceResult(lhs.size());

    vector<int> result;
    vector<int> durations;


    for (int i = 0; i <= 100; i++) {
        auto start = high_resolution_clock::now();  // start time

        // operation here
        deviceResult = ATC->thrustProduct(deviceLHS,deviceRHS);

        auto stop = high_resolution_clock::now(); // stop time
        auto duration = duration_cast<microseconds>(stop - start); // time taken for performing the operation
        if(i>0) {
            durations.push_back(duration.count());  // since the initial load time is high, calculation is started from 2nd iteration
        }else{
            result = ATC->getThrustCpuData(deviceResult);
        }
    }

    std::cout << "Time taken for product operation is " <<std::accumulate(durations.begin(),
                                                                          durations.end(), 0) / durations.size() << " microseconds" << std::endl;
    return result;
}

int ThrustAdapter::sum(vector<int> data) {

    thrust::device_vector<int> deviceData = ATC->getThrustGpuData(data);
    int result;

    vector<int> durations;

    for (int i = 0; i <= 100; i++) {
        auto start = high_resolution_clock::now();  // start time

        // operation here
        result = ATC->thrustSum(deviceData);

        auto stop = high_resolution_clock::now(); // stop time
        auto duration = duration_cast<microseconds>(stop - start); // time taken for performing the operation
        if(i>0) {
            durations.push_back(duration.count());  // since the initial load time is high, calculation is started from 2nd iteration
        }
    }

    std::cout << "Time taken for sum operation is " <<std::accumulate(durations.begin(),
                                                                      durations.end(),
                                                                      0) / durations.size() << " microseconds" << std::endl;
    return result;
}

vector<int> ThrustAdapter::sort(vector<int> data, int order) {

    thrust::device_vector<int> deviceData = ATC->getThrustGpuData(data);

    thrust::device_vector<int> deviceResult(data.size());

    vector<int> result;
    vector<int> durations;

    for (int i = 0; i <= 100; i++) {
        auto start = high_resolution_clock::now();  // start time

        // operation here
        deviceResult = ATC->thrustSort(deviceData,order);

        auto stop = high_resolution_clock::now(); // stop time
        auto duration = duration_cast<microseconds>(stop - start); // time taken for performing the operation
        if(i>0) {
            durations.push_back(duration.count());  // since the initial load time is high, calculation is started from 2nd iteration
        }else{
            result = ATC->getThrustCpuData(deviceResult);
        }
    }


    std::cout << "Time taken for sort operation is " <<std::accumulate(durations.begin(),
                                                                       durations.end(), 0) / durations.size() << " microseconds" << std::endl;

    return result;
}

float ThrustAdapter::avg(vector<int> data) {

    thrust::device_vector<int> deviceData = ATC->getThrustGpuData(data);
    float result;

    vector<int> durations;

    for (int i = 0; i <= 100; i++) {
        auto start = high_resolution_clock::now();  // start time

        // operation here
        result = ATC->thrustAvg(deviceData);

        auto stop = high_resolution_clock::now(); // stop time
        auto duration = duration_cast<microseconds>(stop - start); // time taken for performing the operation
        if(i>0) {
            durations.push_back(duration.count());  // since the initial load time is high, calculation is started from 2nd iteration
        }
    }

    std::cout << "Time taken for average operation is " <<std::accumulate(durations.begin(),
                                                                          durations.end(),
                                                                          0) / durations.size() << " microseconds" << std::endl;
    return result;
}

int ThrustAdapter::countIf(vector<int> data) {

    thrust::device_vector<int> deviceData = ATC->getThrustGpuData(data);
    int result;

    vector<int> durations;

    for (int i = 0; i <= 100; i++) {
        auto start = high_resolution_clock::now();  // start time

        // operation here
        result = ATC->thrustCountIf(deviceData);

        auto stop = high_resolution_clock::now(); // stop time
        auto duration = duration_cast<microseconds>(stop - start); // time taken for performing the operation
        if(i>0) {
            durations.push_back(duration.count());  // since the initial load time is high, calculation is started from 2nd iteration
        }
    }

    std::cout << "Time taken for count operation is " <<std::accumulate(durations.begin(),
                                                                        durations.end(),
                                                                        0) / durations.size() << " microseconds" << std::endl;

    return result;
}

int ThrustAdapter::count(vector<int> data) {

    thrust::device_vector<int> deviceData = ATC->getThrustGpuData(data);
    int result;

    vector<int> durations;

    for (int i = 0; i <= 100; i++) {
        auto start = high_resolution_clock::now();  // start time

        // operation here
        result = ATC->thrustCount(deviceData);

        auto stop = high_resolution_clock::now(); // stop time
        auto duration = duration_cast<microseconds>(stop - start); // time taken for performing the operation
        if(i>0) {
            durations.push_back(duration.count());  // since the initial load time is high, calculation is started from 2nd iteration
        }
    }

    std::cout << "Time taken for count operation is " <<std::accumulate(durations.begin(),
                                                                        durations.end(),
                                                                        0) / durations.size() << " microseconds" << std::endl;
    return result;
}

void ThrustAdapter::join2(vector<int> parent, vector<int> child){
    int offset = pow(2,16);

//        do Block Nested Loop Join
    int begin_R = 0, begin_S = 0;
    int end_R = begin_R + offset, end_S = begin_S + offset;

    cout << "parent size: " << parent.size() << endl;
    cout << "child size: " << child.size() << endl;

    int r_size = parent.size();
    int s_size = child.size();

    int r[r_size];
    int s[s_size];

    std::copy(parent.begin(),parent.end(),r);
    std::copy(child.begin(),child.end(),s);
    parent.clear();
    child.clear();

    int sum = 0;
    vector<int> temp_R(offset);
    vector<int> temp_S(offset);
    vector<int> durations;
    vector<int> result;
    vector<vector<int>> joinResult;

    for (int i = 0; i < 1; i++) {
        auto start = high_resolution_clock::now();  // start time

        thrust::device_vector<int> deviceResult(offset); //*offset

        for (auto&& i: parent | sliced(0, r_size/offset)){
            for(auto&& j: child | sliced(0, s_size/offset)){

                std::copy(r+begin_R,r+end_R,temp_R.begin());
                std::copy(s+begin_S,s+end_S,temp_S.begin());

                thrust::device_vector<int> deviceLHS = ATC->getThrustGpuData(temp_R);
                thrust::device_vector<int> deviceRHS = ATC->getThrustGpuData(temp_S);
//                thrust::device_vector<int> deviceResult(temp_R.size() * temp_S.size());

//                cout << "R: ( " << begin_R << " , " << end_R << ") and "
//                                                                "S: ( " << begin_S << " , " << end_S << endl;

                deviceResult = ATC->thrustJoin(deviceLHS,deviceRHS);

                result = ATC->getThrustCpuData(deviceResult);
//                sum += thrust::count(deviceResult.begin(),deviceResult.end(),1);

                vector<vector<int>> tempJoin = joinTuples(temp_R,temp_S,offset,result,i,j,offset);

                joinResult.insert(joinResult.end(),tempJoin.begin(),tempJoin.end());

                begin_S += offset;
                end_S += offset;
            }
            cout << "R: ( " << begin_R << " , " << end_R << " ) " << endl;
//            cout << "Sum: " << sum << endl;
            begin_S = 0;
            end_S = begin_S + offset;
            begin_R += offset;
            end_R += offset;
        }

        auto stop = high_resolution_clock::now(); // stop time
        auto duration = duration_cast<microseconds>(stop - start); // time taken for performing the operation
        cout << "Time taken: " << duration.count() << endl;
        if(i>0) {
            durations.push_back(duration.count());  // since the initial load time is high, calculation is started from 2nd iteration
        }
    }

    cout << "Total number of joins: " << sum;
}

vector<int> ThrustAdapter::join(vector<int> parent, vector<int> child) {
    thrust::device_vector<int> deviceLHS = ATC->getThrustGpuData(parent);
    thrust::device_vector<int> deviceRHS = ATC->getThrustGpuData(child);
//    cout<<parent.size() <<" : "<<child.size()<<" : "<<parent.size() * child.size()*sizeof(int)<<" : total allocated size"<<endl;
//    thrust::device_vector<int> deviceResult(parent.size() * child.size());

    thrust::device_vector<int> deviceResult(child.size());

    vector<int> result;
    vector<int> durations;

    int R = 0;
    int S = 0;
    int offset = 50;



//    for(auto it = deviceLHS.begin()+R; it != deviceLHS.begin()+R+offset; it++){
//        for(auto it2 = deviceRHS.begin()+S; it2 != deviceRHS.begin()+S+offset;it2++){
//
//            thrust::device_reference<int> valueLHS = *it;
//            thrust::device_reference<int> valueRHS = *it;
//
//            S = S+ offset;
//        }
//        R = R+ offset;
//    }


    for (int i = 0; i <= 100; i++) {
        auto start = high_resolution_clock::now();  // start time

        // operation here
        deviceResult = ATC->thrustJoin(deviceLHS,deviceRHS);

        auto stop = high_resolution_clock::now(); // stop time
        auto duration = duration_cast<microseconds>(stop - start); // time taken for performing the operation
        if(i>0) {
            durations.push_back(duration.count());  // since the initial load time is high, calculation is started from 2nd iteration
        }else{
            result = ATC->getThrustCpuData(deviceResult);
        }
    }

    std::cout << "Time taken for join operation is " <<std::accumulate(durations.begin(),
                                                                       durations.end(), 0) / durations.size() << " microseconds" << std::endl;
    return result;
}

vector<int> ThrustAdapter::prefixSum(vector<int> data) {
    thrust::device_vector<int> deviceData = ATC->getThrustGpuData(data);
    int count = ATC->thrustCountIf(deviceData);
    thrust::device_vector<int> deviceResult(count);

    vector<int> durations;
    vector<int> result;

    for (int i = 0; i <= 100; i++) {
        auto start = high_resolution_clock::now();  // start time

        // operation here
        deviceResult = ATC->thrustPrefixSum(deviceData);

        auto stop = high_resolution_clock::now(); // stop time
        auto duration = duration_cast<microseconds>(stop - start); // time taken for performing the operation
        if(i>0) {
            durations.push_back(duration.count());  // since the initial load time is high, calculation is started from 2nd iteration
        }else{
            result = ATC->getThrustCpuData(deviceResult);
        }
    }

    std::cout << "Time taken for prefix sum operation is " <<std::accumulate(durations.begin(),
                                                                             durations.end(),
                                                                             0) / durations.size() << " microseconds" << std::endl;

    return result;
}

int ThrustAdapter::findMax(vector<int> data) {

    thrust::device_vector<int> deviceData = ATC->getThrustGpuData(data);
    int result;

    vector<int> durations;

    for (int i = 0; i <= 100; i++) {
        auto start = high_resolution_clock::now();  // start time

        // operation here
        result = ATC->thrustFindMax(deviceData);

        auto stop = high_resolution_clock::now(); // stop time
        auto duration = duration_cast<microseconds>(stop - start); // time taken for performing the operation
        if(i>0) {
            durations.push_back(duration.count());  // since the initial load time is high, calculation is started from 2nd iteration
        }
    }

    std::cout << "Time taken for findMax operation is " <<std::accumulate(durations.begin(),
                                                                          durations.end(),
                                                                          0) / durations.size() << " microseconds" << std::endl;
    return result;
}

int ThrustAdapter::findMin(vector<int> data) {

    thrust::device_vector<int> deviceData = ATC->getThrustGpuData(data);
    int result;

    vector<int> durations;

    for (int i = 0; i <= 100; i++) {
        auto start = high_resolution_clock::now();  // start time

        // operation here
        result = ATC->thrustFindMin(deviceData);

        auto stop = high_resolution_clock::now(); // stop time
        auto duration = duration_cast<microseconds>(stop - start); // time taken for performing the operation
        if(i>0) {
            durations.push_back(duration.count());  // since the initial load time is high, calculation is started from 2nd iteration
        }
    }

    std::cout << "Time taken for findMin operation is " <<std::accumulate(durations.begin(),
                                                                          durations.end(),
                                                                          0) / durations.size() << " microseconds" << std::endl;
    return result;
}