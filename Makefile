.PHONY = all clean build test
UNAME_R = $(shell uname -r)
KERNEL_VERSION = $(if $(UNAME_R), $(shell uname -r | tr -d '[:space:]'), 6.11.0-25-generic)
APT_PKGS = python3-pip make kmod dwarves gcc linux-headers-$(KERNEL_VERSION)

all: init clean

clean:
	@echo "cleaning"
	@make -C /lib/modules/$(KERNEL_VERSION)/build M=$(PWD) clean

init:
	@apt-get update && apt-get upgrade
	@apt install -y python3-pip make kmod dwarves gcc linux-headers-$(KERNEL_VERSION)
	@pip install in-toto --break-system-packages
	@.scripts/install-1pw.sh
	@.scripts/install-docker.sh
	@.scripts/install-go.sh
	@go install github.com/sigstore/cosign/v2/cmd/cosign@latest
	@op document get --vault linux-kernel "gpg.key" -o gpg.key
	@op document get --vault linux-kernel "gpg.pub" -o gpg.pub
	@cp /sys/kernel/btf/vmlinux /usr/lib/modules/$(KERNEL_VERSION)/build/

build: test
	@echo "building"

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
