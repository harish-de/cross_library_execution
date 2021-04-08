//
// Created by hkumar on 26.08.20.
//

#include <numeric>
#include "ThrustComputeOps.cuh"

//int iteration = 100;

thrust::device_vector<int> ThrustCompute::getThrustGpuData(vector<int> data) {
    thrust::device_vector<int> deviceData(data.size());
//    auto start = high_resolution_clock::now();  // start time
//    for (int i = 0; i < iteration; i++) {
    thrust::host_vector<int> hostData(data);
    deviceData = hostData;
//    }
//
//    auto stop = high_resolution_clock::now(); // stop time
//    auto duration = duration_cast<nanoseconds>(stop - start);
//    cout << duration.count()/iteration << endl;

//    return dummy;
    return deviceData;
}

thrust::device_vector<int> ThrustCompute::thrustcpu2gpu(vector<int> data) {
    thrust::device_vector<int> deviceData(data.size());

    auto start = high_resolution_clock::now();  // start time
    for (int i = 0; i < iteration; i++) {
        thrust::host_vector<int> hostData(data);
        deviceData = hostData;
    }

    auto stop = high_resolution_clock::now(); // stop time
    auto duration = duration_cast<nanoseconds>(stop - start);
    cout << duration.count()/iteration << "\t";

    return deviceData;
}

vector<int> ThrustCompute::getThrustCpuData(thrust::device_vector<int> d_data) {
    vector<int> h_data(d_data.size());

//    auto start = high_resolution_clock::now();  // start time
//    for (int i = 0; i < iteration; i++) {
    thrust::copy(d_data.begin(),d_data.end(),h_data.begin());
//    }
//    auto stop = high_resolution_clock::now(); // stop time
//    auto duration = duration_cast<nanoseconds>(stop - start); // time taken for performing the operation
//
//    std::cout << duration.count()/iteration <<  std::endl;
    return h_data;
}

vector<int> ThrustCompute::thrustgpu2cpu(thrust::device_vector<int> d_data) {

    vector<int> h_data(d_data.size());

    auto start = high_resolution_clock::now();  // start time
    for (int i = 0; i < iteration; i++) {
        thrust::copy(d_data.begin(),d_data.end(),h_data.begin());
    }
    auto stop = high_resolution_clock::now(); // stop time
    auto duration = duration_cast<nanoseconds>(stop - start); // time taken for performing the operation

    std::cout << duration.count()/iteration <<  std::endl;
    return h_data;
}

vector<float> ThrustCompute::getThrustCpuData(thrust::device_vector<float> d_data) {
    vector<float> h_data(d_data.size());
    thrust::copy(d_data.begin(),d_data.end(),h_data.begin());
    return h_data;
}

thrust::device_vector<int> ThrustCompute::thrustIN(thrust::device_vector<int> dataToFilter,
                                                   thrust::device_vector<int> refData,
                                                   thrust::device_vector<int> prefixSum){

    const int *m_data = thrust::raw_pointer_cast(dataToFilter.data());
    const int *m_ref = thrust::raw_pointer_cast(refData.data());
    const int *m_ps = thrust::raw_pointer_cast(prefixSum.data());
    std::size_t ps_size = prefixSum.size();

    thrust::device_vector<int> deviceResult(dataToFilter.size());
    int *m_result = thrust::raw_pointer_cast(deviceResult.data());

//    thrust::transform(dataToFilter.begin(),dataToFilter.end(),deviceResult.begin(),[=] __device__ (const int x){
//        for(int i = 0; i < ps_size; i++){
//            if(x == m_ref[i]){
//                return 1;
//            }
//        }
//    });

    thrust::for_each_n(thrust::counting_iterator<int>(0),dataToFilter.size(),[=] __device__ (const std::size_t x){
        for(int i = 0; i < ps_size; i++){
            if(m_data[x] == m_ref[m_ps[i]]){
                m_result[x] = 1;
            }
        }
    });
    return deviceResult;
}

