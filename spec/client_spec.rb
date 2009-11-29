
require 'spec_helper'

describe HelloTxt::Client, "with expected results" do

  before(:each) do
    @client = HelloTxt::Client.new('a','b')
    @params = {'app_key' => 'a', 'user_key' => 'b'}
  end

  it "should validate keys successfully" do
    init_ok_response 'user.validate'

    uri = URI.parse "#{HelloTxt::API_URL}/method/#{@service_type}"

    # mock the http call
    http_resp = mock('response')
    http_resp.expects(:body).returns(@response)
    Net::HTTP.expects(:post_form).with(uri, @params).returns(http_resp)

    # call and verify
    result = @client.validate
    result.should_not be_empty
    result['status'].should_not be_nil
    result['status'].should eql('OK')
  end

  it "should list the user's services properly" do
    init_service_response

    uri = URI.parse "#{HelloTxt::API_URL}/method/#{@service_type}"
    @params.merge!('group' => 'all')

    # mock the http call
    http_resp = mock('response')
    http_resp.expects(:body).returns(@response)
    Net::HTTP.expects(:post_form).with(uri, @params).returns(http_resp)

    # call and verify
    result = @client.user_services
    result.should_not be_empty
    result['status'].should_not be_nil
    result['status'].should eql('OK')
    result['services'].should_not be_nil
    result['services'].should_not be_empty
    result['services'].length.should eql(5)
    result['services'].first['name'].should eql('twitter')
  end
  
  it "should list only jaiku in list of 'friend' services" do
    init_friend_service_response
    
    uri = URI.parse "#{HelloTxt::API_URL}/method/#{@service_type}"
    @params.merge!('group' => 'friend')

    # mock the http call
    http_resp = mock('response')
    http_resp.expects(:body).returns(@response)
    Net::HTTP.expects(:post_form).with(uri, @params).returns(http_resp)

    # call and verify
    result = @client.user_services('friend')
    result.should_not be_empty
    result['status'].should_not be_nil
    result['status'].should eql('OK')
    result['services'].should_not be_nil
    result['services'].should_not be_empty
    result['services'].length.should eql(1)
    result['services'].first['name'].should eql('jaiku')
  end

  it "should post a message to the service" do
    init_ok_response 'user.post'

    uri = URI.parse "#{HelloTxt::API_URL}/method/#{@service_type}"
    @params.merge!('body' => 'foo', 'title' => '',
    'group' => 'inhome', 'image' => '',
    'debug' => 0)

    # mock the http call
    http_resp = mock('response')
    http_resp.expects(:body).returns(@response)
    Net::HTTP.expects(:post_form).with(uri, @params).returns(http_resp)

    # call and verify
    result = @client.post('foo')
    result.should_not be_empty
    result['status'].should_not be_nil
    result['status'].should eql('OK')
  end
  
  it "should retrieve user's 20 latest status messages" do
    init_user_latest_response

    uri = URI.parse "#{HelloTxt::API_URL}/method/#{@service_type}"

    # mock the http call
    http_resp = mock('response')
    http_resp.expects(:body).returns(@response)
    Net::HTTP.expects(:post_form).with(uri, @params).returns(http_resp)

    # call and verify
    result = @client.latest
    result.should_not be_empty
    result['status'].should_not be_nil
    result['status'].should eql('OK')
    result['messages'].should_not be_nil
    result['messages'].should_not be_empty
    result['messages'].length.should eql(2)
    result['messages'].first['body'].should eql('this is a test message')
  end

end

describe HelloTxt::Client, "with error messages" do
  before(:each) do
    @client = HelloTxt::Client.new('a','b')
    @params = {'app_key' => 'a', 'user_key' => 'b'}
  end

  it "should handle a failed validate cleanly" do
    init_fail_response 'user.validate'

    uri = URI.parse "#{HelloTxt::API_URL}/method/#{@service_type}"

    # mock the http call
    http_resp = mock('response')
    http_resp.expects(:body).returns(@response)
    Net::HTTP.expects(:post_form).with(uri, @params).returns(http_resp)

    # call and verify
    result = @client.validate
    result.should_not be_empty
    result['status'].should_not be_nil
    result['status'].should eql('FAIL')
    result['message'].should_not be_nil
  end

  it "should handle a failed user's services cleanly" do
    init_fail_response 'user.services'

    uri = URI.parse "#{HelloTxt::API_URL}/method/#{@service_type}"
    @params.merge!('group' => 'all')

    # mock the http call
    http_resp = mock('response')
    http_resp.expects(:body).returns(@response)
    Net::HTTP.expects(:post_form).with(uri, @params).returns(http_resp)

    # call and verify
    result = @client.user_services
    result.should_not be_empty
    result['status'].should_not be_nil
    result['status'].should eql('FAIL')
    result['message'].should_not be_nil
  end

  it "should handle a failed user post cleanly" do
    init_fail_response 'user.post'

    uri = URI.parse "#{HelloTxt::API_URL}/method/#{@service_type}"

    # mock the http call
    http_resp = mock('response')
    http_resp.expects(:body).returns(@response)
    @params.merge!({'group' => 'inhome', 'title' => '',
                    'image' => '', 'body' => 'test message', 'debug' => 0})
    Net::HTTP.expects(:post_form).with(uri, @params).returns(http_resp)

    # call and verify
    result = @client.post('test message')
    result.should_not be_empty
    result['status'].should_not be_nil
    result['status'].should eql('FAIL')
    result['message'].should_not be_nil
  end

  it "should handle a failed user.latest call cleanly" do
    init_fail_response 'user.latest'

    uri = URI.parse "#{HelloTxt::API_URL}/method/#{@service_type}"

    # mock the http call
    http_resp = mock('response')
    http_resp.expects(:body).returns(@response)
    Net::HTTP.expects(:post_form).with(uri, @params).returns(http_resp)

    # call and verify
    result = @client.latest
    result.should_not be_empty
    result['status'].should_not be_nil
    result['status'].should eql('FAIL')
    result['message'].should_not be_nil
  end
end
