# Task 18

Nice job with the kernel thread.  It really doesn't take much code at
all to create a new thread.  So now let us get some data into the module
to give the thread something to do.

Base all of this work on your task 17 codebase.

Go back and dig up task 12's source code, the one with the list
handling.  Copy the structure into this module, and the
identity_create(), identity_find(), and identity_destroy() functions
into this module as well.

Write a new function, identity_get(), that looks like:
  struct identity identity_get(void);
and returns the next "identity" structure that is on the list, and
removes it from the list.  If nothing is on the list, return NULL.

Then, hook up the misc char device "write" function to do the following:
  - If a write is larger than 19 characters, truncate it at 19.
  - Take the write data and pass it to identity_create() as the string,
    and use an incrementing counter as the "id" value.
  - Wake up the "wee_wait" queue.

In the kernel thread function:
  - If the "wee_wait" queue wakes us up, get the next identity in the
    system with a call to identity_get().
  - Sleep (in an interruptable state, don't go increasing the system
    load in a bad way) for 5 seconds.
  - Write out the identity name, and id to the debug kernel log and then
    free the memory.

When the module exits, clean up the whole list by using the functions
given, no fair mucking around with the list variables directly.

Yes, it's a bit clunky, but it shows the basics of taking work from
userspace, and then quickly returning to the user, and then going off
and doing something else with the data and cleaning everything up.  It's
a common pattern for a kernel, as it's really all that a kernel ends up
doing most of the time (get a disk block, write a disk block, handle a
mouse event, etc.)

Load and unload the module and "prove" that it works properly by writing
and looking at the debug log, and that everything cleans up properly
when the module is unloaded.

Send in the proof and the .c file for the module.

A good test script would be the following:
        echo "Alice" > /dev/eudyptula
        echo "Bob" > /dev/eudyptula
        sleep 15
        echo "Dave" > /dev/eudyptula
        echo "Gena" > /dev/eudyptula
        rmmod task18

Removing the module while there is pending work is always a good stress
test.

