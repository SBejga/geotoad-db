
require 'mongo'

class Geotoaderdb

  # Mongo 2.2.1
  include Mongo

  def initialize
  	# increase mongo logger level to FATAL instead of DEBUG
  	Mongo::Logger.logger.level = ::Logger::FATAL
  	
=begin

	client = Mongo::Client.new([ '192.168.99.100:27017' ], :user => 'geotoad', :password => 'geotoad', :auth_source => 'admin', :database => 'geotoad')
	database = client.database
	database.collections
	coll = client[:geocache]
	coll
	coll.create

=end
  
	#client = Mongo::Client.new([ '192.168.99.100:27017' ], :user => 'geotoad', :password => 'geotoad', :auth_source => 'admin', :database => 'geotoad')
  	@client = Mongo::Client.new([ 'mongodb:27017' ], :user => 'geotoad', :password => 'geotoad', :auth_source => 'admin', :database => 'geotoad')
  
    if (@client)
      @coll = @client['geocaches']
    else
      #error means fatal, abort geotoad
      displayError 'Connection to MongoDB failed. Auth unsuccessful!'
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