thrust::device_vector<int> ThrustCompute::thrustSelection(thrust::device_vector<int> deviceData, string operation, int value){

    thrust::device_vector<int> device_result(deviceData.size());

    if(!operation.compare("GE")) {
        auto start = high_resolution_clock::now();
        for (int i = 0; i <= iteration; i++) {
            thrust::transform(thrust::device,deviceData.begin(),deviceData.end(),device_result.begin(),[=] __device__(const int x) {
                return (x >= value);
            });
        }
        auto stop = high_resolution_clock::now(); // stop time
        auto duration = duration_cast<nanoseconds>(stop - start);
        std::cout << "selection: " << duration.count()/iteration << endl;
    }
    else if(!operation.compare("LE")) {
        auto start = high_resolution_clock::now();
        for (int i = 0; i <= iteration; i++) {
            thrust::transform(thrust::device, deviceData.begin(), deviceData.end(), device_result.begin(),
                              [=] __device__(const int x) {
                                  return (x <= value);
                              });
        }
        auto stop = high_resolution_clock::now(); // stop time
        auto duration = duration_cast<nanoseconds>(stop - start);
        std::cout << "selection: " << duration.count()/iteration << endl;
    }
    else if(!operation.compare("G")) {
        auto start = high_resolution_clock::now();
        for (int i = 0; i <= iteration; i++) {
            thrust::transform(thrust::device,deviceData.begin(),deviceData.end(),device_result.begin(),[=] __device__(const int x) {
                return (x > value);
            });
        }
        auto stop = high_resolution_clock::now(); // stop time
        auto duration = duration_cast<nanoseconds>(stop - start);
        std::cout << "selection: " << duration.count()/iteration << endl;
    }
    else if(!operation.compare("L")) {
        auto start = high_resolution_clock::now();
        for (int i = 0; i <= iteration; i++) {
            thrust::transform(thrust::device,deviceData.begin(),deviceData.end(),device_result.begin(),[=] __device__(const int x) {
                return (x < value);
            });
        }
        auto stop = high_resolution_clock::now(); // stop time
        auto duration = duration_cast<nanoseconds>(stop - start);
        std::cout << "selection: " << duration.count()/iteration << endl;

    }
    else if(!operation.compare("EQ")) {
        auto start = high_resolution_clock::now();
        for (int i = 0; i <= iteration; i++) {
            thrust::transform(thrust::device,deviceData.begin(),deviceData.end(),device_result.begin(),[=] __device__(const int x) {
                return (x == value);
            });
        }
        auto stop = high_resolution_clock::now(); // stop time
        auto duration = duration_cast<nanoseconds>(stop - start);
        std::cout << "selection: " << duration.count()/iteration << endl;
    }
    else{
        auto start = high_resolution_clock::now();
        for (int i = 0; i <= iteration; i++) {
            thrust::transform(thrust::device,deviceData.begin(),deviceData.end(),device_result.begin(),[=] __device__(const int x) {
                return (x != value);
            });
        }
        auto stop = high_resolution_clock::now(); // stop time
        auto duration = duration_cast<nanoseconds>(stop - start);
        std::cout << "selection: " << duration.count()/iteration << endl;
    }

    cout << "Finished Thrust selection" << endl;
    return device_result;
}


