# Additional clean files
cmake_minimum_required(VERSION 3.16)

if("${CONFIG}" STREQUAL "" OR "${CONFIG}" STREQUAL "Debug")
  file(REMOVE_RECURSE
  "CMakeFiles\\appsvm_display_autogen.dir\\AutogenUsed.txt"
  "CMakeFiles\\appsvm_display_autogen.dir\\ParseCache.txt"
  "appsvm_display_autogen"
  )
endif()
