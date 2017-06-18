FROM buildpack-deps:jessie

ENV XZ_VERSION=5.2.3

RUN mkdir -p /build && wget http://tukaani.org/xz/xz-${XZ_VERSION}.tar.gz -qO - | tar --strip=1 -C /build -xzf -
RUN cd /build && ./configure && make
RUN cd /build/src/xz && gcc -static -std=gnu99 -pthread -fvisibility=hidden -Wall -Wextra -Wvla -Wformat=2 -Winit-self -Wmissing-include-dirs -Wstrict-aliasing -Wfloat-equal -Wundef -Wshadow -Wpointer-arith -Wbad-function-cast -Wwrite-strings -Wlogical-op -Waggregate-return -Wstrict-prototypes -Wold-style-definition -Wmissing-prototypes -Wmissing-declarations -Wmissing-noreturn -Wredundant-decls -g -O2 -o .libs/xz *.o  ../../src/liblzma/.libs/liblzma.a -pthread
CMD cat /build/src/xz/.libs/xz