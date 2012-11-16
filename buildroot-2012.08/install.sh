#!/bin/bash
#function install rootfs
install_clean()
{
	echo clean the rootfs
	rm -rf /nfs/rootfs/*
}
install_modules()
{
	echo "begin install modules"
	mkdir -p /nfs/rootfs/modules/
	chmod 777 /nfs/rootfs/modules
	"copy modules to nfs rootfs"
	for ko in `find output/build/linux-custom/ -name "*.ko"`
	do
		    cp -rf $ko /nfs/rootfs/modules/
		    echo "copy module $ko to the rootfs dir"
	done
	echo "instal modules complete"
}
install_kernel()
{
	
	echo "begin install kernel"
	cp -rf output/images/zImage /nfs/rootfs/
	echo "instal kernel complete"
}

install_rootfs()
{
	echo instal rootfs
	install_clean
	tar xvf output/images/rootfs.tar.bz2 -C /nfs/rootfs/
	install_kernel
	install_modules
}
install_all()
{
	install_clean
	install_rootfs
	install_kernel
	install_modules
	install_clish
}
install_clish()
{
#sudo cp -rf /opt/FriendlyARM/toolschain/4.5.1/arm-none-linux-gnueabi/sys-root/usr/lib/libbfd-2.20.1.20100303.so /nfs/rootfs/lib/
	cp -rf ../clish-xml/clish/ /nfs/rootfs/etc/
	chmod 777 /nfs/rootfs/etc/profile
	echo "export CLISH_PATH=/etc/clish" >> /nfs/rootfs/etc/profile
	chmod 644 /nfs/rootfs/etc/profile
}
echo "begin renew the root file system"
case "$1" in
	"kernel"*)
		echo install kernel 
		install_kernel ;;
	"modules"*)
		echo install modules
		install_modules ;;
	"rootfs"*)
		echo install rootfs 
		install_rootfs ;;
	"clish"*)
		echo install clish 
		install_clish ;;
	"all"*)
		install_all
		echo install all complete ;;
	*)
		echo "default install all"
		install_all ;;
esac
exit
rm -rf /nfs/rootfs/*
mkdir -p /nfs/rootfs/modules/
tar xvf output/images/rootfs.tar.bz2 -C /nfs/rootfs/
cp output/images/zImage /nfs/rootfs/
cp output/images/rootfs.ubifs /nfs/rootfs/
"copy modules to nfs rootfs"
for ko in `find output/build/linux-custom/ -name "*.ko"`
do
cp -rf $ko /nfs/rootfs/modules/
	echo "copy module $ko to the rootfs dir"
done
