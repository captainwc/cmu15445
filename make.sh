P_PATH='/home/shuaikai/project/labs/cmu15445'

build() {
	rm -rf ${P_PATH}/build ; 
	mkdir ${P_PATH}/build ;
	/usr/bin/cmake \
	--no-warn-unused-cli \
	-DCMAKE_EXPORT_COMPILE_COMMANDS:BOOL=TRUE \
	-DCMAKE_BUILD_TYPE:STRING=Debug \
	-DCMAKE_C_COMPILER:FILEPATH=/usr/bin/clang \
	-DCMAKE_CXX_COMPILER:FILEPATH=/usr/bin/clang++ \
	-S${P_PATH} \
	-B${P_PATH}/build \
	-G "Unix Makefiles"
}

build && cd ${P_PATH}/build && make -j6
