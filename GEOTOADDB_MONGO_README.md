# geotoaddb

## Dependencies

	$ sudo gem install mongo

## Requirements

running mongo

	mongod --dbpath DB_GEOTOAD

## Run

### Local

need MONGO environment variables.
See export.example.sh

GUI
	
	$ ./geotoad.rb

CMD

	geotoad.rb --format=yourfindgpx --includeDisabled --output=GC16VNF.gpx --queryType=wid GC16VNF

	GEOCACHING_USER='abc'
	GEOCACHING_PW='xxx'
	./geotoad.rb -u $GEOCACHING_USER -p $GEOCACHING_PW --delimiter='|' --distanceMax=1 --output='/root/' --queryType=location Pullach


### Docker

run in a docker from image debian-ruby-node, clone git, switch to branch.
But needs link to the mongodb docker.

	GEOTOAD_MONGOPASS=xxx
	docker run -it --rm -e GEOTOAD_MONGOPASS=$GEOTOAD_MONGOPASS -e GEOTOAD_MONGOUSER=geotoad -e GEOTOAD_MONGODB=geotoad --link mongo_geotoad:mongodb sbejga/debian-ruby-node bash
	git clone https://github.com/SBejga/geotoaddb && cd geotoaddb && git checkout mongo