thrust::device_vector<int> ThrustCompute::thrustFilter(thrust::device_vector<int> deviceData, string operation, int value){

    thrust::device_vector<int> device_result(deviceData.size());

    // filtering
    auto start = high_resolution_clock::now();
    for (int i = 0; i <= iteration; i++) {
        thrust::transform(thrust::device, deviceData.begin(), deviceData.end(), device_result.begin(),
                          [=] __device__(const int x) {
                              return (x <= value);
                          });
    }
    auto stop = high_resolution_clock::now(); // stop time
    auto duration = duration_cast<nanoseconds>(stop - start);
    std::cout << duration.count()/iteration << "\t";

    // prefix-sum
    start = high_resolution_clock::now();
    for (int i = 0; i <= iteration; i++) {
        thrust::device_vector<int> dataIndex(device_result.size());
        thrust::sequence(dataIndex.begin(), dataIndex.end(), 0);

        thrust::device_vector<int> ps(device_result.size());
        thrust::exclusive_scan(device_result.begin(), device_result.end(), ps.begin(), 0); // prefix sum result
    }
    stop = high_resolution_clock::now(); // stop time
    duration = duration_cast<nanoseconds>(stop - start);
    std::cout << duration.count()/iteration << "\t";

    thrust::device_vector<int> dataIndex(device_result.size());
    thrust::sequence(dataIndex.begin(), dataIndex.end(), 0);
    thrust::device_vector<int> ps(device_result.size());
    thrust::exclusive_scan(device_result.begin(), device_result.end(), ps.begin(), 0); // prefix sum result

    // scattering
    start = high_resolution_clock::now();
    for (int i = 0; i <= iteration; i++) {
        int size = thrust::count(device_result.begin(), device_result.end(), 1);
        thrust::device_vector<int> ps_result(size);
        thrust::scatter_if(dataIndex.begin(), dataIndex.end(), ps.begin(), device_result.begin(), ps_result.begin());
    }
    stop = high_resolution_clock::now(); // stop time
    duration = duration_cast<nanoseconds>(stop - start);
    std::cout << duration.count()/iteration << endl;

    int size = thrust::count(device_result.begin(), device_result.end(), 1);
    thrust::device_vector<int> ps_result(size);
    thrust::scatter_if(dataIndex.begin(), dataIndex.end(), ps.begin(), device_result.begin(), ps_result.begin());

    return ps_result;
}


thrust::device_vector<int> ThrustCompute::thrustSelectionArrays(thrust::device_vector<int> deviceLHS, string operation,
                                                                thrust::device_vector<int> deviceRHS) {

    thrust::device_vector<int> result_dev(deviceLHS.size());


    size_t v1size = deviceLHS.size();
    const int *m_vec1 = thrust::raw_pointer_cast(deviceLHS.data());
    const int *m_vec2 = thrust::raw_pointer_cast(deviceRHS.data());
    int *m_result = thrust::raw_pointer_cast(result_dev.data());


    if(!operation.compare("GE")) {
        auto start = high_resolution_clock::now();
        for (int i = 0; i <= iteration; i++) {
            thrust::for_each_n( thrust::device,
                                thrust::counting_iterator<size_t>(0),
                                (v1size),
                                [=] __device__ (const std::size_t x){
                                    m_result[x] = (m_vec1[x] >= m_vec2[x]);
                                });
        }

        auto stop = high_resolution_clock::now(); // stop time
        auto duration = duration_cast<nanoseconds>(stop - start);
        std::cout << "selection_arrays: " << duration.count()/iteration << endl;
    }

    else if(!operation.compare("LE")) {
        auto start = high_resolution_clock::now();
        for (int i = 0; i <= iteration; i++) {
        thrust::for_each_n( thrust::device,
                            thrust::counting_iterator<size_t>(0),
                            (v1size),
                            [=] __device__ (const std::size_t x){
                                m_result[x] = (m_vec1[x] <= m_vec2[x]);
                            });
        }
        auto stop = high_resolution_clock::now(); // stop time
        auto duration = duration_cast<nanoseconds>(stop - start);
        std::cout << "selection_arrays: " << duration.count()/iteration << endl;

    }

    else if(!operation.compare("G")) {
        auto start = high_resolution_clock::now();
        for (int i = 0; i <= iteration; i++) {
        thrust::for_each_n( thrust::device,
                            thrust::counting_iterator<size_t>(0),
                            (v1size),
                            [=] __device__ (const std::size_t x){
                                m_result[x] = (m_vec1[x] > m_vec2[x]);
                            });
        }
        auto stop = high_resolution_clock::now(); // stop time
        auto duration = duration_cast<nanoseconds>(stop - start);
        std::cout << "selection_arrays: " << duration.count()/iteration << endl;

    }

    else if(!operation.compare("L")) {
        auto start = high_resolution_clock::now();
        for (int i = 0; i <= iteration; i++) {
        thrust::for_each_n( thrust::device,
                            thrust::counting_iterator<size_t>(0),
                            (v1size),
                            [=] __device__ (const std::size_t x){
                                m_result[x] = (m_vec1[x] < m_vec2[x]);
                            });
        }
        auto stop = high_resolution_clock::now(); // stop time
        auto duration = duration_cast<nanoseconds>(stop - start);
        std::cout << "selection_arrays: " << duration.count()/iteration << endl;

    }

    else if(!operation.compare("EQ")) {
        auto start = high_resolution_clock::now();
        for (int i = 0; i <= iteration; i++) {
        thrust::for_each_n( thrust::device,
                            thrust::counting_iterator<size_t>(0),
                            (v1size),
                            [=] __device__ (const std::size_t x){
                                m_result[x] = (m_vec1[x] == m_vec2[x]);
                            });
        }
        auto stop = high_resolution_clock::now(); // stop time
        auto duration = duration_cast<nanoseconds>(stop - start);
        std::cout << "selection_arrays: " << duration.count()/iteration << endl;
    }

    else{
        auto start = high_resolution_clock::now();
        for (int i = 0; i <= iteration; i++) {
        thrust::for_each_n( thrust::device,
                            thrust::counting_iterator<size_t>(0),
                            (v1size),
                            [=] __device__ (const std::size_t x){
                                m_result[x] = (m_vec1[x] != m_vec2[x]);
                            });
        }
        auto stop = high_resolution_clock::now(); // stop time
        auto duration = duration_cast<nanoseconds>(stop - start);
        std::cout << "selection_arrays: " << duration.count()/iteration << endl;
    }

    return result_dev;
}

