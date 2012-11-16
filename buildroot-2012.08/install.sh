#!/bin/bash
#function install rootfs
install_clean()
{
	sudo rm -rf /nfs/rootfs/*
}
install_modules()
{
	echo "begin install modules"
	sudo mkdir -p /nfs/rootfs/modules/
	sudo chmod 777 /nfs/rootfs/modules
	echo "copy modules to nfs rootfs"
	for ko in `find output/build/linux-custom/ -name "*.ko"`
	do
		    sudo cp -rf $ko /nfs/rootfs/modules/
		    echo "copy module $ko to the rootfs dir"
	done
	echo "instal modules complete"
}
install_kernel()
{
	
	echo "begin install kernel"
	sudo cp -rf output/images/zImage /nfs/rootfs/
	echo "instal kernel complete"
}

install_rootfs()
{
	install_clean
	sudo tar xvf output/images/rootfs.tar.bz2 -C /nfs/rootfs/
	install_kernel
	install_modules
}
install_all()
{
	install_clean
	install_rootfs
	install_kernel
	install_modules
}
install_clish()
{
#sudo cp -rf /opt/FriendlyARM/toolschain/4.5.1/arm-none-linux-gnueabi/sys-root/usr/lib/libbfd-2.20.1.20100303.so /nfs/rootfs/lib/
	sudo cp -rf ~/develop/klish/xml-examples/clish/ /nfs/rootfs/
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
		install_rootfs
		echo install rootfs ;;
	"clish"*)
		install_clish
		echo install clish ;;
	"all"*)
		install_all
		echo install all ;;
	*)
		install_all
		echo "unknown para"
esac
exit
sudo rm -rf /nfs/rootfs/*
sudo mkdir -p /nfs/rootfs/modules/
sudo tar xvf output/images/rootfs.tar.bz2 -C /nfs/rootfs/
sudo cp output/images/zImage /nfs/rootfs/
sudo cp output/images/rootfs.ubifs /nfs/rootfs/
echo "copy modules to nfs rootfs"
for ko in `find output/build/linux-custom/ -name "*.ko"`
do
	sudo cp -rf $ko /nfs/rootfs/modules/
	echo "copy module $ko to the rootfs dir"
done
