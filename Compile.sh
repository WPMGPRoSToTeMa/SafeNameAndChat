g++ \
		-O3 -m32 -shared \
		-fno-builtin -fno-rtti -fno-stack-protector -std=c++14 \
		-s -static-libstdc++ \
		-msse2 -fomit-frame-pointer -g0 \
		-fvisibility=hidden \
-Ihlsdk/common -Ihlsdk/dlls -Ihlsdk/engine -Ihlsdk/pm_shared -Imetamod \
	Main.cpp \
-lrt -ldl -lm \
-o SafeNameAndChat.so