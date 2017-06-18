FROM buildpack-deps:jessie

ENV XZ_VERSION=5.2.3

RUN mkdir -p /build && wget http://tukaani.org/xz/xz-${XZ_VERSION}.tar.gz -qO - | tar --strip=1 -C /build -xzf -
RUN cd /build && ./configure && make
RUN cd /build/src/xz && gcc -static -std=gnu99 -pthread -fvisibility=hidden -Wall -Wextra -Wvla -Wformat=2 -Winit-self -Wmissing-include-dirs -Wstrict-aliasing -Wfloat-equal -Wundef -Wshadow -Wpointer-arith -Wbad-function-cast -Wwrite-strings -Wlogical-op -Waggregate-return -Wstrict-prototypes -Wold-style-definition -Wmissing-prototypes -Wmissing-declarations -Wmissing-noreturn -Wredundant-decls -g -O2 -o .libs/xz xz-args.o xz-coder.o xz-file_io.o xz-hardware.o xz-list.o xz-main.o xz-message.o xz-options.o xz-signals.o xz-suffix.o xz-util.o xz-tuklib_open_stdxxx.o xz-tuklib_progname.o xz-tuklib_exit.o xz-tuklib_cpucores.o xz-tuklib_mbstr_width.o xz-tuklib_mbstr_fw.o  ../../src/liblzma/.libs/liblzma.a -pthread
CMD cat /build/src/xz/.libs/xz