#!/usr/bin/env bash

eval $(op signin)

echo $PWD
echo $0
# Double Wrapped commands, op-run(in-toto-run(make-build))
    # d: metadata-dir
    # p: products (outputs)
    # m: materials (inputs)
    # n: step name
witness run -s compile -o attest.json \
    --attestor-product-exclude-glob "$1.c" \
    --attestor-product-include-glob "*$1*" \
    --attestor-product-include-glob "*odule*" \
	--signer-fulcio-url https://fulcio.sigstore.dev \
	--signer-fulcio-oidc-client-id sigstore \
	--signer-fulcio-oidc-issuer https://oauth2.sigstore.dev/auth \
	--timestamp-servers https://freetsa.org/tsr -- make build

# -m $1.c policy.rego Makefile
# -p $1.ko $1.mo* $1.o modules.order Module.symvers ./*.cmd
