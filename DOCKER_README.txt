# Run with Docker

## Mongo Container

### setup & start

	docker run -d -p 27017:27017 -p 28017:28017 --name mongodb tutum/mongodb:3.0

Hint: The first time that you run your container, a new random password will be set.
To get the password, check the logs of the container by running:

	docker logs <CONTAINER_ID>

or to set custom password:

	docker run -d -p 27017:27017 -p 28017:28017 -e MONGODB_PASS="mypass" --name mongodb tutum/mongodb:3.0

### stop

	docker stop mongodb

## start again

	docker start mongodb

## connect to mongo

	mongo admin -u admin -p mypass

or on mac (running in a docker-machine)

	mongo admin -u admin -p mypass --host $(docker-machine ip default)

## Geotoaddb Container

# build ruby app image to run 

	docker build -t sbejga/rubyapp .
	
# Run
	
	docker run -it --rm --name geotoaddb sbejga/rubyapp ./geotoad.rb
	
or enter shell and run there

	docker run -it --rm --name geotoaddb sbejga/rubyapp /bin/bash
	./geotoad.rb
	
# TODO:

docker

- link rubyapp to mongo db
- use correct ip in mongodb.rb to connect to linked mongo db
- orchestrate? docker composer?

ruby
- add Gemfile to install required mongo db driver gem?