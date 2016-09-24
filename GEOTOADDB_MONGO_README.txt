Downstream Merge:

update from base steve8x8 repo:

	# base: steve8x8, origin: fork SBejga
	# https://github.com/steve8x8/geotoad
	# https://github.com/SBejga/geotoaddb

	git checkout master
	git pull base master
	git push origin master
	git checkout mongo
	git merge master
	git push origin mongo

Local Install

    install both versions, geotoad and geotoaddb, locally.

    git clone https://github.com/SBejga/geotoaddb ~/Development/ruby/geotoad
    git clone https://github.com/SBejga/geotoaddb ~/Development/ruby/geotoaddb
    cd https://github.com/SBejga/geotoaddb ~/Development/ruby/geotoaddb
    git checkout mongo

    Add Alias to your bash_profile
    alias geotoad='~/Development/ruby/geotoad/geotoad.rb'
    alias geotoaddb='~/Development/ruby/geotoaddb/geotoad.rb'


Dependencies:

	$ sudo gem install mongo

Requirements:

running mongo at localhost

	mongod --dbpath DB_GEOTOAD

Run:

Docker:
	GEOTOAD_MONGOPASS=xxx
	docker run -it --rm -e GEOTOAD_MONGOPASS=$GEOTOAD_MONGOPASS -e GEOTOAD_MONGOUSER=geotoad -e GEOTOAD_MONGODB=geotoad --link mongo_geotoad:mongodb sbejga/debian-ruby-node bash
	git clone https://github.com/SBejga/geotoaddb && cd geotoaddb && git checkout mongo

GUI
	$ ./geotoad.rb

CMD

	geotoad.rb --format=yourfindgpx --includeDisabled --output=GC16VNF.gpx --queryType=wid GC16VNF

	GEOCACHING_USER=
	GEOCACHING_PW='xxx'
	./geotoad.rb -u $GEOCACHING_USER -p $GEOCACHING_PW --delimiter='|' --distanceMax=1 --output='/root/' --queryType=location Pullach
