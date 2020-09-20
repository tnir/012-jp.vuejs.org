all: update
	rm -rf db.json
	hexo generate
	cp -R ./todomvc public/examples
	cp -R ../vue/test/unit/lib/ public/unit/lib
	cp ../vue/test/unit/runner.html public/unit/index.html
	cp ../vue/test/unit/specs.js public/unit/specs.js
	cp ../vue/test/unit/specs.js.map public/unit/specs.js.map

test:
	@echo 'test ignore !!' >/dev/null 2>&1

deploy:	all
	hexo deploy

update:
	cd ../vue && \
		git checkout -- dist && \
		git checkout 0.12 && \
		grunt build && \
		webpack --config build/webpack.test.config.js > /dev/null
	cp ../vue/dist/vue.min.js themes/vue/source/js/vue.min.js
	cp ../vue/dist/vue.js themes/vue/source/js/vue.js
	node update.js