thrust::device_vector<int> ThrustCompute::thrustConjunction(thrust::device_vector<int> deviceLHS,thrust::device_vector<int> deviceRHS) {

    thrust::device_vector<int> device_result(deviceLHS.size());
    auto start = high_resolution_clock::now();
    for (int i = 0; i <= iteration; i++) {
        thrust::transform(deviceLHS.begin(), deviceLHS.end(), deviceRHS.begin(), device_result.begin(),
                          thrust::bit_and<int>());
    }
    auto stop = high_resolution_clock::now(); // stop time
    auto duration = duration_cast<nanoseconds>(stop - start);
    std::cout << "conjunction: " << duration.count()/iteration << endl;

    return device_result;
}

thrust::device_vector<int> ThrustCompute::thrustSort(thrust::device_vector<int> deviceData, int order){
    auto start = high_resolution_clock::now();
    for (int i = 0; i <= iteration; i++) {
        if(order){
            thrust::sort(thrust::device, deviceData.begin(),deviceData.end(),thrust::greater<int>());
        }else{
            thrust::sort(deviceData.begin(),deviceData.end());
        }
    }
    auto stop = high_resolution_clock::now(); // stop time
    auto duration = duration_cast<nanoseconds>(stop - start);
    std::cout << "sort: " << duration.count()/iteration << endl;
    return deviceData;
}

thrust::device_vector<int> ThrustCompute::thrustSortByKey(thrust::device_vector<int> deviceData,
                                                          thrust::device_vector<int> dependentData,
                                                          int order) {
    auto start = high_resolution_clock::now();
    for (int i = 0; i <= iteration; i++) {
        if(order) {
            thrust::sort_by_key(deviceData.begin(), deviceData.end(), dependentData.begin(), thrust::greater<int>());
        }else{
            thrust::sort_by_key(deviceData.begin(), deviceData.end(), dependentData.begin());
        }
    }

    auto stop = high_resolution_clock::now(); // stop time
    auto duration = duration_cast<nanoseconds>(stop - start);
    std::cout << "sortbykey: " << duration.count()/iteration << endl;

    return dependentData;
}

thrust::device_vector<int> ThrustCompute::thrustProduct(thrust::device_vector<int> deviceLHS, thrust::device_vector<int> deviceRHS){
    thrust::device_vector<int> device_result(deviceLHS.size());
    auto start = high_resolution_clock::now();
    for (int i = 0; i <= iteration; i++) {
        thrust::transform(deviceLHS.begin(),deviceLHS.end(),deviceRHS.begin(),device_result.begin(),thrust::multiplies<int>());
    }
    auto stop = high_resolution_clock::now(); // stop time
    auto duration = duration_cast<nanoseconds>(stop - start);

    std::cout << "product: " << duration.count()/iteration << endl;

    return device_result;
}

