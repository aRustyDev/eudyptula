# Task 13

Weren't those lists fun to play with?  You should get used to them, they
are used all over the kernel in lots of different places.

Now that we are allocating a structure that we want to use a lot of, we
might want to start caring about the speed of the allocation, and not
have to worry about the creation of those objects from the "general"
memory pools of the kernel.

This task is to take the code written in task 12, and cause all memory
allocated from the 'struct identity' to come from a private slab cache
just for the fun of it.

Instead of using kmalloc() and kfree() in the module, use
kmem_cache_alloc() and kmem_cache_free() instead.  Of course this means
you will have to initialize your memory cache properly when the module
starts up.  Don't forget to do that.  You are free to name your memory
cache whatever you wish, but it should show up in the /proc/slabinfo
file.

Don't send the full module for this task, only a patch with the diff
from task 12 showing the lines changed.  This means you will have to
keep a copy of your 12 task results somewhere to make sure you don't
overwrite them.

Also show the output of /proc/slabinfo with your module loaded.

