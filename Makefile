CC=gcc
OBJCOPY=objcopy
BASEURL=https://worker.jart.workers.dev
AMALGAMATION=cosmopolitan-amalgamation-2.0.zip
LIBCOSMO_SHA256_EXPECTED=\
2228cd5924c001b2d8c8efcc9ddacaab354ba4c99a3e0c8858098e2c3f2e3fdb

hello.com: libcosmo hello.c
	$(CC) -g -Os -static -fno-pie -no-pie -nostdlib -nostdinc                  \
		-fno-omit-frame-pointer -pg -mnop-mcount -mno-tls-direct-seg-refs -o   \
		hello.com.dbg hello.c -Wl,--gc-sections -fuse-ld=bfd -Wl,--gc-sections \
		-Wl,-T,libcosmo/ape.lds -include libcosmo/cosmopolitan.h         \
		libcosmo/crt.o libcosmo/ape-no-modify-self.o                     \
		libcosmo/cosmopolitan.a
	$(OBJCOPY) -S -O binary hello.com.dbg hello.com

libcosmo: $(AMALGAMATION)
	@libcosmo_sha256_actual=`sha256sum $(AMALGAMATION) | cut -d ' ' -f 1`; \
echo "expected sha256sum: $(LIBCOSMO_SHA256_EXPECTED)" && echo \
"actual   sha256sum: $$libcosmo_sha256_actual"; if	 \
[ "$$libcosmo_sha256_actual" = "$(LIBCOSMO_SHA256_EXPECTED)" ]; then echo \
"checksums match"; else echo "checksums don't match, aborting" && exit 1; fi;
	unzip -d libcosmo $(AMALGAMATION)

$(AMALGAMATION):
	wget "$(BASEURL)/$(AMALGAMATION)"

clean:
	rm -f hello.com.dbg hello.com

distclean: clean
	rm -rf cosmopolitan* libcosmo
