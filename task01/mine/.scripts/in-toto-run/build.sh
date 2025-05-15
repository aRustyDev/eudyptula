#!/usr/bin/env bash

eval $(op signin)
op run --env-file=".env" -- \
    in-toto-run --use-dsse --gpg GPGKEYID --password GPGPASS \
	--step-name compile \
	--materials $1.c policy.rego Makefile \
	--products $1.ko $1.mo* $1.o modules.order Module.symvers ./*.cmd \
	--metadata-directory sigs -- make build
