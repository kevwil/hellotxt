require File.join(File.dirname(__FILE__), %w[spec_helper])
require 'tempfile'

describe HelloTxt::Keyloader do

  before(:each) do
    @keydata = {'api_key' => 'foo', 'user_key' => 'bar'}
    @tf = Tempfile.new('keys.yml')
    YAML::dump(@keydata, @tf)
    @tmp_path = @tf.path
    @tf.close
  end

  after(:each) do
    @tf.unlink
  end

  it "should use keys from yaml file if found" do
    loader = HelloTxt::Keyloader.new(@tmp_path)
    loader.has_keys?.should be_true
    loader.keyfile.should eql(@tmp_path)
    loader.api_key.should eql(@keydata['api_key'])
    loader.user_key.should eql(@keydata['user_key'])
  end

  it "should save keys to keyfile" do
    loader = HelloTxt::Keyloader.new(@tmp_path)
    loader.user_key = 'baz'
    loader.save

    loader.has_keys?.should be_true
    File.exist?(loader.keyfile).should be_true
    File.readable?(loader.keyfile).should be_true
    YAML::load_file(loader.keyfile)['user_key'].should eql('baz')
  end

  it "should behave if keys cannot be loaded" do
    loader = HelloTxt::Keyloader.new('/tmp/nofile')
    loader.has_keys?.should be_false
    loader.api_key.should be_nil
    loader.user_key.should be_nil
  end
end