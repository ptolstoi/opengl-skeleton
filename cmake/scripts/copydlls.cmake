file(GLOB_RECURSE dlls "${PROJECT_SOURCE_DIR}/*.dll")
foreach(dll ${dlls})
  file(COPY ${dll} DESTINATION ${CMAKE_RUNTIME_OUTPUT_DIRECTORY})
endforeach()
