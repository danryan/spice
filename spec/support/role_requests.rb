def stub_role_list
  stub_request(:get, "http://localhost:4000/roles").
  to_return(
    :status => 200,
    :body => role_list_response
  )
end

def stub_role_show(status=200)
  case status
  when 200
    stub_request(:get, "http://localhost:4000/roles/testrole").
      to_return(
        :status => status,
        :body => role_show_response
      )
  when 404
    stub_request(:get, "http://localhost:4000/roles/testrole").
      to_return(
        :status => status,
        :body => role_not_found
      )
  end
end

def stub_role_create(status=201)
  case status
  when 201
    stub_request(:post, "http://localhost:4000/roles").
      with(
        :body => role_create_payload ).
      to_return(
        :status => status, 
        :body => role_create_response
      )
  when 409
    stub_request(:post, "http://localhost:4000/roles").
      with(
        :body => role_create_payload ).
      to_return(
        :status => status, 
        :body => role_conflict
      )
  end
end

def stub_role_delete(status=200)
  case status
  when 200
    stub_request(:delete, "http://localhost:4000/roles/testrole").
      with(:body => "").
      to_return(
        :status => status,
        :body => role_delete_response
      )
  when 404
    stub_request(:delete, "http://localhost:4000/roles/testrole").
      with(:body => "").
      to_return(
        :status => status,
        :body => role_not_found
      )
  end
end

# payloads and responses

def role_list_response
  { "testrole" => "http://localhost:4000/roles/testrole" }
end

def role_show_response
  { "adam" => "http://localhost:4000/roles/testrole" }
end

def role_delete_response
  { "name" => "users", "json_class" => "Chef::Role", "chef_type" => "role" }
end

def role_not_found
  { "error" => [ "Could not load role testrole" ] }
end

def role_conflict
 { "error" => [ "Role already exists" ] }
end

def role_create_payload
  { "name" => "testrole" }
end

def role_create_response
  { "private_key"=>"-----BEGIN RSA PRIVATE KEY-----",
    "uri"=>"http://localhost:4000/roles/testrole" } 
end