module HelloTxt

  module VERSION # :nodoc:
    MAJOR   = 1
    MINOR   = 0
    TINY    = 3
    STRING  = [MAJOR,MINOR,TINY].join('.')
  end
  
  autoload :Keyloader, 'hellotxt/keyloader'
  autoload :Client, 'hellotxt/client'
end

# EOF
