cmake_minimum_required(VERSION 3.4.1)

# Set project name
project(stockfish)

# Set C++17 standard
set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

# Collect all Stockfish C++ source files
file(GLOB_RECURSE stockfish_sources "../../../../ios/Stockfish/src/*.cpp")

# Add the library
add_library(
  stockfish
  SHARED
  ../../../../ios/FlutterStockfish/ffi.cpp
  ${stockfish_sources}
)

# HarmonyOS specific compile options
if(OHOS_ARCH STREQUAL "arm64-v8a")
  if (CMAKE_BUILD_TYPE STREQUAL "Debug")
    target_compile_options(stockfish PRIVATE 
      -DUSE_PTHREADS 
      -DIS_64BIT 
      -DUSE_POPCNT 
      -DUSE_NEON=8
    )
  else()
    target_compile_options(stockfish PRIVATE 
      -fno-exceptions 
      -DUSE_PTHREADS 
      -DNDEBUG 
      -O3 
      -DIS_64BIT 
      -DUSE_POPCNT 
      -DUSE_NEON=8
    )
  endif()
elseif(OHOS_ARCH STREQUAL "armeabi-v7a")
  if (CMAKE_BUILD_TYPE STREQUAL "Debug")
    target_compile_options(stockfish PRIVATE 
      -DUSE_PTHREADS
    )
  else()
    target_compile_options(stockfish PRIVATE 
      -fno-exceptions 
      -DUSE_PTHREADS 
      -DNDEBUG 
      -O3
    )
  endif()
else()
  # Default options for other architectures
  if (CMAKE_BUILD_TYPE STREQUAL "Debug")
    target_compile_options(stockfish PRIVATE 
      -DUSE_PTHREADS 
      -DIS_64BIT 
      -DUSE_POPCNT
    )
  else()
    target_compile_options(stockfish PRIVATE 
      -fno-exceptions 
      -DUSE_PTHREADS 
      -DNDEBUG 
      -O3 
      -DIS_64BIT 
      -DUSE_POPCNT
    )
  endif()
endif()

# Download neural network files if they don't exist
file(DOWNLOAD 
  https://tests.stockfishchess.org/api/nn/nn-1111cefa1111.nnue 
  ${CMAKE_BINARY_DIR}/nn-1111cefa1111.nnue
  SHOW_PROGRESS
)

file(DOWNLOAD 
  https://tests.stockfishchess.org/api/nn/nn-37f18f62d772.nnue 
  ${CMAKE_BINARY_DIR}/nn-37f18f62d772.nnue  
  SHOW_PROGRESS
)

# Link libraries
target_link_libraries(stockfish)