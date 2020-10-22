# DOCKER_USER:=peterclemenko
DOCKER_ORGANIZATION=peterclemenko
DOCKER_IMAGE:=blackarch

docker-image:
	docker build -t $(DOCKER_ORGANIZATION)/$(DOCKER_IMAGE) .

docker-image-test: docker-image
	# FIXME: /etc/mtab is hidden by docker so the stricter -Qkk fails
	docker run --rm $(DOCKER_ORGANIZATION)/$(DOCKER_IMAGE) sh -c "/usr/bin/pacman -Sy && /usr/bin/pacman -Qqk"
	docker run --rm $(DOCKER_ORGANIZATION)/$(DOCKER_IMAGE) sh -c "/usr/bin/pacman -Syu --noconfirm docker && docker -v"

ci-test:
	docker run --rm --privileged \
		--tmpfs=/tmp:exec --tmpfs=/run/shm \
		-v /run/docker.sock:/run/docker.sock \
		-v $(PWD):/app -w /app \
		$(DOCKER_ORGANIZATION)/$(DOCKER_IMAGE) \
		sh -c 'pacman -Syu --noconfirm make devtools docker && make docker-image-test'

# docker-push:
# 	docker login -u $(DOCKER_USER)
# 	docker push $(DOCKER_ORGANIZATION)/$(DOCKER_IMAGE)

.PHONY: docker-image docker-image-test ci-test # docker-push
