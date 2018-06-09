.PHONY : prerequiste build image push all
goose-tag=v2.3.0
DOCKER_REGISTRY := niksw7
IMG_NAME:=goose-alpine

prerequiste:
	@test -d goose || git clone https://github.com/pressly/goose.git 
	@#figure out in above case why ! operator is not working
	@command -v dep  || curl "https://raw.githubusercontent.com/golang/dep/master/install.sh" | sh

build: 
	@cd goose && git checkout $(goose-tag) && dep ensure && make dist CGO_FLAG="CGO_ENABLED=0"

image:
	@echo Creating image $(DOCKER_REGISTRY)/$(IMG_NAME):$(goose-tag)
	@docker build -f $(CURDIR)/Dockerfile -t $(DOCKER_REGISTRY)/$(IMG_NAME):$(goose-tag) .

push:
	@echo Pushing $(DOCKER_REGISTRY)/$(IMG_NAME):$(goose-tag)
	@docker push $(DOCKER_REGISTRY)/$(IMG_NAME):$(goose-tag)

all: prerequiste build image