.POSIX:
DESTDIR=public

GHP_REPO=git@github.com:wanderinglab/wanderinglab.github.io.git

DOCKER_IMAGE?=klakegg/hugo
DOCKER_TAG?=0.68.3-ext-pandoc


OPTIMIZE = find $(DESTDIR) -not -path "*/static/*" \( -name '*.png' -o -name '*.jpg' -o -name '*.jpeg' \) -print0 | \
xargs -0 -P8 -n2 mogrify -strip -thumbnail '1000>'



.PHONY: all
all: get_repository clean build deploy 

.PHONY: get_repository
get_repository:
	@echo "🛎 Getting Pages repository"
	git clone $(GHP_REPO) temp \
	&& mv temp/ $(DESTDIR)
	@echo "🧹 clean up temp directory"
	rm -rf temp

.PHONY: clean
clean:
	@echo "🧹 Cleaning old build"
	cd $(DESTDIR) && rm -rf *


.PHONY:server
server:
	@echo "🤖 Serving Site"
	docker run --rm -it \
	-v $(shell pwd):/src \
	-p 1313:1313 \
	--user "$(shell id -u):$(shell id -g)" \
	$(DOCKER_IMAGE):$(DOCKER_TAG) server -$(args)

.PHONY: shell
shell:
	docker run --rm -it \
	-v $(shell pwd):/src \
	-v $(shell pwd)/$(DESTDIR):/target \
	--user "$(shell id -u):$(shell id -g)" \
	-e HUGO_PANDOC="pandoc-default --strip-empty-paragraphs" \
	$(DOCKER_IMAGE):$(DOCKER_TAG) \
	shell

.PHONY: build
build:
	@echo "🍳 Generating site"
	docker run --rm -it \
	--user "$(shell id -u):$(shell id -g)" \
	-v $(shell pwd):/src \
	-v $(shell pwd)/$(DESTDIR):/target \
	-e HUGO_PANDOC="pandoc-default --strip-empty-paragraphs" \
	$(DOCKER_IMAGE):$(DOCKER_TAG) --gc --minify -d $(DESTDIR)
	


.PHONY: deploy
deploy:
	@echo "🎁 Preparing commit"
	@cd $(DESTDIR) \
	&& git add . \
	&& git status \
	&& MSG=$$(date '+%F-%T'); \
	git commit --allow-empty -m "$$MSG | 🤖 CD bot is helping" \
	&& git push -f -q
	@echo "🚀 Site is deployed!"

	