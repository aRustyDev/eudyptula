# Task 16

Good job with the new syscall.  The odds of you ever having to write a
new syscall is pretty rare, but now you know where to look them up, and
what the code involved in creating one looks like, which is useful when
you try to debug things.

Let's take a breather after all of that code, and go back to doing a bit
of reading, and learn some more about some common kernel tools.

Go install the tool 'sparse'.  It was started by Linus as a
static-analysis tool that acts much like a compiler.  The kernel build
system is set up to have it run if you ask it to, and it will report a
bunch of issues in C code that are really specific to the kernel.

When you build the kernel, pass the "C=1" option to the build, to have
sparse run on the .c file before gcc is run.  Depending on the file,
nothing might be printed out, or something might.  Here's an example of
it being run on the ext4 code:

$ make C=1 M=fs/ext4
  CHECK   fs/ext4/balloc.c
  CC      fs/ext4/balloc.o
  CHECK   fs/ext4/bitmap.c
  CC      fs/ext4/bitmap.o
  CHECK   fs/ext4/dir.c
  CC      fs/ext4/dir.o
  CHECK   fs/ext4/file.c
  CC      fs/ext4/file.o
  CHECK   fs/ext4/fsync.c
  CC      fs/ext4/fsync.o
  CHECK   fs/ext4/ialloc.c
  CC      fs/ext4/ialloc.o
  CHECK   fs/ext4/inode.c
  CC      fs/ext4/inode.o
  CHECK   fs/ext4/page-io.c
  CC      fs/ext4/page-io.o
  CHECK   fs/ext4/ioctl.c
  CC      fs/ext4/ioctl.o
  CHECK   fs/ext4/namei.c
  CC      fs/ext4/namei.o
  CHECK   fs/ext4/super.c
  CC      fs/ext4/super.o
  CHECK   fs/ext4/symlink.c
  CC      fs/ext4/symlink.o
  CHECK   fs/ext4/hash.c
  CC      fs/ext4/hash.o
  CHECK   fs/ext4/resize.c
  CC      fs/ext4/resize.o
  CHECK   fs/ext4/extents.c
  CC      fs/ext4/extents.o
  CHECK   fs/ext4/ext4_jbd2.c
  CC      fs/ext4/ext4_jbd2.o
  CHECK   fs/ext4/migrate.c
  CC      fs/ext4/migrate.o
  CHECK   fs/ext4/mballoc.c
fs/ext4/mballoc.c:5018:9: warning: context imbalance in 'ext4_trim_extent' - unexpected unlock
  CC      fs/ext4/mballoc.o
  CHECK   fs/ext4/block_validity.c
  CC      fs/ext4/block_validity.o
  CHECK   fs/ext4/move_extent.c
  CC      fs/ext4/move_extent.o
  CHECK   fs/ext4/mmp.c
  CC      fs/ext4/mmp.o
  CHECK   fs/ext4/indirect.c
  CC      fs/ext4/indirect.o
  CHECK   fs/ext4/extents_status.c
  CC      fs/ext4/extents_status.o
  CHECK   fs/ext4/xattr.c
  CC      fs/ext4/xattr.o
  CHECK   fs/ext4/xattr_user.c
  CC      fs/ext4/xattr_user.o
  CHECK   fs/ext4/xattr_trusted.c
  CC      fs/ext4/xattr_trusted.o
  CHECK   fs/ext4/inline.c
  CC      fs/ext4/inline.o
  CHECK   fs/ext4/acl.c
  CC      fs/ext4/acl.o
  CHECK   fs/ext4/xattr_security.c
  CC      fs/ext4/xattr_security.o
  LD      fs/ext4/ext4.o
  LD      fs/ext4/built-in.o
  Building modules, stage 2.
  MODPOST 0 modules

As you can see, only one warning was found here, and odds are, it is a
false-positive, as I'm sure those ext4 developers know what they are
doing with their locking functions, right?

Anyway the task this time is:
  - Run sparse on the drivers/staging/ directory, yes, that horrible
    code again, sorry.
  - Find one warning that looks interesting.
  - Write a patch that resolves the issue.
  - Make sure the patch is correct by running it through
    scripts/checkpatch.pl
  - Submit the code to the maintainer of the driver/subsystem, finding
    the proper name and mailing lists to send it to by running the tool,
    scripts/get_maintainer.pl on your patch.
  - Send a web link back to me of your patch in the public mailing list
    archive (don't cc: me on the patch, that will only confuse me and
    everyone in the kernel development community.)
  - If you want to mention the Eudyptula Challenge as the reason for
    writing the patch, feel free to do so in the body of the patch, but
    it's not necessary at all.

That's it, much like task 10 was, but this time you are fixing logical
issues, not just pesky coding style issues.  You are a real developer
now, fixing real bugs!