int ThrustCompute::thrustSum(thrust::device_vector<int> deviceData) {
    auto start = high_resolution_clock::now();
    for (int i = 0; i <= iteration; i++) {
        int result = thrust::reduce(deviceData.begin(),deviceData.end(),0);
    }
    auto stop = high_resolution_clock::now(); // stop time
    auto duration = duration_cast<nanoseconds>(stop - start);
    std::cout << "Sum: " << duration.count()/iteration << endl;

    int result = thrust::reduce(deviceData.begin(),deviceData.end(),0);
    return result;
}

float ThrustCompute::thrustAvg(thrust::device_vector<int> deviceData) {

    int total = thrust::reduce(deviceData.begin(),deviceData.end(),0);
    float result = (float)total/deviceData.size();
    return result;
}

int ThrustCompute::thrustCountIf(thrust::device_vector<int> deviceData,int value) {
    // counting number of 1s is enough here
    return thrust::count(deviceData.begin(),deviceData.end(),value);
}

int ThrustCompute::thrustCount(thrust::device_vector<int> deviceData) {
    return deviceData.size();
}

thrust::device_vector<int> ThrustCompute::thrustJoin(thrust::device_vector<int> vec1_dev, thrust::device_vector<int> vec2_dev) {



    thrust::device_vector<int> result_find(vec2_dev.size());
    size_t v1size = vec1_dev.size();
    const int *m_vec1 = thrust::raw_pointer_cast(vec1_dev.data());
    const int *m_vec2 = thrust::raw_pointer_cast(vec2_dev.data());
    int *m_result = thrust::raw_pointer_cast(result_find.data());
    thrust::counting_iterator<int> first(0);
//    for (int i = 0; i < iteration; i++) {
// thrust::counting_iterator<size_t>(0)

    auto start = high_resolution_clock::now();
    thrust::for_each(thrust::device,first,first + vec2_dev.size(), [=] __device__(const int x) {
        for (int i = 0; i < v1size; i++) {
            if (m_vec2[x] == m_vec1[i]) {
                m_result[x] = i;
                return;
            }
        }
    });
//    }
    auto stop = high_resolution_clock::now(); // stop time
    auto duration = duration_cast<nanoseconds>(stop - start);
    cout << "join: " << duration.count()/iteration << endl;

    return result_find;
}

thrust::device_vector<int> ThrustCompute::thrustPrefixSum(thrust::device_vector<int> deviceSelData) {

    auto start = high_resolution_clock::now();
    for (int i = 0; i <= iteration; i++) {
        thrust::device_vector<int> dataIndex(deviceSelData.size());
        thrust::sequence(dataIndex.begin(),dataIndex.end(),0);

        thrust::device_vector<int> ps(deviceSelData.size());
        thrust::exclusive_scan(deviceSelData.begin(),deviceSelData.end(),ps.begin(),0); // prefix sum result

        int size = thrust::count(deviceSelData.begin(),deviceSelData.end(),1);
        thrust::device_vector<int> device_result(size);

        thrust::scatter_if(dataIndex.begin(),dataIndex.end(),ps.begin(),deviceSelData.begin(),device_result.begin());
    }

    auto stop = high_resolution_clock::now(); // stop time
    auto duration = duration_cast<nanoseconds>(stop - start);
    std::cout << "Prefix-Sum: " << duration.count()/iteration << endl;


    thrust::device_vector<int> dataIndex(deviceSelData.size());
    thrust::sequence(dataIndex.begin(),dataIndex.end(),0);

    thrust::device_vector<int> ps(deviceSelData.size());
    thrust::exclusive_scan(deviceSelData.begin(),deviceSelData.end(),ps.begin(),0); // prefix sum result

    int size = thrust::count(deviceSelData.begin(),deviceSelData.end(),1);
    thrust::device_vector<int> device_result(size);

    thrust::scatter_if(dataIndex.begin(),dataIndex.end(),ps.begin(),deviceSelData.begin(),device_result.begin());

    return device_result;
}

