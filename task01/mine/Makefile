.PHONY = all clean build test
UNAME_R = $(shell uname -r)
# KERNEL_VERSION = $(if $(UNAME_R), $(shell uname -r | tr -d '[:space:]'), 6.11.0-25-generic)
KERNEL_VERSION = $(shell uname -r)
MODNAME = helloworld
obj-m += $(MODNAME).o

all:
	@make -C /lib/modules/$(KERNEL_VERSION)/build M=$(PWD) modules

clean:
	@echo "cleaning"
	@sudo rmmod $(MODNAME).ko
	@make -C /lib/modules/$(KERNEL_VERSION)/build M=$(PWD) clean

build: test
	@echo "building"
	@op run --env-file=".env" -- \
		in-toto-run --use-dsse --gpg --signing-key GPGKEYID --password GPGPASS\
			--step-name compile \
			--materials demo-project/foo.py \
			--products demo-project/foo.py \
			--metadata-directory sigs -- echo "$(MODNAME)"

test: verify
	@echo "testing"
	@sudo insmod $(MODNAME).ko
	@sudo lsmod | grep $(MODNAME)

sign:
	@echo "signing"
	@#cosign sign-blob <file> --bundle cosign.bundle
	@#in-toto-run --step-name clone --use-dsse --products demo-project/foo.py --signing-key bob -- git clone https://github.com/in-toto/demo-project.git
	@#in-toto-record stop --step-name update-version --use-dsse --signing-key bob --products demo-project/foo.py
	@#in-toto-verify --layout root.layout --verification-keys alice.pub

verify:
	@echo "verifying"
	@#cosign verify-blob <file> --bundle cosign.bundle --certificate-identity=name@example.com --certificate-oidc-issuer=https://accounts.example.com

attest:
	@echo "attesting"
	@cosign attest --key cosign.key -predicate foo gcr.io/rekor-testing/distroless
	@cosign verify-attestation --key cosign.pub gcr.io/rekor-testing/distroless | jq -r .payload | base64 -D | jq .
	@cosign verify-attestation --policy policy.rego --key cosign.pub gcr.io/rekor-testing/distroless

	# gpg --output doc.sig --detach-sig doc

docker:
	@docker build --build-arg KERNVER=$(KERNEL_VERSION) -t "eudyptula:task01" .
	@#docker run --privileged -v "/lib/modules:/lib/modules" "eudyptula:task01"
	@docker run --rm -it "eudyptula:task01" /usr/bin/env bash
	@insmod eudyptula.ko
	@lsmod | grep eudyptula
