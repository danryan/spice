def stub_cookbook_list
  stub_request(:get, "http://localhost:4000/cookbooks").
  to_return(
    :status => 200,
    :body => cookbook_list_response
  )
end

def stub_cookbook_show(status=200)
  case status
  when 200
    stub_request(:get, "http://localhost:4000/cookbooks/testcookbook").
      to_return(
        :status => status,
        :body => cookbook_show_response
      )
  when 404
    stub_request(:get, "http://localhost:4000/cookbooks/testcookbook").
      to_return(
        :status => status,
        :body => cookbook_not_found
      )
  end
end

def stub_cookbook_create(status=201)
  case status
  when 201
    stub_request(:post, "http://localhost:4000/cookbooks").
      with(
        :body => cookbook_create_payload ).
      to_return(
        :status => status, 
        :body => cookbook_create_response
      )
  when 409
    stub_request(:post, "http://localhost:4000/cookbooks").
      with(
        :body => cookbook_create_payload ).
      to_return(
        :status => status, 
        :body => cookbook_conflict
      )
  end
end

def stub_cookbook_delete(status=200)
  case status
  when 200
    stub_request(:delete, "http://localhost:4000/cookbooks/testcookbook").
      with(:body => "").
      to_return(
        :status => status,
        :body => cookbook_delete_response
      )
  when 404
    stub_request(:delete, "http://localhost:4000/cookbooks/testcookbook").
      with(:body => "").
      to_return(
        :status => status,
        :body => cookbook_not_found
      )
  end
end

# payloads and responses

def cookbook_list_response
  { "testcookbook" => "http://localhost:4000/cookbooks/testcookbook" }
end

def cookbook_show_response
  { "adam" => "http://localhost:4000/cookbooks/testcookbook" }
end

def cookbook_delete_response
  { "name" => "users", "json_class" => "Chef::Cookbook", "chef_type" => "cookbook" }
end

def cookbook_not_found
  { "error" => [ "Could not load cookbook testcookbook" ] }
end

def cookbook_conflict
 { "error" => [ "Cookbook already exists" ] }
end

def cookbook_create_payload
  { "name" => "testcookbook" }
end

def cookbook_create_response
  { "private_key"=>"-----BEGIN RSA PRIVATE KEY-----",
    "uri"=>"http://localhost:4000/cookbooks/testcookbook" } 
end