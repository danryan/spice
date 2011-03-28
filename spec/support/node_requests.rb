def stub_node_list
  stub_request(:get, "http://localhost:4000/nodes").
  to_return(
    :status => 200,
    :body => node_list_response
  )
end

def stub_node_show(status=200)
  case status
  when 200
    stub_request(:get, "http://localhost:4000/nodes/testnode").
      to_return(
        :status => status,
        :body => node_show_response
      )
  when 404
    stub_request(:get, "http://localhost:4000/nodes/testnode").
      to_return(
        :status => status,
        :body => node_not_found
      )
  end
end

def stub_node_create(status=201)
  case status
  when 201
    stub_request(:post, "http://localhost:4000/nodes").
      with(
        :body => node_create_payload ).
      to_return(
        :status => status, 
        :body => node_create_response
      )
  when 409
    stub_request(:post, "http://localhost:4000/nodes").
      with(
        :body => node_create_payload ).
      to_return(
        :status => status, 
        :body => node_conflict
      )
  end
end

def stub_node_create_with_run_list
  stub_request(:post, "http://localhost:4000/nodes").
    with(
      :body => node_create_payload_with_run_list ).
    to_return(
      :status => 201, 
      :body => node_create_response_with_run_list
    )
end

def stub_node_delete(status=200)
  case status
  when 200
    stub_request(:delete, "http://localhost:4000/nodes/testnode").
      with(:body => "").
      to_return(
        :status => status,
        :body => node_delete_response
      )
  when 404
    stub_request(:delete, "http://localhost:4000/nodes/testnode").
      with(:body => "").
      to_return(
        :status => status,
        :body => node_not_found
      )
  end
end

# payloads and responses

def node_list_response
  { "testnode" => "http://localhost:4000/nodes/testnode" }
end

def node_show_response
  { "adam" => "http://localhost:4000/nodes/testnode" }
end

def node_delete_response
  {
    "normal" => {},
    "name" => "foo",
    "override" => {},
    "default" => {},
    "json_class" => "Chef::Node",
    "automatic" => {},
    "run_list" => [],
    "chef_type" => "node"
  }
end

def node_not_found
  { "error" => [ "Could not load node testnode" ] }
end

def node_conflict
 { "error" => [ "Node already exists" ] }
end

def node_create_payload
  {
    "name" => "testnode",
    "chef_type" => "node",
    "json_class" => "Chef::Node",
    "attributes" => {},
    "overrides" => {},
    "defaults" => {},
    "run_list" => []
  }
end

def node_create_payload_with_run_list
  {
    "name" => "testnode",
    "chef_type" => "node",
    "json_class" => "Chef::Node",
    "attributes" => {},
    "overrides" => {},
    "defaults" => {},
    "run_list" => [ "recipe[unicorn]" ]
  }
end

def node_create_response_with_run_list
  { "uri" => "http://localhost:4000/nodes/testnode" }
end

def node_create_response
  { "private_key"=>"-----BEGIN RSA PRIVATE KEY-----",
    "uri"=>"http://localhost:4000/nodes/testnode" } 
end