thrust::device_vector<int> ThrustCompute::thrustPrefixSum(thrust::device_vector<int> deviceSelData,
                                                          thrust::device_vector<int> data) {

    thrust::device_vector<int> ps(deviceSelData.size());
    thrust::exclusive_scan(deviceSelData.begin(),deviceSelData.end(),ps.begin()); // prefix sum result
//
    int size = ps.back();
    thrust::device_vector<int> device_result(size);

    thrust::scatter_if(data.begin(),data.end(),ps.begin(),deviceSelData.begin(),device_result.begin());

    return device_result;
}

int ThrustCompute::thrustFindMax(thrust::device_vector<int> data){
    thrust::device_vector<int>::iterator it = thrust::max_element(data.begin(),data.end());
    int index = thrust::distance(data.begin(),it);
    return data[index];
}

int ThrustCompute::thrustFindMin(thrust::device_vector<int> data){
//    return thrust::reduce(thrust::device,data.begin(),data.end(),-1,thrust::maximum<int>());
    thrust::device_vector<int>::iterator it = thrust::min_element(data.begin(),data.end());
    int index = thrust::distance(data.begin(),it);
    return data[index];
}

thrust::device_vector<int> ThrustCompute::thrustGroupBy(thrust::device_vector<int> keys,
                                                        thrust::device_vector<int> values) {

    thrust::device_vector<int> temp = keys;
    auto last = thrust::unique(temp.begin(),temp.end());
    temp.erase(last, temp.end());
    int size = temp.size();

    thrust::device_vector<int> oKeys(size); //previous size here: keys.size()
    thrust::device_vector<int> oVals(size); //previous size here: values.size()

    auto start = high_resolution_clock::now();
    for (int i = 0; i <= iteration; i++) {
        thrust::reduce_by_key(keys.begin(), keys.end(), values.begin(), oKeys.begin(), oVals.begin());
    }
    auto stop = high_resolution_clock::now(); // stop time
    auto duration = duration_cast<nanoseconds>(stop - start);
    std::cout << "sumbykey: " << duration.count()/iteration << endl;
    return oVals;
}

thrust::device_vector<int> ThrustCompute::thrustHashJoin(thrust::device_vector<int> parent, thrust::device_vector<int> child) {

    thrust::device_vector<int> hashParent(parent.size());   // build hash table
    thrust::device_vector<int> moduloParent(parent.size()); // hash function

    thrust::fill(moduloParent.begin(), moduloParent.end(), parent.size());

    // build table done - works only for unique column values
    thrust::transform(parent.begin(),parent.end(),moduloParent.begin(),hashParent.begin(),thrust::modulus<int>());

    thrust::device_vector<int> moduloChild(child.size());
    thrust::fill(moduloChild.begin(),moduloChild.end(),parent.size());

    thrust::device_vector<int> hashChild(child.size());

    //probe table
    thrust::transform(child.begin(),child.end(),moduloChild.begin(),hashChild.begin(),thrust::modulus<int>());

    return hashChild;
}

thrust::device_vector<int> ThrustCompute::thrustCountByKey(thrust::device_vector<int> data) {

//    thrust::device_vector<int> data1 = thrustSort(data,0);
//    thrust::device_vector<int> temp1 = data1;
//    auto last1 = thrust::unique(temp1.begin(), temp1.end());
//    temp1.erase(last1, temp1.end());
//    int size1 = temp1.size();

//    thrust::device_vector<int> Dummy(10);

//    auto start1 = high_resolution_clock::now();
//    for (int i = 0; i < iteration; i++) {
//        data = thrustSort(data,0);
//    }
//    auto stop1 = high_resolution_clock::now(); // stop time
//    auto duration1 = duration_cast<nanoseconds>(stop1 - start1);



    thrust::device_vector<int> temp = data;
    auto last = thrust::unique(temp.begin(), temp.end());
    temp.erase(last, temp.end());
    int size = temp.size();

    thrust::device_vector<int> C(size); //previous size here: data.size()
    thrust::device_vector<int> D(size); //previous size here: data.size()

    auto start = high_resolution_clock::now();
    for (int i = 0; i < iteration; i++) {

        thrust::reduce_by_key(data.begin(), data.end(), thrust::make_constant_iterator(1), C.begin(), D.begin(),
                              thrust::equal_to<int>(), thrust::plus<int>());


    }
    auto stop = high_resolution_clock::now(); // stop time
    auto duration = duration_cast<nanoseconds>(stop - start);

    cout << "countByKey: " << duration.count()/iteration<<"\t";
    return D;
}

