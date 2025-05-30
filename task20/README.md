# Task 20

Networking filters turned out to be not all that complex in the end,
great work with that.

So, here's the final task.

There might be other tasks that get created and sent out later on, but
the original challenge had 20 tasks, so after finishing this one, you
can consider yourself done!

Let's try something a bit harder.  Something that might cause some data
loss on a filesystem, always a fun thing to play with, if for no other
reason than to not be afraid of things like that in the future.

This task requires you to work on the fat filesystem code:
  - Add an ioctl to modify the volume label of a mounted fat filesystem.
    Be sure to handle both 16 and 32 bit fat filesystems {hint!}
  - Provide a userspace .c program to test this new ioctl.

That's it!  Seems so simple, right?  I wonder why that option isn't in
the kernel tree already...

Anyway, provide a patch to the kernel, and the .c file used to test the
new ioctl, as well as "proof" of this working.  Make sure you don't run
into 32/64bit kernel issues with the ioctl, if you do things correctly,
you shouldn't have any problems.

I recommend doing this work on either a loop-back fat filesystem on your
"normal" filesystem, or on a USB stick.  Either will work just as well,
and make things easier to debug and test.

Watch out for locking issues, as well as dirty filesystem state
problems.

Best of luck!

