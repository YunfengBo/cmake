#=============================================================================
#
# BreasTouch 项目中，各子项目通用的 C/C++ 编译、链接选项
#
#=============================================================================

# =============================================================================
# 引入项目通用 cmake 设置
include(common)

# =============================================================================
# set compiler/linker flags.
if(OS_WINDOWS)
  # /bigobj               = 将该地址容量增加至 4,294,967,296 (2^32)
  # /MP                   = Multiprocess compilation
  # /W4                   = Warning level 4
  # /WX                   = Treat warnings as errors
  # /wd"4819"             = Ignore 该文件包含不能在当前代码页(936)中表示的字符。忽略这个 warning 不影响正常编译，但在程序Debug的时候，可能无法停在断点
  # /wd"4127"             = Ignore "条件表达式是常量" warning，有些第三方库就是这么写的，常量就常量吧
  # /wd"4100"             = Ignore "未引用的形参" warning
  set(COMPILER_FLAGS         "/bigobj /MP /W4 /WX /wd\"4819\" /wd\"4127\" /wd\"4100\"")
  
  # /MDd                  = Multithreaded debug runtime
  # /Zi                   = Enable program database
  # /Od                   = Disable optimizations
  # /Ob0                  = Disable Inline function
  # /RTC1                 = Enable basic run-time checks
  # /DDEBUG /D_DEBUG"     = This is a debug build
  set(COMPILER_FLAGS_DEBUG   "/MDd /Zi /Od /Ob0 /RTC1 /DDEBUG /D_DEBUG")
  
  # /MD                   = Multithreaded release runtime
  # /O2                   = Optimize for maximum speed
  # /Ob2                  = Inline any suitable function
  # /GF                   = Enable string pooling
  # /DNDEBUG /D_NDEBUG    = Not a debug build
  set(COMPILER_FLAGS_RELEASE "/MD /O2 /Ob2 /GF /DNDEBUG /D_NDEBUG")
  
  # /SUBSYSTEM:CONSOLE    = 显示控制台窗口（便于调试）
  set(LINKER_FLAGS_DEBUG     "/DEBUG /SUBSYSTEM:CONSOLE")
endif()

if(OS_LINUX)
  set(COMPILER_FLAGS         "-Wall")
  set(COMPILER_FLAGS_DEBUG "-O0 -ggdb")
  set(COMPILER_FLAGS_RELEASE "")
endif()

# =============================================================================
# Merge compiler/linker flags.
# 合并时，如果有重复的选项，经过试验，会使用后面的选项（即上面的设置项）
set(CMAKE_C_FLAGS                     "${CMAKE_C_FLAGS} ${COMPILER_FLAGS}")
set(CMAKE_C_FLAGS_DEBUG               "${CMAKE_C_FLAGS_DEBUG} ${COMPILER_FLAGS_DEBUG}")
set(CMAKE_C_FLAGS_RELEASE             "${CMAKE_C_FLAGS_RELEASE} ${COMPILER_FLAGS_RELEASE}")
set(CMAKE_CXX_FLAGS                   "${CMAKE_CXX_FLAGS} ${COMPILER_FLAGS}")
set(CMAKE_CXX_FLAGS_DEBUG             "${CMAKE_CXX_FLAGS_DEBUG} ${COMPILER_FLAGS_DEBUG}")
set(CMAKE_CXX_FLAGS_RELEASE           "${CMAKE_CXX_FLAGS_RELEASE} ${COMPILER_FLAGS_RELEASE}")
set(CMAKE_EXE_LINKER_FLAGS            "${CMAKE_EXE_LINKER_FLAGS} ${LINKER_FLAGS}")
set(CMAKE_EXE_LINKER_FLAGS_DEBUG      "${CMAKE_EXE_LINKER_FLAGS_DEBUG} ${LINKER_FLAGS_DEBUG}")
set(CMAKE_EXE_LINKER_FLAGS_RELEASE    "${CMAKE_EXE_LINKER_FLAGS_RELEASE} ${LINKER_FLAGS_RELEASE}")
set(CMAKE_SHARED_LINKER_FLAGS         "${CMAKE_SHARED_LINKER_FLAGS} ${LINKER_FLAGS}")
set(CMAKE_SHARED_LINKER_FLAGS_DEBUG   "${CMAKE_SHARED_LINKER_FLAGS_DEBUG} ${LINKER_FLAGS_DEBUG}")
set(CMAKE_SHARED_LINKER_FLAGS_RELEASE "${CMAKE_SHARED_LINKER_FLAGS_RELEASE} ${LINKER_FLAGS_RELEASE}")

message("C COMPILER FLAGS               ===> ${CMAKE_C_FLAGS}")
message("C_COMPILER_FLAGS_DEBUG         ===> ${CMAKE_C_FLAGS_DEBUG}")
message("C_COMPILER_FLAGS_RELEASE       ===> ${CMAKE_C_FLAGS_RELEASE}")
message("CXX_COMPILER_FLAGS             ===> ${CMAKE_CXX_FLAGS}")
message("CXX_COMPILER_FLAGS_DEBUG       ===> ${CMAKE_CXX_FLAGS_DEBUG}")
message("CXX_COMPILER_FLAGS_RELEASE     ===> ${CMAKE_CXX_FLAGS_RELEASE}")
message("EXE_LINKER_FLAGS               ===> ${CMAKE_EXE_LINKER_FLAGS}")
message("EXE_LINKER_FLAGS_DEBUG         ===> ${CMAKE_EXE_LINKER_FLAGS_DEBUG}")
message("EXE_LINKER_FLAGS_RELEASE       ===> ${CMAKE_EXE_LINKER_FLAGS_RELEASE}")
message("SHARED_LINKER_FLAGS            ===> ${CMAKE_SHARED_LINKER_FLAGS}")
message("SHARED_LINKER_FLAGS_DEBUG      ===> ${CMAKE_SHARED_LINKER_FLAGS_DEBUG}")
message("SHARED_LINKER_FLAGS_RELEASE    ===> ${CMAKE_SHARED_LINKER_FLAGS_RELEASE}")