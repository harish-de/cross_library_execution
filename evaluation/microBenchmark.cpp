//
// Created by hkumar on 20.01.21.
//
#pragma once
#include "microBenchmark.h"
#include "../BoostOperations/BoostComputeOps.h"
#include "../BoostOperations/BoostAdapter.h"

void evalOperators::evaluateFilter(BaseCompute *adapter) {
//    cout << "Filter" << endl;
    std::vector<int> data(datasize);
    std::iota(data.begin(),data.end(),0);

    // selectivity factor
    for(float i = 1; i <= 100; i++){
        adapter->filter(data,"LE",(int)((i/100.00)*datasize));
    }
}

void evalOperators::evalGroupBy(BaseCompute *adapter,int percent) {
//    cout << "count by key" << endl;
//    for(float i =0;i<=100; i++) {
        int pos1 = (int)((percent/100.00)*datasize);
        unsigned int *agg_input = (unsigned int*) calloc(datasize, sizeof(unsigned int));
	    generate_uniform_random(agg_input, datasize, pos1);
	    vector<int>data(agg_input,agg_input+datasize);
        adapter->countByKey(data);
        data.clear();
//    }
}

void evalOperators::evalJoin(BaseCompute *adapter, int percent) {
    
    cout << "Percent: " << percent << endl;
    for(short i=1;i<20;i++){
    size_t Rsize =pow(2,i);
    vector<int> R(Rsize);//1500000
    std::iota(std::begin(R),std::end(R),1);//Fills R table with 16M values all unique

    vector<int> S(datasize);
        cout<<Rsize<<"\t";
         int pos1 = (int)((percent/100.00)*datasize);
         std::fill(S.begin(),S.begin()+pos1,1);
         std::iota(S.begin()+pos1,S.end(),Rsize+1);
         std::random_shuffle(S.begin(),S.end());
         adapter->join(R,S);
         cout<<endl;
     }
}


void evalOperators::evalScatterGather(BaseCompute *adapter) {

//    unsigned int *Data;
    vector<int> map(datasize);
    vector<int> data(datasize);
    std::iota(data.begin(),data.end(),0);

    std::iota(map.begin(),map.end(),0);
    std::random_shuffle(map.begin(),map.end());

    adapter->scatter(data,map);
    adapter->gather(data,map);

//    std::iota(map.begin(),map.end(),0);
//    std::transform(map.begin(),map.end(),map.begin(),[=] (const int x) {
//        return ((unsigned long)((unsigned int)1300000077*x)* (unsigned int)pow(2,29))>>32;
//    });
//    adapter->scatter(data,map);
//    adapter->gather(data,map);

    //Test "unique random input" with data between 0 to 2^28. This will prepare input between 0 to 2^28 but not in sequntial order but in random.
    //Doing scatter and gather of these values will help in identifying their performance
    //prepare uniform random input and using the input value, find their corresponding slot using below 2 hashing functions
        // Multiplicative hashing --> ((unsigned long)((unsigned int)1300000077*key)* HSIZE)>>32 <-- this function gives the hash slot
        /* Murmur hashing --> ^ is bitwise XOR operation
            uint64_t murmur3_64_finalizer(uint64_t key) {

                key ˆ= key >> 33;
                key*= 0xff51afd7ed558ccd;
                key ˆ= key >> 33;
                key*= 0xc4ceb9fe1a85ec53;
                key ˆ= key >> 33;
                return key;
            } */
}


void evalOperators::evalTransferTime(BaseCompute *adapter) {
    for(int i = 19; i <= 30; i++){
        vector<int> vecData(pow(2,i));
        std::iota(vecData.begin(),vecData.end(),0);
//        cout << "Executing scale factor: 2 power " << i << " : "<< endl;
//        adapter->cpu2gpu(vecData);
        adapter->gpu2cpu(vecData);
        vecData.clear();
        vecData.shrink_to_fit();
    }
}

void evalOperators::callOperators(int percent) {
    typedef list<BaseCompute*> libraryList;
    libraryList libraries;

//  Add libraries here
    libraries.push_back(new ThrustAdapter(new ThrustCompute));
    libraries.push_back(new BoostAdapter(new BoostCompute));
//    libraries.push_back(new afAdapter(new afCompute));

    int count = 0;
    for(auto object : libraries) {
        cout
//        << "**** \n Library "
        << to_string(count)
//        << " starts \n ****"
        <<"\t";
//        << endl;

//         evalTransferTime(object);

        evalJoin(object,percent);
//        evaluateFilter(object);
//        evalGroupBy(object,percent);
//        evalScatterGather(object);
        count++;
    }
    cout<<endl;
}
