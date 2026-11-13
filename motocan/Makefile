VESC_TOOL ?= vesc_tool

all: motocan.vescpkg

motocan.vescpkg:
	$(VESC_TOOL) --buildPkgFromDesc pkgdesc.qml
clean:
	rm -f motocan.vescpkg

.PHONY: all clean

