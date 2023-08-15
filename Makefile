USERNAME=shena4746
SOURCE=Dockerfile
VERSION=0.0.1
IMAGE=${USERNAME}/perl-for-latex:${VERSION}

ifeq ($(OS),Windows_NT)
	PWD=$(CURDIR)
endif

.PHONY: build
build:
	docker image build -f ${SOURCE} -t ${IMAGE} .

.PHONY: shell
shell:
	docker run --env IMAGE_VERSION=${VERSION} -it --rm -v ${PWD}:/${DIR} ${IMAGE}

.PHONY: push
push:
	docker push ${IMAGE}

.PHONY: release
release:
	git tag "v${VERSION}"; \
	git push origin "v${VERSION}"; \
	gh release create "v${VERSION}" -t "v${VERSION}" -F CHANGELOG.md

.PHONY: unrelease
unrelease:
	gh release delete -y "v${VERSION}"; \
	git tag -d "v${VERSION}"; \
	git push origin ":v${VERSION}"