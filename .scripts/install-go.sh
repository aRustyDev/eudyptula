#!/usr/bin/env bash

 rm -rf /usr/local/go && tar -C /usr/local -xzf go1.24.3.linux-amd64.tar.gz

 grep "PATH=\$PATH:/usr/local/go/bin" ~/.bashrc
 if [ $? -ne 0 ]; then
     echo PATH=\$PATH:/usr/local/go/bin >> ~/.bashrc
 fi
