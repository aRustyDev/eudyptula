/*
 *  hello-1.c - The simplest kernel module.
 */
#include <linux/init.h>
#include <linux/module.h>	/* Needed by all modules */
#include <linux/kernel.h>	/* Needed for KERN_INFO */

int hello(void)
{
	printk(KERN_INFO "Hello world 1.\n");

	/*
	 * A non 0 return means init_module failed; module can't be loaded.
	 */
	return 0;
}

void goodbye(void)
{
	printk(KERN_INFO "Goodbye world 1.\n");
}

module_init(hello);
module_exit(goodbye);

MODULE_LICENSE("GPL");
MODULE_AUTHOR("aRustyDev");
MODULE_DESCRIPTION("Helloworld");
