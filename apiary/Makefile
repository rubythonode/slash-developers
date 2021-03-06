CDA_APIARY_NAME=contentfulcda
CDA_BLUEPRINT=out/cda.apib
CDA_HOST=https://cdn.contentful.com

CMA_APIARY_NAME=contentfulcma
CMA_BLUEPRINT=out/cma.apib
CMA_HOST=https://api.contentful.com

CPA_APIARY_NAME=contentpreviewapi
CPA_BLUEPRINT=out/cpa.apib
CPA_HOST=https://preview.contentful.com

IMAGES_APIARY_NAME=contentfulimagesapi
IMAGES_BLUEPRINT=out/images.apib
IMAGES_HOST=https://images.contentful.com

DREDD=node_modules/.bin/dredd
HERCULE=node_modules/.bin/hercule
APIARY=bundle exec apiary

.PHONY: all outdir clean fetch preview test install prepare check_ci_var check_apiary_token check_cma_token notify_slack publish publish_docs

all: test

outdir:
	mkdir -p out

clean:
	rm -f $(CDA_BLUEPRINT) $(CPA_BLUEPRINT) $(CMA_BLUEPRINT) $(IMAGES_BLUEPRINT)

install:
	@if [ ! -f $(DREDD) ] || [ ! -f $(HERCULE) ]; then \
		npm install; \
	fi
	@$$(bundle show apiaryio > /dev/null); \
	if [ $$? != 0 ]; then \
		bundle install; \
	fi
	chmod a+x ../placeholder-replacements.sh

$(CDA_BLUEPRINT): outdir cda.apib _partials/content-types-description.md
	$(HERCULE) cda.apib -o $@
	../placeholder-replacements.sh $@

$(CMA_BLUEPRINT): outdir cma.apib _partials/content-types-description.md
	$(HERCULE) cma.apib -o $@
	../placeholder-replacements.sh $@

$(IMAGES_BLUEPRINT): outdir images.apib
	$(HERCULE) images.apib -o $@
	../placeholder-replacements.sh $@

# This task replaces the CDA token with a Preview token via `sed`
$(CPA_BLUEPRINT): outdir cpa.apib
	$(HERCULE) cpa.apib -o $@
	../placeholder-replacements.sh $@ preview


# XXX: The Apiary editor should not be used, because we use partials for CDA/CPA
#fetch:
#	apiary fetch --api-name=$(CDA_APIARY_NAME) >$(CDA_BLUEPRINT)
#	apiary fetch --api-name=$(CMA_APIARY_NAME) >$(CMA_BLUEPRINT)

prepare: $(CDA_BLUEPRINT) $(CPA_BLUEPRINT) $(CMA_BLUEPRINT) $(IMAGES_BLUEPRINT)
	# for blueprint in $^; do \
	# 	./lint.sh $$blueprint || exit 1; \
	# done

preview: check_apiary_token prepare
	$(APIARY) preview --path=$(CDA_BLUEPRINT)
	$(APIARY) preview --path=$(CMA_BLUEPRINT)
	$(APIARY) preview --path=$(CPA_BLUEPRINT)
	$(APIARY) preview --path=$(IMAGES_BLUEPRINT)

publish: check_apiary_token check_ci_var install prepare publish_docs notify_slack

publish_docs:
	$(APIARY) publish --api-name=$(CDA_APIARY_NAME) --path=$(CDA_BLUEPRINT)
	$(APIARY) publish --api-name=$(CMA_APIARY_NAME) --path=$(CMA_BLUEPRINT)
	$(APIARY) publish --api-name=$(CPA_APIARY_NAME) --path=$(CPA_BLUEPRINT)
	$(APIARY) publish --api-name=$(IMAGES_APIARY_NAME) --path=$(IMAGES_BLUEPRINT)

test: check_cma_token prepare
	@$(DREDD) $(CPA_BLUEPRINT) $(CPA_HOST) --hookfiles=./test-hooks.js \
	    --reporter apiary -j apiaryApiName:contentfulcpa -j apiaryApiKey:$(APIARY_API_KEY)
	@$(DREDD) $(CDA_BLUEPRINT) $(CDA_HOST) --hookfiles=./test-hooks.js \
	    --reporter apiary -j apiaryApiName:contentfulcda -j apiaryApiKey:$(APIARY_API_KEY)
	@$(DREDD) $(CMA_BLUEPRINT) $(CMA_HOST) \
		--hookfiles=./test-hooks-cma.js \
		-h "Authorization: Bearer $(CONTENTFUL_MANAGEMENT_API_ACCESS_TOKEN_NEW)" \
		--private-header Authorization \
		--reporter apiary -j apiaryApiName:contentfulcma -j apiaryApiKey:$(APIARY_API_KEY) \
		-m GET #-m PUT -m POST #-m DELETE
	#$(DREDD) $(IMAGES_BLUEPRINT) $(IMAGES_HOST)

notify_slack:
	@if [ "$(WEBHOOK_URL)" != "" -a "$(SLACK_CHANNEL)" != "" ]; then \
		./notify-slack.sh "$(WEBHOOK_URL)" "#$(SLACK_CHANNEL)" "A new version of the developers documentation was deployed."; \
	fi

#################
# Sanity checks #
#################

# Call: $(call check_env_variable,VAR_NAME)
define check_env_variable
	@if [ "$($1)" = "" ]; then \
		echo "Environment variable not set: $1"; \
		exit 1; \
	fi
endef

check_ci_var:
	$(call check_env_variable,CI)
check_apiary_token:
	$(call check_env_variable,APIARY_API_KEY)
check_cma_token:
	$(call check_env_variable,CONTENTFUL_MANAGEMENT_API_ACCESS_TOKEN_NEW)
