
def init_ok_response(service_type)
  @service_type = service_type
  @response = <<EOXML
<?xml version="1.0"?>
<rsp status="OK">
<method>#{@service_type}</method>
</rsp>
EOXML
end

def init_fail_response(service_type)
  @service_type = service_type
  @response = <<EOXML
<?xml version="1.0"?>
<rsp status="FAIL">
  <method>#{@service_type}</method>
  <message>You suck</message>
</rsp>
EOXML
end

def init_service_response
  @service_type = 'user.services'
  @response = <<EOXML
  <?xml version="1.0"?>
<rsp status="OK">
  <services>
    <service id="tw" name="twitter">
      <code>Ee6n</code>
      <inhome>checked</inhome>
      <friend>unchecked</friend>
      <collegue>unchecked</collegue>
    </service>
    <service id="fb" name="facebook">
      <code>XW7G</code>
      <inhome>checked</inhome>
      <friend>false</friend>
      <collegue>false</collegue>
    </service>
    <service id="jk" name="jaiku">
      <code>OK38</code>
      <inhome>checked</inhome>
      <friend>checked</friend>
      <collegue>unchecked</collegue>
    </service>
    <service id="id" name="identica">
      <code>IOZq</code>
      <inhome>checked</inhome>
      <friend>unchecked</friend>
      <collegue>unchecked</collegue>
    </service>
    <service id="rj" name="rejaw">
      <code>s46G</code>
      <inhome>checked</inhome>
      <friend>unchecked</friend>
      <collegue>unchecked</collegue>
    </service>
  </services>
</rsp>
EOXML
end

def init_friend_service_response
  @service_type = 'user.services'
  @response = <<EOXML
  <?xml version="1.0"?>
<rsp status="OK">
  <services>
    <service id="jk" name="jaiku">
      <code>OK38</code>
      <inhome>checked</inhome>
      <friend>checked</friend>
      <collegue>unchecked</collegue>
    </service>
  </services>
</rsp>
EOXML
end
