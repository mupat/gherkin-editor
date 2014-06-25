#binaries
NODEWEBKIT_BIN = ./node_modules/.bin/nodewebkit
BOWER_BIN =  ./node_modules/.bin/bower
GULP_BIN = ./node_modules/.bin/gulp
COFFEE = --require coffee-script/register

watch:
	$(GULP_BIN) watch $(COFFEE)

build: install
	$(GULP_BIN) build $(COFFEE)

install:
	npm install
	$(BOWER_BIN) install

start:
	$(NODEWEBKIT_BIN) .

.PHONY: build watch