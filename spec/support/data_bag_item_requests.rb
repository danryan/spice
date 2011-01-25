def stub_data_bag_item_show(status=200)
  case status
  when 200
    stub_request(:get, "http://localhost:4000/data/users/adam").
      to_return(
        :status => status,
        :body => data_bag_item_show_response
      )
  when 404
    stub_request(:get, "http://localhost:4000/data/users/adam").
      to_return(
        :status => status,
        :body => data_bag_item_not_found
      )
  end
end


def stub_data_bag_item_create(status=201)
  case status
  when 201
    stub_request(:post, "http://localhost:4000/data/users").
      with(
        :body => data_bag_item_create_payload ).
      to_return(
        :status => status, 
        :body => data_bag_item_create_response
      )
  when 409
    stub_request(:post, "http://localhost:4000/data/users").
      with(
        :body => data_bag_item_create_payload ).
      to_return(
        :status => status, 
        :body => data_bag_item_conflict
      )
  when 404
    stub_request(:post, "http://localhost:4000/data/users").
      with(
        :body => data_bag_item_create_payload ).
      to_return(
        :status => status, 
        :body => data_bag_not_found
      )
  end
end

def stub_data_bag_item_update(status=200)
  case status
  when 200
    stub_request(:put, "http://localhost:4000/data/users/adam").
      with(
        :body => data_bag_item_update_payload ).
      to_return(
        :status => status, 
        :body => data_bag_item_update_response
      )
  when 404
    stub_request(:put, "http://localhost:4000/data/users/adam").
      with(
        :body => data_bag_item_update_payload ).
      to_return(
        :status => status, 
        :body => data_bag_item_not_found
      )
  end
end

def stub_data_bag_item_delete(status=200)
  case status
  when 200
    stub_request(:delete, "http://localhost:4000/data/users/adam").
      with(:body => "").
      to_return(
        :status => status,
        :body => data_bag_item_delete_response
      )
  when 404
    stub_request(:delete, "http://localhost:4000/data/users/adam").
      with(:body => "").
      to_return(
        :status => status,
        :body => data_bag_item_not_found
      )
  end
end

def data_bag_item_create_payload
  { "id" => "adam", "real_name" => "Adam Jacob" }
end

def data_bag_item_create_response
  { "id" => "adam",
    "data_bag" => "users",
    "chef_type" => "data_bag_item",
    "real_name" => "Adam Jacob" }
end

def data_bag_item_show_response
  { "name" => "users", "id" => "adam" }
end

def data_bag_item_update_payload
  { "title" => "Supreme Awesomer" }
end

def data_bag_item_update_response
  {
    "_rev" => "2-0f58b834949ce8a8b5f713bf8a525de7",
    "title" => "Supreme Awesomer",
    "id" => "adam",
    "data_bag" => "users",
    "chef_type" => "data_bag_item"
  }
end

def data_bag_item_delete_response
  { "name" => "data_bag_item_users_adam",
     "raw_data" => {
       "id" => "adam"
      },
     "json_class" => "Chef::DataBagItem",
     "data_bag" => "users",
     "chef_type" => "data_bag_item"
   } 
end

def data_bag_item_not_found
  { "error" => [ "Cannot load data bag users item adam" ] }
end

def data_bag_item_conflict
  { "error" => [ "Databag Item adam already exists" ] }
end

def data_bag_item_show_response
  { "real_name" => "Adam Jacob", "id" => "adam" }
end