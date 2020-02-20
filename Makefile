# Note to developers/testers
# >> to force docs publication and deployment during testing, do the following:
# cd to repo root, connect to a cluster where you want to push your images, run the following (update SUFFIX as you like)
# SUFFIX=a GCLOUD_PROJECT_ID=cgn-public TAGGED_VERSION=vtest-docs-build$SUFFIX make publish-docs -B && kubectl apply -f docs/install/manifest-latest.yaml -n docs
# >> to run host the docs locally, do the following
# cd to the docs dir
# make serve-site -B

# help
.DEFAULT_GOAL       := help
VERSION             := v0.0.0
TARGET_MAX_CHAR_NUM := 20

GREEN  := $(shell tput -Txterm setaf 2)
YELLOW := $(shell tput -Txterm setaf 3)
WHITE  := $(shell tput -Txterm setaf 7)
RESET  := $(shell tput -Txterm sgr0)

# boilerplate
export REPOSITORY=doc
#include boilerplate/cgn/git/Makefile
include boilerplate/lyft/docker_build/Makefile
include boilerplate/lyft/golang_test_targets/Makefile

# git
REPO_NAME=$(notdir $(shell pwd))
UPSTREAM_ORG=getcouragenow
FORK_ORG=$(shell basename $(dir $(abspath $(dir $$PWD))))

# remove the "v" prefix
VERSION ?= $(shell echo $(TAGGED_VERSION) | cut -c 2-)




## Show help
help:
	@echo 'Provides tooling to run docs server.'
	@echo ''
	@echo 'Usage:'
	@echo '  ${YELLOW}make${RESET} ${GREEN}<target>${RESET}'
	@echo ''
	@echo 'Targets:'
	@awk '/^[a-zA-Z\-\_0-9]+:/ { \
		helpMessage = match(lastLine, /^## (.*)/); \
		if (helpMessage) { \
			helpCommand = substr($$1, 0, index($$1, ":")-1); \
			helpMessage = substr(lastLine, RSTART + 3, RLENGTH); \
			printf "  ${YELLOW}%-$(TARGET_MAX_CHAR_NUM)s${RESET} ${GREEN}%s${RESET}\n", helpCommand, helpMessage; \
		} \
	} \
	{ lastLine = $$0 }' $(MAKEFILE_LIST)

## Print
print: 
	@echo
	@echo REPO_NAME: $(REPO_NAME)
	@echo REPO_NAME: $(REPOSITORY)
	@echo FORK_ORG: $(FORK_ORG)
	@echo UPSTREAM_ORG: $(UPSTREAM_ORG)
	@echo

	@echo VERSION: $(VERSION)
	@echo

## Boilerplate

## boilerplate-update
boilerplate-update: 
	# See: https://github.com/lyft/boilerplate
	# Example: See: https://github.com/lyft/flytepropeller/tree/master/boilerplate
	#@boilerplate/update.sh
	go run boilerplate/update.go


### GIT-FORK

#See: https://help.github.com/en/github/collaborating-with-issues-and-pull-requests/syncing-a-fork

## git-upstream-open
git-upstream-open: 
	open https://github.com/$(UPSTREAM_ORG)/$(REPO_NAME).git 

## git-fork-open
git-fork-open: 
	open https://github.com/$(FORK_ORG)/$(REPO_NAME).git

## git-fork-setup
git-fork-setup: 
	# Pre: you git forked ( via web) and git cloned (via ssh)
	# add upstream repo
	git remote add upstream git://github.com/$(UPSTREAM_ORG)/$(REPO_NAME).git

## git-fork-catchup
git-fork-catchup: 
	# This fetches the branches and their respective commits from the upstream repository.
	git fetch upstream 

	# This brings your fork's master branch into sync with the upstream repository, without losing your local changes.
	git merge upstream/master

	# then in VSCODE just sync to push upwards to your fork.

## GIT_TAG

## git-tag-create
git-tag-create: 
	# This will create a local tag on your current branch and push it to Github.

	echo $(%1)

	git tag $(TAG_NAME)

	# push it up
	git push origin --tags

## git-tag-delete
git-tag-delete: 
	# This will delete a local tag and push that to Github

	git push --delete origin $(TAG_NAME)
	git tag -d $(TAG_NAME)



## site-common
site-common: clean 
	if [ ! -d themes/hugo-theme-soloio ]; then git clone https://github.com/solo-io/hugo-theme-soloio themes/hugo-theme-soloio; fi
	# style updates for putting docs in the gloo repo, see details here https://github.com/solo-io/hugo-theme-soloio/commit/e0c50784a92fb7f61c635ff9a6e3a010f636f550
	git -C themes/hugo-theme-soloio checkout a9c18a63d56bea026a9e241ce0078caf56eabbc5
	GO111MODULE=on go run cmd/generate_changelog_doc.go gen-changelog-md gloo > content/static/content/gloo-changelog.docgen
	GO111MODULE=on go run cmd/generate_changelog_doc.go gen-changelog-md glooe > content/static/content/glooe-changelog.docgen

## site-test
site-test: site-common 
	GO111MODULE=on go run cmd/generate_changelog_doc.go gen-version-scope-data --no-scope
	hugo --config docs.toml
	# ensure that valid json is generated. Common cause: using yaml ">" multiline string symbols in Hugo's toml headers
	cat site/index.json | jq "." > /dev/null

## site-release
site-release: site-common 
	GO111MODULE=on go run cmd/generate_changelog_doc.go gen-version-scope-data --product gloo --version $(VERSION) --call-latest
	hugo --config docs.toml
	# ensure that valid json is generated. Common cause: using yaml ">" multiline string symbols in Hugo's toml headers
	# (if it passes here, it will pass on the subsequent generation so no need to check both hugo calls)
	cat site/index.json | jq "." > /dev/null
	mv site site-latest
	GO111MODULE=on go run cmd/generate_changelog_doc.go gen-version-scope-data --product gloo --version $(VERSION)
	hugo --config docs.toml
	mv site site-versioned

## site-serve
site-serve: site-test 
	hugo --config docs.toml --themesDir themes server -D

## clean
clean: 
	rm -fr ./site ./resources ./site-latest ./site-versioned ./data/Solo.yaml