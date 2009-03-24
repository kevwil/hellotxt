# HelloTxt Ruby Client
require 'net/http'
require 'rexml/document'

module HelloTxt

  # MUST NOT end with a trailing slash, as this string is interpolated like this:
  # "#{API_URL}/user.services"
  API_URL = 'http://hellotxt.com/api/v1'

  class Client

  	def initialize(api_key, user_key)
  		@api_key = api_key
  		@user_key = user_key
  	end

  	# Validates API key and USER key
  	# if successful returns:
  	#   {'status' => 'OK'}
  	# if unsuccessful returns:
  	#   {'status' => 'FAIL', 'message' => 'message what went wrong'}
  	def validate
  	  response = get_response('user.validate')
  		if response.elements['rsp'].attributes['status'] == 'OK'
  			return status_ok
  		else
  			return status_fail(response)
  		end
  	end

  	# Returns a list of services the user has set up through HelloTxt
  	# Optional arguments:
  	# group = service group type; either 'inhome', 'friend', 'colleague', 'all'
  	# if successful returns:
    #   {'status' => 'OK', 'services' => [{'id' => 'serviceid', 'name' => 'servicename', 'code' => 'servicecode', 'inhome' => 'checked', 'friend' => 'checked', 'collegue' => 'checked'}, ...]}
  	# if unsuccessful returns:
  	#   {'status' => 'FAIL', 'message' => 'message what went wrong'}
  	def user_services(group = 'all')
  	  response = get_response('user.services', 'group' => group)
  		if response.elements['rsp'].attributes['status'] == 'OK'
  			services = status_ok()
  			services['services'] = []
  			response.elements.each('rsp/services/service') do |service|
  				services['services'].push({'id' => service.attributes['id'],
  											'name' => service.attributes['name'],
  											'code' => service.elements['code'].text,
  											'inhome' => service.elements['inhome'].text,
  											'friend' => service.elements['friend'].text,
  											'collegue' => service.elements['collegue'].text})
  			end
  			return services
  		else
  			return status_fail(response)
  		end
  	end

  	# Posts a message to the user's social services
  	# Arguments:
  	# body = message body
  	# Optional arguments:
  	# title = title of the posted message, only used if the service supports it
  	# group = service group type; either 'inhome', 'friend', 'collegue'
  	# image = raw bytes of an image to post
  	# debug = set debug to 1 to avoid posting test data
  	# if successful returns:
  	#   {'status' => 'OK'}
  	# if unsuccessful returns:
  	#   {'status' => 'FAIL', 'message' => 'message what went wrong'}
  	def post(body, title = '', group = 'inhome', image = '', debug = 0)
  	  response = get_response('user.post',
  	                          'body' => body, 'title' => title,
  	                          'group' => group, 'image' => image,
  	                          'debug' => debug)
  		if response.elements['rsp'].attributes['status'] == 'OK'
  			return status_ok
  		else
  			return status_fail(response)
  		end
  	end
  	
  	# Returns a list of 20 status update sent through HelloTxt.
  	# if successful returns:
  	#   {'status' => 'OK', 'messages' => [{'id' => 'messageid', 'title' => 'titletext', 'body' => 'bodytext'}, ...]}
  	# if unsuccessful returns:
  	#   {'status' => 'FAIL', 'message' => 'message what went wrong'}
  	def latest
  	  response = get_response('user.latest')
  		if response.elements['rsp'].attributes['status'] == 'OK'
  		  messages = status_ok()
  		  messages['messages'] = []
  		  response.elements.each('rsp/messages/message') do |message|
  		    messages['messages'].push({'id' => message.attributes['id'],
  		                                'title' => message.elements['title'].text,
  		                                'body' => message.elements['body'].text})
		    end
  			return messages
  		else
  			return status_fail(response)
  		end
  	end

  	private

    # Gets a particular hellotxt response.
    # <tt>type</tt>: The service type (ex. 'user.services'). Gets appended to <tt>API_URL</tt>.
    # <tt>parameters</tt>: Optional (depending on the <tt>type</tt>) parameters to be passed along
    # with the request.  The API key and USER key are merged with this on every call.
    def get_response(type, parameters = {})
      parameters.merge!('app_key' => @api_key, 'user_key' => @user_key)
  		REXML::Document.new(http_request("#{API_URL}/method/#{type}", parameters))
    end

    # This makes the actual HTTP request.
  	def http_request(url, parameters)
  		response = Net::HTTP.post_form(URI.parse(url), parameters)
  		return response.body
  	end

    # Successful response.
  	def status_ok
  		return {'status' => 'OK'}
  	end

    # Failed response.
  	def status_fail(response)
  		return {'status' => 'FAIL', 'message' => response.elements['rsp/message'].text}
  	end

  end

end
