# geotoaddb

fork of https://github.com/steve8x8/geotoad

## Local Install

install both versions, geotoad and geotoaddb, locally.

    git clone https://github.com/SBejga/geotoaddb ~/Development/ruby/geotoad
    git clone https://github.com/SBejga/geotoaddb ~/Development/ruby/geotoaddb
    cd https://github.com/SBejga/geotoaddb ~/Development/ruby/geotoaddb
    git checkout mongo

Add Alias to your bash_profile

    alias geotoad='~/Development/ruby/geotoad/geotoad.rb'
    alias geotoaddb='~/Development/ruby/geotoaddb/geotoad.rb'

## Update from base repo

update from base steve8x8 repo:

	# base: steve8x8, origin: fork SBejga
	# https://github.com/steve8x8/geotoad
	# https://github.com/SBejga/geotoaddb

	git checkout master
	git pull base master
	git push origin master

after checkout update the VERSION file, to prevent update messages when starting geotoad

	replace version in 'lib/version.rb' with version from ./VERSION

to switch to mongo branch

    git checkout mongo