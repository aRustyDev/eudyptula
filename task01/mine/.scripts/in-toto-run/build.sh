#!/usr/bin/env bash

eval $(op signin)

echo $PWD
echo $0
# Double Wrapped commands, op-run(in-toto-run(make-build))
    # d: metadata-dir
    # p: products (outputs)
    # m: materials (inputs)
    # n: step name
op run --env-file=".env" -- in-toto-run --use-dsse --gpg GPGKEYID -P GPGPASS -n compile -m $1.c policy.rego Makefile -p $1.ko $1.mo* $1.o modules.order Module.symvers ./*.cmd -d sigs -- make build
