# def stub_client_list(name="testclient")
#   stub_request(:get, "http://localhost:4000/clients").
#   to_return(
#     :status => 200,
#     :body => "{\"#{name}\":\"http://localhost:4000/clients/#{name}\"}",
#     :headers => {})
# end
# 
# def stub_client_show(name, status=200)
#   case status
#   when 200
#     stub_request(:get, "http://localhost:4000/clients/#{name}").
#       to_return(
#         :status => status,
#         :body => %Q{{"name": "#{name}",
#           "chef_type": "client",
#           "json_class": "Chef::ApiClient",
#           "public_key": "RSA PUBLIC KEY",
#           "_rev": "1-68532bf2122a54464db6ad65a24e2225",
#           "admin": true}
#         }
#       )
#   when 404
#     stub_request(:get, "http://localhost:4000/clients/#{name}").
#     to_return(
#       :status => status,
#       :body => "{\"error\":[\"Cannot load client #{name}\"]}")
#   end
# end
# 
# def stub_client_create(name, admin=false, status=201)
#   case status
#   when 201
#     stub_request(:post, "http://localhost:4000/clients").
#       with(
#         :body => "{\"name\":\"#{name}\",\"admin\":#{admin}}").
#       to_return(
#         :status => status, 
#         :body => %Q{
#           {
#           "private_key":"RSA PRIVATE KEY",
#           "uri":"http://http://localhost:4000/clients/#{name}"}
#         }, 
#         :headers => {}
#       )
#   when 409
#     stub_request(:post, "http://localhost:4000/clients").
#       with(
#         :body => "{\"name\":\"#{name}\",\"admin\":#{admin}}").
#       to_return(
#         :status => status, 
#         :body => %Q{
#           {
#           "private_key":"RSA PRIVATE KEY",
#           "uri":"http://http://localhost:4000/clients/#{name}"}
#         }, 
#         :headers => {}
#       )
#   end
# end
# 
# def stub_client_update(name, admin=false, private_key=false, status=200)
#   case status
#   when 200
#     stub_request(:put, "http://localhost:4000/clients/#{name}").
#       with(:body => "{\"admin\":#{admin},\"private_key\":#{private_key}}").
#       to_return(
#         :status => status,
#         :body => %Q{{#{"\"private_key\":\"RSA PRIVATE KEY\"," if private_key}\"admin\": true}
#         }
#       )
#   # when 404
#   #     stub_request(:get, "http://localhost:4000/clients/#{name}").
#   #     to_return(
#   #       :status => status,
#   #       :body => "{\"error\":[\"Cannot load client #{name}\"]}")
#   end
# end
# 
# def stub_client_delete(name, status=200)
#   case status
#   when 200
#     stub_request(:delete, "http://localhost:4000/clients/#{name}").
#       with(:body => "").
#       to_return(
#         :status => status,
#         :body => ""
#       )
#   when 404
#     stub_request(:delete, "http://localhost:4000/clients/#{name}").
#       with(:body => "").
#       to_return(
#         :status => status,
#         :body => "{\"error\":[\"Cannot load client sasdasdf\"]}"
#       )
#   end
# end