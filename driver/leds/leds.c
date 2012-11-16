#include <linux/miscdevice.h>
#include <linux/delay.h>
#include <asm/irq.h>
//#include <mach/regs-gpio.h>
#include <mach/hardware.h>
#include <linux/kernel.h>
#include <linux/module.h>
#include <linux/init.h>
#include <linux/mm.h>
#include <linux/fs.h>
#include <linux/types.h>
#include <linux/delay.h>
#include <linux/moduleparam.h>
#include <linux/slab.h>
#include <linux/errno.h>
#include <linux/ioctl.h>
#include <linux/cdev.h>
#include <linux/string.h>
#include <linux/list.h>
#include <linux/pci.h>
#include <asm/uaccess.h>
#include <asm/atomic.h>
#include <asm/unistd.h>

#include <mach/map.h>
#include <mach/regs-clock.h>
#include <mach/regs-gpio.h>

#include <plat/gpio-cfg.h>
#include <mach/gpio-bank-e.h>
#include <mach/gpio-bank-k.h>
#include <linux/proc_fs.h>

#define DEVICE_NAME "dan_leds"
int read_leds_proc(char *page,char **start,off_t offset,int count,int *eof,void *data)
{
	return 1;
}
int write_leds_proc()
{
	return 1;
}
int leds_proc_register(void)//struct net *net, struct tcp_seq_afinfo *afinfo)
{
	int rc = 0;
	struct proc_dir_entry *p;

//	afinfo->seq_fops.open  = NULL;
//	afinfo->seq_fops.read  = read_leds_proc;
//	afinfo->seq_fops.llseek  = NULL;
//	afinfo->seq_fops.release  = NULL;

//	afinfo->seq_ops.start  = NULL;
//	afinfo->seq_ops.next  = NULL;
//	afinfo->seq_ops.stop  = NULL;

			//传进去的父目录是net->proc_net，应该就是/proc/net吧
			// p = proc_create_data(afinfo->name, S_IRUGO, net->proc_net,
			//         &afinfo->seq_fops, afinfo);
			//          if (!p)
			//            rc = -ENOMEM;
			//             return rc;
	return 1;
}
int leds_proc_init(void)
{
	return leds_proc_register();
}
int led_proc_remove(void)
{
	return 1;
}
static long sbc2440_leds_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
{
	switch(cmd) {
		unsigned tmp;
	case 0:
	case 1:
		if (arg > 4) {
			return -EINVAL;
		}
		tmp = readl(S3C64XX_GPKDAT);
		tmp &= ~(1 << (4 + arg));
		tmp |= ( (!cmd) << (4 + arg) );
		writel(tmp, S3C64XX_GPKDAT);
		//printk (DEVICE_NAME": %d %d\n", arg, cmd);
		return 0;
	default:
		return -EINVAL;
	}
}

static struct file_operations dev_fops = {
	.owner			= THIS_MODULE,
	.unlocked_ioctl	= sbc2440_leds_ioctl,
};

static struct miscdevice misc = {
	.minor = MISC_DYNAMIC_MINOR,
	.name = DEVICE_NAME,
	.fops = &dev_fops,
};

static int __init dev_init(void)
{
	int ret;

	{
		unsigned tmp;
		tmp = readl(S3C64XX_GPKCON);
		tmp = (tmp & ~(0xffffU<<16))|(0x1111U<<16);
		writel(tmp, S3C64XX_GPKCON);
		
		tmp = readl(S3C64XX_GPKDAT);
		tmp |= (0xF << 4);
		writel(tmp, S3C64XX_GPKDAT);
	}

	ret = misc_register(&misc);

	printk (DEVICE_NAME"\tinitialized\n");

	return ret;
}

static void __exit dev_exit(void)
{
	misc_deregister(&misc);
}

module_init(dev_init);
module_exit(dev_exit);
MODULE_LICENSE("GPL");
MODULE_AUTHOR("FriendlyARM Inc.");
