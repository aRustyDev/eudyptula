# Task 10

Yeah, you conquered the sysfs monster, great job!

Now you know to never want to mess with a kobject again, right?  Trust
me, there are easier ways to create sysfs files, and we will get into
that for a future task, but for now, let's make it a bit more simple
after all of that coding.

For this task, go back to the linux-next tree you used for task 07.
Update it, and then do the following:
  - Create a patch that fixes one coding style problem in any of the
    files in drivers/staging/
  - Make sure the patch is correct by running it through
    scripts/checkpatch.pl
  - Submit the code to the maintainer of the driver/subsystem, finding
    the proper name and mailing lists to send it to by running the tool,
    scripts/get_maintainer.pl on your patch.
  - Send a web link back to me of your patch on the public mailing list
    archive (don't cc: me on the patch, that will only confuse me and
    everyone in the kernel development community.)
  - If you want to mention the Eudyptula Challenge as the reason for
    writing the patch, feel free to do so in the body of the patch, but
    it's not necessary at all.

Hopefully this patch will be accepted into the kernel tree, and all of a
sudden, you are an "official" kernel developer!

Don't worry, there's plenty more tasks coming, but a little breather
every now and again for something simple is always nice to have.
