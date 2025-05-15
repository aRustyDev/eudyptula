#!/usr/bin/env bash

eval $(op signin)
op run --env-file=".env" -- \
    in-toto-run --use-dsse --gpg --signing-key GPGKEYID --password GPGPASS\
	--step-name compile \
	--materials $(MODNAME).c policy.rego Makefile \
	--products $(MODNAME).ko $(MODNAME).mo* $(MODNAME).o modules.order Module.symvers ./*.cmd \
	--metadata-directory sigs -- make build
