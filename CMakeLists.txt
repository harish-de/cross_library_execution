cmake_minimum_required(VERSION 3.15)
project(cross_library_execution LANGUAGES CUDA CXX)

set(CMAKE_CUDA_STANDARD 14)

FIND_PACKAGE(OpenCL REQUIRED)
FIND_PACKAGE(ArrayFire REQUIRED)
FIND_PACKAGE(Arrow REQUIRED)

#include_directories(/home/hkumar/Downloads/ComputeCpp-CE-2.1.0-x86_64-linux-gnu/include)

find_package(PkgConfig REQUIRED)
pkg_check_modules(GLIB_PKG glib-2.0)

if (GLIB_PKG_FOUND)
    message(Found glib-2.0)
    include_directories(${GLIB_PKG_INCLUDE_DIRS})
endif()

INCLUDE_DIRECTORIES(${ArrayFire_INCLUDE_DIRS})
INCLUDE_DIRECTORIES(${OpenCL_INCLUDE_DIRS})

add_library(cross_library STATIC
        Base/BaseCompute.cpp
        Base/BaseCompute.h
        ThrustOperations/ThrustComputeOps.cuh
        ThrustOperations/ThrustComputeOps.cu
        ThrustOperations/ThrustAdapter.cuh
        BoostOperations/BoostComputeOps.cpp
        BoostOperations/BoostComputeOps.h
        BoostOperations/BoostAdapter.h
        evaluation/executeQueries.cpp
        evaluation/executeQueries.h
        ThrustOperations/ThrustAdapter.cu
        ThrustOperations/ThrustAdapter.cuh
        BoostOperations/BoostAdapter.cpp
        BoostOperations/BoostAdapter.h
        ArrayFireOperations/afComputeOps.cuh
        ArrayFireOperations/afComputeOps.cu
        ArrayFireOperations/ArrayFireAdapter.cu
        ArrayFireOperations/ArrayFireAdapter.cuh evaluation/microBenchmark.cpp evaluation/microBenchmark.h)

target_compile_features(cross_library PUBLIC cxx_std_14)

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

TARGET_LINK_LIBRARIES(cross_library_execution LINK_PUBLIC ${OpenCL_LIBRARIES} ${ArrayFire_LIBRARIES})

set_target_properties(
        cross_library_execution
        PROPERTIES
        CUDA_SEPARABLE_COMPILATION ON)