struct sum_and_count
{
    template <typename Tuple>
    __host__ __device__
    Tuple operator()(const Tuple& a, const Tuple& b) const
    {
        return Tuple(thrust::get<0>(a) + thrust::get<0>(b),
                     thrust::get<1>(a) + thrust::get<1>(b));
    }
};

thrust::device_vector<float> ThrustCompute::thrustAvgByKey(thrust::device_vector<int> k,
                                                           thrust::device_vector<int> v) {

    thrust::device_vector<int> temp = k;

    auto last = thrust::unique(temp.begin(),temp.end());
    temp.erase(last, temp.end());

    int size = temp.size();

    thrust::device_vector<int> keys(size);
    thrust::device_vector<int> sums(size);
    thrust::device_vector<int> counts(size);
    thrust::device_vector<float> result(size);

    auto start = high_resolution_clock::now();
    for (int i = 0; i <= iteration; i++) {
        thrust::reduce_by_key
                (k.begin(), k.end(),
                 thrust::make_zip_iterator(thrust::make_tuple(v.begin(), thrust::constant_iterator<int>(1))),
                 keys.begin(),
                 thrust::make_zip_iterator(thrust::make_tuple(sums.begin(), counts.begin())),
                 thrust::equal_to<int>(),
                 sum_and_count());

        vector<int> h_sums = getThrustCpuData(sums);
        vector<int> h_count = getThrustCpuData(counts);

        thrust::transform(sums.begin(), sums.end(), counts.begin(), result.begin(),
                          thrust::divides<float>());
    }

    auto stop = high_resolution_clock::now(); // stop time
    auto duration = duration_cast<nanoseconds>(stop - start);

    std::cout << "avgByKey: " << duration.count()/iteration << endl;


    return result;
}


thrust::device_vector<int> ThrustCompute::thrustSumOfVectors(thrust::device_vector<int> array1,
                                                             thrust::device_vector<int> array2) {

    thrust::device_vector<int> deviceResult(array1.size());

    const int *m_vec1 = thrust::raw_pointer_cast(array1.data());
    const int *m_vec2 = thrust::raw_pointer_cast(array2.data());

    int *m_result = thrust::raw_pointer_cast(deviceResult.data());
    auto start = high_resolution_clock::now();
    for (int i = 0; i <= iteration; i++) {
        thrust::for_each_n(thrust::counting_iterator<int>(0),array1.size(),[=] __device__ (const std::size_t x){
            m_result[x] = m_vec1[x] + m_vec2[x];
        });
    }
    auto stop = high_resolution_clock::now(); // stop time
    auto duration = duration_cast<nanoseconds>(stop - start);

    std::cout << "grouping: " << duration.count()/iteration << endl;

    return deviceResult;
}

void ThrustCompute::thrustScatter(thrust::device_vector<int> data, thrust::device_vector<int> map) {

    auto start = high_resolution_clock::now();
    for (int i = 0; i < iteration; i++) {
        thrust::device_vector<int> output(data.size());

        thrust::scatter( data.begin(), data.end(),
                         map.begin(), output.begin());
    }

    auto stop = high_resolution_clock::now(); // stop time
    auto duration = duration_cast<nanoseconds>(stop - start);

    cout << "ThrustScatter:  " <<  duration.count()/iteration << endl;
}

void ThrustCompute::thrustGather(thrust::device_vector<int> data, thrust::device_vector<int> map) {

    auto start = high_resolution_clock::now();
    for (int i = 0; i < iteration; i++) {

        thrust::device_vector<int> output(data.size());

        thrust::gather(map.begin(), map.end(),
                       data.begin(),
                       output.begin());

    }
    auto stop = high_resolution_clock::now();
    auto duration = duration_cast<nanoseconds>(stop - start);

    cout << "ThrustGather:  " << duration.count()/iteration << endl;
}
