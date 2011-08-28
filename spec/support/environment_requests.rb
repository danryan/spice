def stub_environment_list
  stub_request(:get, "http://localhost:4000/environments").
  to_return(
    :status => 200,
    :body => environment_list_response
  )
end

def stub_environment_show(status=200)
  case status
  when 200
    stub_request(:get, "http://localhost:4000/environments/dev").
      to_return(
        :status => status,
        :body => environment_show_response
      )
  when 404
    stub_request(:get, "http://localhost:4000/environments/dev").
      to_return(
        :status => status,
        :body => environment_not_found
      )
  end
end

def stub_environment_create(status=201)
  case status
  when 201
    stub_request(:post, "http://localhost:4000/environments").
      with(
        :body => environment_create_payload ).
      to_return(
        :status => status, 
        :body => environment_create_response
      )
  when 409
    stub_request(:post, "http://localhost:4000/environments").
      with(
        :body => environment_create_payload ).
      to_return(
        :status => status, 
        :body => environment_conflict
      )
  end
end

def stub_environment_update(status=200)
  case status
  when 200
    stub_request(:post, "http://localhost:4000/environments/dev").
      with(
        :body => environment_udpate_payload ).
      to_return(
        :status => status, 
        :body => environment_update_response
      )
  when 404
    stub_request(:post, "http://localhost:4000/environments/dev").
      with(
        :body => environment_update_payload ).
      to_return(
        :status => status, 
        :body => environment_not_found
      )
  end
end

def stub_environment_delete(status=200)
  case status
  when 200
    stub_request(:delete, "http://localhost:4000/environments/dev").
      with(:body => "").
      to_return(
        :status => status,
        :body => environment_delete_response
      )
  when 404
    stub_request(:delete, "http://localhost:4000/environments/dev").
      with(:body => "").
      to_return(
        :status => status,
        :body => environment_not_found
      )
  end
end

def stub_environment_cookbooks_list
  stub_request(:get, "http://localhost:4000/environments/dev/cookbooks").
  to_return(
    :status => 200,
    :body => environment_cookbooks_list_response
  )
end

def stub_environment_cookbook_show(status=200)
  case status
  when 200
    stub_request(:get, "http://localhost:4000/environments/dev/cookbooks/apache").
      to_return(
        :status => status,
        :body => environment_cookbook_show_response
      )
  when 404
    stub_request(:get, "http://localhost:4000/environments/dev/cookbooks/apache").
      to_return(
        :status => status,
        :body => environment_not_found
      )
  end
end


# payloads and responses

def environment_list_response
  { "webserver" => "http://localhost:4000/environments/webserver" }
end

def environment_show_response
  {
    "name" => "dev",
    "attributes" => {
    },
    "json_class" => "Chef::Environment",
    "description" => "",
    "cookbook_versions" => {
    },
    "chef_type" => "environment"
  }
end

def environment_create_response
  { "uri" => "http://localhost:4000/environments/dev" }
end

def environment_delete_response
  {
    "name" => "dev",
    "attributes" => {
    },
    "json_class" => "Chef::Environment",
    "description" => "",
    "cookbook_versions" => {
    },
    "chef_type" => "environment"
  }
end

def environment_update_response  
  {
    "name" => "dev",
    "attributes" => {
    },
    "json_class" => "Chef::Environment",
    "description" => "The Dev Environment",
    "cookbook_versions" => {
    },
    "chef_type" => "environment"
  }
end


def environment_cookbooks_list_response
  {
    "apache2" => {
      "url" => "http://localhost:4000/cookbooks/apache2",
      "versions" => [
        { "url" => "http://localhost:4000/cookbooks/apache2/5.1.0", "version" => "5.1.0" },
        { "url" => "http://localhost:4000/cookbooks/apache2/4.2.0", "version" => "4.2.0" }
      ]
    },
    "nginx" => {
      "url" => "http://localhost:4000/cookbooks/nginx",
      "versions" => [
        { "url" => "http://localhost:4000/cookbooks/nginx/1.0.0", "version" => "1.0.0" },
        { "url" => "http://localhost:4000/cookbooks/nginx/0.3.0", "version" => "0.3.0" }
      ]
    }
  }
end

def environment_cookbook_show_response
  {
    "apache2" => {
      "url" => "http://localhost:4000/cookbooks/apache2",
      "versions" => [
        { "url" => "http://localhost:4000/cookbooks/apache2/5.1.0", "version" => "5.1.0" },
        {"url" => "http://localhost:4000/cookbooks/apache2/4.2.0", "version" => "4.2.0" }
      ]
    }
  }
end

def environment_not_found
  { "error" => [ "Could not load environment env" ] }
end

def environment_cookbook_not_found
  { "error" => [ "Could not load environment env cookbook apache" ] }
end

def environment_conflict
 { "error" => [ "environments bag already exists" ] }
end

def environment_create_payload
  {
    "name" => "dev",
    "attributes" => {
    },
    "json_class" => "Chef::Environment",
    "description" => "",
    "cookbook_versions" => {
    },
    "chef_type" => "environment"
  }
end

def environment_update_payload
  { "description" => "The Dev Environment" }
end
