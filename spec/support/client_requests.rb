def stub_client_list
  stub_request(:get, "http://localhost:4000/clients").
  to_return(
    :status => 200,
    :body => client_list_response
  )
end

def stub_client_show(status=200)
  case status
  when 200
    stub_request(:get, "http://localhost:4000/clients/testclient").
      to_return(
        :status => status,
        :body => client_show_response
      )
  when 404
    stub_request(:get, "http://localhost:4000/clients/testclient").
      to_return(
        :status => status,
        :body => client_not_found
      )
  end
end

def stub_client_create(status=201)
  case status
  when 201
    stub_request(:post, "http://localhost:4000/clients").
      with(
        :body => client_create_payload ).
      to_return(
        :status => status, 
        :body => client_create_response
      )
  when 409
    stub_request(:post, "http://localhost:4000/clients").
      with(
        :body => client_create_payload ).
      to_return(
        :status => status, 
        :body => client_conflict
      )
  end
end

def stub_client_delete(status=200)
  case status
  when 200
    stub_request(:delete, "http://localhost:4000/clients/testclient").
      with(:body => "").
      to_return(
        :status => status,
        :body => client_delete_response
      )
  when 404
    stub_request(:delete, "http://localhost:4000/clients/testclient").
      with(:body => "").
      to_return(
        :status => status,
        :body => client_not_found
      )
  end
end

# payloads and responses

def client_list_response
  { "testclient" => "http://localhost:4000/clients/testclient" }
end

def client_show_response
  { "adam" => "http://localhost:4000/clients/testclient" }
end

def client_delete_response
  { "name" => "users", "json_class" => "Chef::Client", "chef_type" => "client" }
end

def client_not_found
  { "error" => [ "Could not load client testclient" ] }
end

def client_conflict
 { "error" => [ "Client already exists" ] }
end

def client_create_payload
  { "name" => "testclient" }
end

def client_create_response
  { "private_key"=>"-----BEGIN RSA PRIVATE KEY-----",
    "uri"=>"http://localhost:4000/clients/testclient" } 
end