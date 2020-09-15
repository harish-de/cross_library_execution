//
// Created by hkumar on 26.08.20.
//

#pragma once
#include "executeQueries.h"
#include <vector>
#include <list>
//#include "../ThrustOperations/ThrustComputeOps.cuh"
#include "../ThrustOperations/ThrustAdapter.cuh"
//#include "../BoostOperations/BoostComputeOps.h"
#include "../BoostOperations/BoostAdapter.h"
#include "../ArrayFireOperations/ArrayFireAdapter.cuh"

using namespace std;

void executeTpchQueries::executeQ1(BaseCompute *adapter) {

    vector<vector<int>> lineitemData = adapter->readLineItem();
    vector<vector<int>>transposedVec = adapter->getTransposedVector(lineitemData);

    vector<int> result_1;
    vector<int> ps_res1;

    vector<int> result_2;
    vector<int> ps_res2;

    vector<int> conjunction;
    int sum_quantity;
    int sum_extended_price;
    vector<int> prod_ep_disc;
    vector<int> prod_ep_disc_tax;
    int sum_prod_ep_disc;
    int sum_prod_ep_disc_tax;
    float avg_qty;
    float avg_extended_price;
    float avg_discount;
    int count;

    /*
     * l_shipdate >= date '1998-09-01' [becuase DELTA is 90 in l_shipdate <= date '1998-12-01' -interval '[DELTA]' day (3)]
     */
    result_1 = adapter->selection(transposedVec[8], "GE", 19980901);
    ps_res1 = adapter->prefixSum(result_1);
    lineitemData = adapter->deleteTuples(lineitemData,ps_res1);
    transposedVec = adapter->getTransposedVector(lineitemData);

    /*
     * l_shipdate <= date '1998-12-01'
     */
    result_2 = adapter->selection(transposedVec[8], "LE", 19981201);
    ps_res2 = adapter->prefixSum(result_2);
    lineitemData = adapter->deleteTuples(lineitemData,ps_res2);
    transposedVec = adapter->getTransposedVector(lineitemData);

    /*
     * sum(l_quantity) as sum_qty,
     * sum(l_extendedprice) assum_base_price
     */
    sum_quantity = adapter->sum(transposedVec[4]);
    sum_extended_price = adapter->sum(transposedVec[5]);

    /*
     * sum(l_extendedprice*(1-l_discount)) as sum_disc_price,
     * sum(l_extendedprice*(1-l_discount)*(1+l_tax)) as sum_charge,
     */
    prod_ep_disc = adapter->product(transposedVec[5],transposedVec[6]);
    prod_ep_disc_tax = adapter->product(prod_ep_disc,transposedVec[7]);
    sum_prod_ep_disc = adapter->sum(prod_ep_disc);
    sum_prod_ep_disc_tax = adapter->sum(prod_ep_disc_tax);

    /*
     * avg(l_quantity) as avg_qty,
     * avg(l_extendedprice) as avg_price,
     * avg(l_discount) as avg_disc,
     */

    avg_qty = adapter->avg(transposedVec[4]);
    avg_extended_price = adapter->avg(transposedVec[5]);
    avg_discount = adapter->avg(transposedVec[6]);

    /*
     * count(*) as count_order
     */
    count = adapter->count(transposedVec[8]);

    cout << " sum_quantity: " << sum_quantity << endl;
    cout << " sum_extended_price: " << sum_extended_price << endl;
    cout << " sum_prod_ep_disc: " << sum_prod_ep_disc << endl;
    cout << " sum_prod_ep_disc_tax: " << sum_prod_ep_disc_tax << endl;
    cout << " avg_qty: " << avg_qty << endl;
    cout << " avg_extended_price: " << avg_extended_price << endl;
    cout << " avg_discount: " << avg_discount << endl;
    cout << " count: " << count << endl;
}

