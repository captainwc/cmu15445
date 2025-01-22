WORK_SPACE := $(shell pwd)
BUILD_DIR := $(WORK_SPACE)/build

define cmake_refresh
	rm -rf $(BUILD_DIR)
	mkdir -p $(BUILD_DIR)
	cmake \
		--no-warn-unused-cli \
		-DCMAKE_EXPORT_COMPILE_COMMANDS:BOOL=TRUE \
		-DCMAKE_BUILD_TYPE:STRING=Debug \
		-DCMAKE_C_COMPILER:FILEPATH=/usr/bin/clang \
		-DCMAKE_CXX_COMPILER:FILEPATH=/usr/bin/clang++ \
		-S$(WORK_SPACE) \
		-B$(BUILD_DIR)
endef

define build_target
	cmake --build $(BUILD_DIR) --target=$(1) -j8 > /dev/null
endef

%:
	$(call build_target,$@)

help:
	@echo "Usage: make <target>"
	@echo "Available targets:"
	@echo "  help      - Show this help message"
	@echo "  <target>  - [default] Build the specified CMake target"
	@echo "  refresh   - refresh the build directory with CMake"
	@echo "  clean     - Clean the build directory"

refresh:
	$(call cmake_refresh)

clean:
	rm -rf $(BUILD_DIR)
	@mkdir -p $(BUILD_DIR)

exe:
	find -perm 755 -type f -path "*build/*" -not -path "*CMake*"

format:
	fd -e cpp -e h -E third_party -x clang-format -i

# specializeation
trie:
	@$(call build_target,trie_test)
	@./build/test/trie_test