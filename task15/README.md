# Task 15

That process task turned out to not be all that complex, but digging
through the core kernel was a tough task, nice work with that.

Speaking of "core kernel" tasks, let's do another one.  It's one of the
most common undergraduate tasks there is: create a new syscall!
Yeah, loads of fun, but it's good to know the basics of how to do this,
and, how to call it from userspace.

For this task:
  - Add a new syscall to the kernel called "sys_eudyptula", so this is
    all going to be changes to the kernel tree itself, no stand-alone
    module needed for this task (unless you want to do it that way
    without hacking around the syscall table, if so, bonus points for
    you...)
  - The syscall number needs to be the next syscall number for the
    architecture you test it on (some of you all are doing this on ARM
    systems, showoffs, and syscall numbers are not the same across all
    architectures).  Document the arch you are using and why you picked
    this number in the module.
  - The syscall should take two parameters: int high_id, int low_id.
  - The syscall will take the two values, mush them together into one
    64bit value (low_id being the lower 32bits of the id, high_id being
    the upper 32bits of the id).
  - If the id value matches your id (which of course you know as
    "7c1caf2f50d1", then the syscall returns success.  Otherwise it
    returns a return code signifying an invalid value was passed to it.
  - Write a userspace C program that calls the syscall and properly
    exercises it (valid and invalid calls need to be made).
  - "Proof" of running the code needs to be provided.

So you need to send in a .c userspace program, a kernel patch, and
"proof" that it all works, as a response.

