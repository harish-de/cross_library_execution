#include <vector>
#include <string>
#include <iostream>
#include <list>

#include <thrust/host_vector.h>
#include <thrust/device_vector.h>


using namespace std;
//#include "ThrustCompute.cu"

//class Compute: public AbstractCompute{
//public:
//    void selection(){
//        cout << "No implementation here";
//    }
//};
//#include "Adapter.cpp"

#include "Adapter.h"
#include "ThrustCompute.cu"


int main(){

    ThrustCompute *TC = new ThrustCompute();
    AbstractCompute *ada = new Adapter(TC);


    std::vector<int> l_shipdate;
    l_shipdate.push_back(19940302);
    l_shipdate.push_back(19930202);
    l_shipdate.push_back(19940202);
    l_shipdate.push_back(19930202);
    l_shipdate.push_back(19940202);

    std::vector<int> l_traindate;
    l_traindate.push_back(19940302);
    l_traindate.push_back(19910202);
    l_traindate.push_back(19940302);
    l_traindate.push_back(19970202);
    l_traindate.push_back(19940202);


    int value = 19940101;
    std::string op = "GE";

    ada->selection(l_shipdate,op,value);
    ada->setUnion(l_shipdate,l_traindate);
    ada->setIntersection(l_shipdate,l_traindate);
    ada->setDifference(l_shipdate,l_traindate);
    ada->sort(l_shipdate,0);
    ada->sum(l_shipdate);
    ada->findMax(l_shipdate);
}