void executeTpchQueries::executeQ2(BaseCompute *adapter){

    vector<vector<int>> partData = adapter->readPart();
    vector<vector<int>> supplierData = adapter->readSupplier();
    vector<vector<int>> partsuppData = adapter->readPartSupp();
    vector<vector<int>> nationData = adapter->readNation();
    vector<vector<int>> regionData = adapter->readRegion();

    vector<vector<int>> transposedPartData = adapter->getTransposedVector(partData);
    vector<vector<int>> transposedPartsuppData = adapter->getTransposedVector(partsuppData);

    /*
     * Joining Part and PartSupp
     * p_partkey = ps_partkey
     */

//    vector<int> join_1 = adapter->join(transposedPartData[0],transposedPartsuppData[0]);
//    vector<vector<int>> part_partsupp = adapter->joinTuples(partData,partsuppData,transposedPartData[0].size(),join_1);
//
//    partData.clear(); partsuppData.clear();
//    transposedPartData.clear(); transposedPartsuppData.clear();
//
//    vector<vector<int>> transposedPartPartsupp = adapter->getTransposedVector(part_partsupp);

    /*
    * Joining Part + PartSupp and Supplier
     * p_partkey = ps_partkey and
     * s_suppkey = ps_suppkey
    */

//    vector<vector<int>> transposedSupplier = adapter->getTransposedVector(supplierData);
//    vector<int> join_2 = adapter->join(transposedSupplier[0],transposedPartPartsupp[4]);
//
//    vector<vector<int>> part_partsupp_supp = adapter->joinTuples(part_partsupp,supplierData,
//                                                                 transposedSupplier[0].size(),join_2);
//
//    part_partsupp.clear(); supplierData.clear();
//    transposedPartPartsupp.clear(); transposedSupplier.clear();
//
//    vector<vector<int>> transposedPartPartsuppSupplier = adapter->getTransposedVector(part_partsupp_supp);

    /*
    * Joining Part + PartSupp + Supplier and Nation
     * p_partkey = ps_partkey and
     * s_suppkey = ps_suppkey and
     * s_nationkey = n_nationkey
    */

//    vector<vector<int>> transposedNation = adapter->getTransposedVector(nationData);
//
//    vector<int> join_3 = adapter->join(transposedPartPartsuppSupplier[8],transposedNation[0]);
//
//    vector<vector<int>> part_partsupp_supp_nation = adapter->joinTuples(part_partsupp_supp,nationData,
//                                                                 transposedPartPartsuppSupplier[8].size(),join_3);
//
//    nationData.clear(); transposedNation.clear();
//    part_partsupp_supp.clear(); transposedPartPartsuppSupplier.clear();
//
//    vector<vector<int>> transposedPartPSSupplierNation = adapter->getTransposedVector(part_partsupp_supp_nation);

    /*
    * Joining Part + PartSupp + Supplier + Nation and Region
     *  p_partkey = ps_partkey and
     *  s_suppkey = ps_suppkey and
     *  s_nationkey = n_nationkey and
     *  n_regionkey = r_regionkey
    */

//    vector<vector<int>> transposedRegion= adapter->getTransposedVector(regionData);
//
//    vector<int> join_4 = adapter->join(transposedPartPSSupplierNation[11],transposedRegion[0]);
//
//    vector<vector<int>> finalTable = adapter->joinTuples(part_partsupp_supp_nation,regionData,
//                                                                        transposedPartPSSupplierNation[11].size(),join_4);
//
//    part_partsupp_supp_nation.clear(); regionData.clear();
//    transposedPartPSSupplierNation.clear(); transposedRegion.clear();
//
//    vector<vector<int>> transposedFinal = adapter->getTransposedVector(finalTable);


    /*
     * selection r_regionkey = 0
     */

//    vector<int> select_1 = adapter->selection(transposedFinal[12], "EQ", 0);
//    vector<int> ps_res1 = adapter->prefixSum(select_1);
//    vector<vector<int>> finalTable_innerquery_result = adapter->deleteTuples(finalTable,ps_res1);
//    vector<vector<int>> transposedFinalTable_innerquery_result = adapter->getTransposedVector(finalTable_innerquery_result);

    /*
     *  min(ps_supplycost)
     */

//    int min_ps_supplycost = adapter->findMin(transposedFinalTable_innerquery_result[6]);
//    finalTable_innerquery_result.clear();
//    transposedFinalTable_innerquery_result.clear();

    /*
     * ps_supplycost = min(ps_supplycost) on outer query
     */

//    vector<int> select_2 = adapter->selection(transposedFinal[6],"EQ",min_ps_supplycost);
//    vector<int> ps_res2 = adapter->prefixSum(select_2);
//    finalTable = adapter->deleteTuples(finalTable,ps_res1);
//    transposedFinal = adapter->getTransposedVector(finalTable);

    /*
     * sort s_acctbal desc,
     * p_partkey
     */

//    vector<int> s_acctbal = adapter->sort(transposedFinal[9],1);
//    vector<int> p_partkey = adapter->sort(transposedFinal[0],0);
}

