DOCKER_IMAGE_NAME = au9ustine/hirilonde
COMMIT_HASH = $(shell git rev-parse HEAD)
COMMIT_BRANCH = $(shell git symbolic-ref --short HEAD)

versioning:
	echo "git_branch: $(COMMIT_BRANCH)\ngit_hash: $(COMMIT_HASH)" > .build.yml

# Development
dev-up:
	docker-compose up -d

dev-down:
	docker-compose down --rmi all || true

# Circle CI

# Circle CI - Dependencies
circleci-dependencies: versioning
	docker pull $(shell awk '/^FROM/ { print /:/ ? $$2 : $$2":latest" }' Dockerfile.haproxy)
	docker build -f Dockerfile.haproxy -t $(DOCKER_IMAGE_NAME):$(COMMIT_HASH) .

# Circle CI - Test
circleci-pre-test:
	true

circleci-test:
	true

# Circle CI - Deployment
circleci-deployment:
	docker tag $(DOCKER_IMAGE_NAME):$(COMMIT_HASH) $(DOCKER_IMAGE_NAME):latest
	docker push $(DOCKER_IMAGE_NAME):latest
