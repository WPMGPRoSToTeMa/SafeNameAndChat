cmake_minimum_required(VERSION 3.1)
project(snac CXX)

option(DEBUG "Build with debug information." OFF)
option(USE_STATIC_LIBSTDC "Enables static linking libstdc++." OFF)

set(CMAKE_CXX_STANDARD 14)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

# Avoid -rdynamic -fPIC options
set(CMAKE_SHARED_LIBRARY_CXX_FLAGS "")
set(CMAKE_SHARED_LIBRARY_LINK_CXX_FLAGS "")

set(COMPILE_FLAGS "-m32 -U_FORTIFY_SOURCE")
set(LINK_FLAGS "-m32")

set(COMPILE_FLAGS "${COMPILE_FLAGS} -Wall -fno-exceptions -fno-builtin -Wno-unknown-pragmas")

# Remove noxref code and data
set(COMPILE_FLAGS "${COMPILE_FLAGS} -ffunction-sections -fdata-sections")

if (DEBUG)
	set(COMPILE_FLAGS "${COMPILE_FLAGS} -g3 -O3 -ggdb")
else()
	set(COMPILE_FLAGS "${COMPILE_FLAGS} -g0 -O3 -fno-stack-protector")
endif()

set(COMPILE_FLAGS "${COMPILE_FLAGS} -msse2 -fno-rtti -fvisibility=hidden -fvisibility-inlines-hidden -ffunction-sections -fdata-sections")

# Check Intel C++ compiler
if ("$ENV{CXX}" MATCHES "icpc")
	set(COMPILE_FLAGS "${COMPILE_FLAGS} \
		-fp-model=strict\
		-fasm-blocks\
		-fomit-frame-pointer\
		-Qoption,cpp,--treat_func_as_string_literal_cpp")

	set(LINK_FLAGS "${LINK_FLAGS} \
		-static-intel\
		-no-intel-extensions")

	if (NOT DEBUG)
		set(COMPILE_FLAGS "${COMPILE_FLAGS} -ipo")
		set(LINK_FLAGS "${LINK_FLAGS} -ipo")
	endif()
else()
	# Produce code optimized for the most common IA32/AMD64/EM64T processors.
	# As new processors are deployed in the marketplace, the behavior of this option will change.
	set(COMPILE_FLAGS "${COMPILE_FLAGS} -fpermissive -fno-sized-deallocation")

	# Check if not Clang compiler
	if (NOT "$ENV{CXX}" MATCHES "clang")
		set(COMPILE_FLAGS "${COMPILE_FLAGS} -fno-gnu-unique")
	endif()
endif()

# GCC >= 8.3
if (CMAKE_CXX_COMPILER_VERSION VERSION_GREATER_EQUAL 8.0)
	set(COMPILE_FLAGS "${COMPILE_FLAGS} -fcf-protection=none")
endif()

if (NOT DEBUG)
	set(LINK_FLAGS "${LINK_FLAGS} \
		-s -Wl,-gc-sections -Wl,--version-script=\"${PROJECT_SOURCE_DIR}/version_script.lds\"")
endif()

set(PROJECT_PUBLIC_DIR
	"${PROJECT_SOURCE_DIR}/hlsdk/common"
	"${PROJECT_SOURCE_DIR}/hlsdk/dlls"
	"${PROJECT_SOURCE_DIR}/hlsdk/engine"
	"${PROJECT_SOURCE_DIR}/hlsdk/pm_shared"
	"${PROJECT_SOURCE_DIR}/metamod"
)

set(MAIN_SRCS
	"Main.cpp"
)

add_library(snac SHARED)

target_include_directories(snac PRIVATE
	${PROJECT_SOURCE_DIR}
	${PROJECT_PUBLIC_DIR}
)

target_compile_definitions(snac PRIVATE
	_LINUX
	LINUX
	NDEBUG
	_GLIBCXX_USE_CXX11_ABI=0
)

target_sources(snac PRIVATE
	${MAIN_SRCS}
)

target_link_libraries(snac PRIVATE
	rt
	m
	dl
)

if (USE_STATIC_LIBSTDC)
	target_compile_definitions(snac PRIVATE BUILD_STATIC_LIBSTDC)
	set(LINK_FLAGS "${LINK_FLAGS} -static-libgcc -static-libstdc++")
endif()

set_target_properties(snac PROPERTIES
	OUTPUT_NAME SafeNameAndChat
	PREFIX ""
	COMPILE_FLAGS ${COMPILE_FLAGS}
	LINK_FLAGS ${LINK_FLAGS}
	POSITION_INDEPENDENT_CODE OFF
)