void executeTpchQueries::executeQ3(BaseCompute *adapter) {
    vector<vector<int>> lineitemData = adapter->readLineItem();
    vector<vector<int>> ordersData = adapter->readOrders();
    vector<vector<int>> customerData = adapter->readCustomer();

    vector<vector<int>>transposedLineitem = adapter->getTransposedVector(lineitemData);
    vector<vector<int>>transposedCustomer = adapter->getTransposedVector(customerData);
    vector<vector<int>>transposedOrders = adapter->getTransposedVector(ordersData);

    cout << "transpose done" << endl;
    /*
     * Joining customers and orders table
     * c_custkey = o_custkey
     */
//    vector<int> join1 = adapter->join(transposedCustomer[0],transposedOrders[1]);
//    vector<vector<int>> customer_orders = adapter->joinTuples(customerData,ordersData,transposedCustomer[0].size(),join1);

    /*
     * clear vectors to free memory
     */
    ordersData.clear();
    customerData.clear();
    transposedCustomer.clear();
    transposedOrders.clear();

//    vector<vector<int>> transposed_customer_orders = adapter->getTransposedVector(customer_orders);

    /*
     * c_custkey = o_custkey and
     * l_orderkey = o_orderkey
     */

//    vector<int> join2 = adapter->join(transposed_customer_orders[3],transposedLineitem[0]);
//    vector<vector<int>> cust_ord_lineitem = adapter->joinTuples(customer_orders,lineitemData,
//                                                                customer_orders[3].size(),join2);

    lineitemData.clear();
    transposedLineitem.clear();

//    vector<vector<int>> transposed_cust_ord_lineitem = adapter->getTransposedVector(cust_ord_lineitem);

    /*
     * where o_orderdate < date '[DATE]'
     *  and l_shipdate > date '[DATE]'
     */

//    vector<int> selection1 = adapter->selection(transposed_cust_ord_lineitem[6],"L",19950315);
//    vector<int> selection2 = adapter->selection(transposed_cust_ord_lineitem[16],"G",19950315);


    /*
     * group by
     * l_orderkey,
     * o_orderdate,
     * o_shippriority
     */


    /*
     * order_by
     *          o_orderdate
     */

//    vector<int> sort = adapter->sort(transposed_cust_ord_lineitem[6],0);



    cout << "wait" << endl;
}

void executeTpchQueries::executeQ6(BaseCompute *adapter) {

    vector<vector<int>> lineitemData = adapter->readLineItem();
    vector<vector<int>>transposedVec = adapter->getTransposedVector(lineitemData);

    vector<int> result_1;
    vector<int> result_2;
    vector<int> result_3;
    vector<int> result_4;
    vector<int> result_5;
    vector<int> result_conjunction;
    vector<int> result_product;
    int result_sum;

    result_1 = adapter->selection(transposedVec[8], "GE", 19940101);
    result_2 = adapter->selection(transposedVec[8], "LE", 19950101);
    result_3 = adapter->selection(transposedVec[6],"GE",5);
    result_4 = adapter->selection(transposedVec[6],"LE",7);
    result_5 = adapter->selection(transposedVec[4], "L", 24);

    result_conjunction = adapter->conjunction(result_1,result_2);
    result_conjunction = adapter->conjunction(result_conjunction,result_3);
    result_conjunction = adapter->conjunction(result_conjunction,result_4);
    result_conjunction = adapter->conjunction(result_conjunction,result_5);

    result_product = adapter->product(transposedVec[5],transposedVec[6]);

    result_sum = adapter->sum(result_product);
    cout << result_sum << endl;
}

void executeTpchQueries::testJoin(BaseCompute *adapter) {
    vector<vector<int>> nationData = adapter->readNation();
    vector<vector<int>> regionData = adapter->readRegion();

    vector<vector<int>>transposedNationData = adapter->getTransposedVector(nationData);
    vector<vector<int>>transposedRegionData = adapter->getTransposedVector(regionData);
//
//    vector<int> join1 = adapter->join(transposedRegionData[0],transposedNationData[1]);
//    vector<vector<int>> region_nation = adapter->joinTuples(regionData,nationData,transposedRegionData[0].size(),join1);

    vector<vector<int>> lineitemData = adapter->readLineItem();
    vector<vector<int>> ordersData = adapter->readOrders();
    vector<vector<int>> customerData = adapter->readCustomer();

    vector<vector<int>>transposedLineitem = adapter->getTransposedVector(lineitemData);
    vector<vector<int>>transposedCustomer = adapter->getTransposedVector(customerData);
    vector<vector<int>>transposedOrders = adapter->getTransposedVector(ordersData);

    adapter->join2(transposedCustomer[0],transposedOrders[1]);


    cout << "execution done" << endl;
}


void executeTpchQueries::call_tpch_query(int queryNum) {
    typedef list<BaseCompute*> libraryList;
    libraryList libraries;

//  Add libraries here
    libraries.push_back(new ThrustAdapter(new ThrustCompute));
//    libraries.push_back(new BoostAdapter(new BoostCompute));
//    libraries.push_back(new afAdapter(new afCompute));

    int count = 0;
    for(auto object : libraries)
    {
        cout << "**** \n Library " << to_string(count) << " starts \n ****" << endl;
        switch (queryNum) {
            case 1:
                executeQ1(object);
                break;
            case 3:
                executeQ3(object);
                break;
            case 6:
                executeQ6(object);
                break;
            default:
                testJoin(object);
        }
        count++;
    }
//    cout << boost::compute::system::default_device().name() << endl;
//    cout << boost::compute::system::default_device().platform().name() << endl;
}

