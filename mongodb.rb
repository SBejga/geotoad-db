
require 'mongo'
require 'lib/messages'

class Geotoaderdb

  # Mongo 2.2.1
  include Mongo

  include Messages

  def initialize
  	# increase mongo logger level to FATAL instead of DEBUG
  	Mongo::Logger.logger.level = ::Logger::FATAL
  
	# using environment variables to connect to mongodb
	# see export.sample.sh
	mongo_host = ENV['GEOTOAD_MONGOHOST']
	mongo_port = ENV['GEOTOAD_MONGOPORT'] || "27017"
	mongo_user = ENV['GEOTOAD_MONGOUSER']
	mongo_pass = ENV['GEOTOAD_MONGOPASS']
	mongo_db   = ENV['GEOTOAD_MONGODB']
    mongo_auth = ENV['GEOTOAD_MONGOAUTH'] || "admin"

    if (!mongo_host)
        displayError 'Start failed, no mongo environment variable GEOTOAD_MONGOHOST'
    end
    if (!mongo_port)
        displayError 'Start failed, no mongo environment variable GEOTOAD_MONGOPORT'
    end
    if (!mongo_db)
        displayError 'Start failed, no mongo environment variable GEOTOAD_MONGOUSER'
    end
    if (!mongo_auth)
        displayError 'Start failed, no mongo environment variable GEOTOAD_MONGOAUTH'
    end

    puts "(MMM)"

  	if (mongo_user && mongo_pass)
  	    puts "(MMM) mongodb://#{mongo_user}:#{mongo_pass}@#{mongo_host}:#{mongo_port}/#{mongo_db}?authSource=#{mongo_auth}"
  	    @client = Mongo::Client.new([ 'localhost:27017' ], :user => mongo_user, :password => mongo_pass, :auth_source => mongo_auth, :database => mongo_db)
  	else
  	    puts "(MMM) mongodb://#{mongo_host}:#{mongo_port}/#{mongo_db}"
  	    @client = Mongo::Client.new([ 'localhost:27017' ], :database => mongo_db)
  	end
  
    if (@client)
      @coll = @client['geocaches']

      count = @coll.find().count
      if (count >= 0)
          puts "(MMM) connected"
          puts "(MMM)"
      else
          #error means fatal, abort geotoad
          displayError 'Connection to MongoDB failed. Auth unsuccessful!'
      end
    end
  end
  
  def deinit
  	
  end

  def displayEvent(text)
    puts "( E ) #{text}"
  end

  def savetodb(gc, wid, userquery)
  
    #save wid (gc code) also in gc
    # when querying by coordinates, wid is not part of gc
    # when querying by wid, wid is part of
    gc['wid'] = wid


    #check if GC already available
    count = @coll.find(:wid => wid).count
    if (count > 1)
    	displayError 'Find more than one item with GC Code ' + wid
    	
    elsif (count == 1)
    
      documents = @coll.find(:wid => wid)
	  documents.each do |doc|
			      
		  ##check if was userquery -> we know this one is found by someone
		  if (!userquery.empty?)
			  foundbyuserarray = doc['foundbyuser']
	  
			  ##check if foundbyuser is array
			  if foundbyuserarray.kind_of?(Array)
				#check if user already mentioned in foundbyuser and add or set user has found
				if (foundbyuserarray.include? userquery)
				else
				  foundbyuserarray.push(userquery)
				end
			  else
				foundbyuserarray = [userquery]
			  end

			  gc['foundbyuserarray'] = foundbyuserarray
		  end
	  
		  result = @coll.update_one({ "wid" => wid}, gc)
		  displayEvent "updated GC in mongodb: #{wid}"
		  
      end

    else
      #when inserting, just add userquery
      gc['foundbyuser'] = [userquery]
      
      #insert
      result = @coll.insert_one(gc)
      
=begin
      /*
      #get inserted id
      insid = ""
      @coll.find(:wid => wid).each do |inserted|		
		insid = inserted[:_id]
	  end
	  
      displayEvent "saved GC to mongodb: #{wid} with #{insid}"
      */
=end
      
      displayEvent "saved GC to mongodb: #{wid}"
    end


  end

end
