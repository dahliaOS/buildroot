OUTPUT_DIR=/buildroot_output

DOCKER_RUN=docker run \
	--security-opt seccomp=unconfined \
	--rm \
	-ti \
	--volumes-from buildroot_output \
	-v $(pwd)/images:$(OUTPUT_DIR)/images \
	os:latest

.PHONY: build

pull:
	docker build -t os:latest .

volumes:
	docker run -i --name buildroot_output os:latest /bin/true

build: pull volumes
	@echo "make O=$(OUTPUT_DIR)"
	$(DOCKER_RUN) make O=$(OUTPUT_DIR)
