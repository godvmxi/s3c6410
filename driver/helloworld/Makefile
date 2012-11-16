ifneq ($(KERNELRELEASE),)
obj-m:=helloworld.o
else
KERNEL_DIR:=/home/dan/develop/6410/buildroot-2012.08/output/build/linux-custom/
PWD:=$(shell pwd)
ARCH:=arm
CROSS_COMPILE:=/opt/FriendlyARM/toolschain/4.5.1/bin/arm-linux-
all:
	make -C ${KERNEL_DIR} M=$(PWD) modules
clean:
	rm -rf *.o *.ko *.order *.mod.* *.cmd *.sym* *.tmp*
install: 
	cp -rf *.ko /nfs/rootfs/modules/
endif
