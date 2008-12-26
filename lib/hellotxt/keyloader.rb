require 'yaml'

module HelloTxt

  class KeyloadingError < Exception; end

  # manages the YAML file containing the keys - encryption might be nice, might be overkill
  class Keyloader

    # Path to YAML file containing keys
    attr_accessor :keyfile

    # hellotxt uses this as the key for the registered application
    attr_accessor :api_key

    # hellotxt uses this as the key for the user
    attr_accessor :user_key

    KEY_PATH = (RUBY_PLATFORM =~ /mswin32/ ? ENV['USERPROFILE'] : ENV['HOME'])
    KEY_FILE = '.hellotxt_keys.yml'

    def initialize(keyfile = File.expand_path(File.join(KEY_PATH, KEY_FILE)))
      @api_key = nil
      @keyfile = keyfile

      # load keys on init
      load_keys!
    end

    # load a new set of keys
    def load_keys(keyfile)
      if File.exist?(keyfile) and File.readable?(keyfile)
        data = YAML::load_file(keyfile)
        @keyfile = keyfile if @keyfile.nil?
        @api_key = data['api_key']
        @user_key = data['user_key']
      end
    end

    # load keys using the known keyfile
    def load_keys!
      load_keys(@keyfile)
    end

    # if keys have been loaded successfully
    def has_keys?
      return true unless @api_key.nil? or @user_key.nil?
      return false
    end

    # save key data to keyfile
    def save
      File.open( @keyfile, 'w+' ) do |out|
        YAML::dump( {'api_key' => @api_key, 'user_key' => @user_key}, out )
      end
    end
  end
end