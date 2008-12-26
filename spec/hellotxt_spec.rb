
require File.join(File.dirname(__FILE__), %w[spec_helper])

describe HelloTxt, 'main module' do
  it 'should return the version string' do
    HelloTxt.version.should be_a_kind_of(String)
  end

  it 'should return the library path' do
    HelloTxt.libpath.should eql(HelloTxt::LIBPATH)
  end

  it 'should return the path to the library' do
    HelloTxt.path.should eql(HelloTxt::PATH)
  end
end

# EOF
