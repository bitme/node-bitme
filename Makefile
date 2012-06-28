COFFEE=./node_modules/.bin/coffee

build:
	@$(COFFEE) -c lib/

clean:
	@rm lib/*.js
	