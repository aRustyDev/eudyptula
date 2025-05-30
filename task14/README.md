# Task 14

Now that you have the basics of lists, and we glossed over the custom
allocators (the first cut at that task was much harder, you got off
easy), it's time to move on to something a bit more old-school: tasks.

For this task:
  - Add a new field to the core kernel task structure called, wait for
    it, "id".
  - When the task is created, set the id to your id.  Imaginative, I
    know.  You try writing these tasks.
  - Add a new proc file for every task called, "id", located in the
    /proc/${PID}/ directory for that task.
  - When the proc file is read from, have it print out the value of
    your id, and then increment it by one, allowing different tasks to
    have different values for the "id" file over time as they are read
    from.
  - Provide some "proof" it all works properly.

As you are touching files all over the kernel tree, a patch is the
required result to be sent in here.  Please specify which kernel version
you make this patch against, to give my virtual machines a chance to
figure out how to apply it.

Also provide some kind of proof that you tested the patch.

And, in case you happened to forget it, your id is "7c1caf2f50d1".

