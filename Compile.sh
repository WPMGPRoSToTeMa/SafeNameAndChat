/opt/intel/bin/icpc \
		-O3 -m32 -shared \
		-fno-builtin -fno-rtti -Qoption,cpp,--treat_func_as_string_literal_cpp -no-intel-extensions -fno-stack-protector -std=c++14 \
		-ipo -s -static-libgcc -static-intel -static-libstdc++ -static-libc \
		-msse2 -fp-model strict -fomit-frame-pointer -g0 \
		-fvisibility=hidden \
-Ihlsdk/common -Ihlsdk/dlls -Ihlsdk/engine -Ihlsdk/pm_shared -Imetamod \
	Main.cpp \
-lrt -ldl -lm \
-o SafeNameAndChat.so