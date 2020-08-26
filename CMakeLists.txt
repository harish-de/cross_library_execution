cmake_minimum_required(VERSION 3.15)
project(cross_library_execution LANGUAGES CUDA CXX)


FIND_PACKAGE(ArrayFire REQUIRED)

INCLUDE_DIRECTORIES(${ArrayFire_INCLUDE_DIRS})

add_library(cross_library STATIC
        Base/BaseCompute.cpp
        Base/BaseCompute.h
        ThrustOperations/ThrustComputeOps.cuh
        ThrustOperations/ThrustComputeOps.cu
        ThrustOperations/ThrustAdapter.cuh
        BoostOperations/BoostComputeOps.cpp
        BoostOperations/BoostComputeOps.h
        BoostOperations/BoostAdapter.h
        test_tpch_queries/executeQueries.cpp
        test_tpch_queries/executeQueries.h)

target_compile_features(cross_library PUBLIC cxx_std_11)

set_target_properties(
        cross_library
        PROPERTIES
        CUDA_SEPARABLE_COMPILATION ON)

set(CMAKE_CUDA_FLAGS "${CMAKE_CUDA_FLAGS} \
    --expt-extended-lambda \
    ")


include_directories(/usr/local/cuda-11.0/include/)
add_executable(
        cross_library_execution
        main.cu)

set_property(TARGET cross_library_execution
        PROPERTY CUDA_SEPARABLE_COMPILATION ON)

target_link_libraries(cross_library_execution PRIVATE cross_library)

TARGET_LINK_LIBRARIES(cross_library_execution LINK_PUBLIC ${ArrayFire_LIBRARIES})

target_link_libraries(cross_library_execution LINK_PUBLIC ${ArrayFire_LIBRARIES})

set_target_properties(
        cross_library_execution
        PROPERTIES
        CUDA_SEPARABLE_COMPILATION ON)


