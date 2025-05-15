.PHONY = all clean build test
KERNEL_VERSION = 6.11.0-25-generic
obj-m += helloworld.o

all:
	@make -C /lib/modules/$(KERNEL_VERSION)/build M=$(PWD) modules

clean:
	@echo "cleaning"
	@make -C /lib/modules/$(KERNEL_VERSION)/build M=$(PWD) clean

init:
	@pip install in-toto --break-system-packages
	@op document get --vault linux-kernel "gpg.key" -o gpg.key
	@op document get --vault linux-kernel "gpg.pub" -o gpg.pub

build: test
	@echo "building"
	@op run --env-file=".env" -- \
		in-toto-run --use-dsse --gpg --signing-key GPGKEYID --password GPGPASS\
			--step-name compile \
			--materials demo-project/foo.py \
			--products demo-project/foo.py \
			--metadata-directory sigs -- echo "helloworld"

test: verify
	@echo "testing"

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
