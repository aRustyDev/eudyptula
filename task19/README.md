# Task 19

Handling delayed work is easy now, right?  So, time to move on to
something totally different.  How about networking?  We have been
ignoring that part of the kernel, so let us now focus on the network
side of the kernel, as that is a huge reason for why Linux has taken
over the world.

For this task, write a netfilter kernel module that does the following:
  - monitors all IPv4 network traffic that is coming into the machine
  - prints the id to the kernel debug log if the network traffic stream
    contains your id.
  - properly unregisters you from the netfilter core when the module
    unloads.

Test this by sending yourself an email with your id in the subject, much
like the email you need to send back to me.

Send in the proof and the .c file for the module.

