RSpec::Matchers.define :respond_with do |code|
  match do |response|
    response.code == code
  end
  
  failure_message_for_should do |code|
    "expected to respond_with #{code}"
  end
  
  failure_message_for_should_not do |code|
    "expected to not respond with #{code}"
  end
  
  description do
    "respond with #{code}"
  end
end

RSpec::Matchers.define :have_body do |body|
  match do |response|
    response.body == body
  end
  
  failure_message_for_should do |body|
    "expected to have a body of #{body}"
  end
  
  failure_message_for_should_not do |body|
    "expected to not have a body of #{body}"
  end
  
  description do
    "have a valid response body"
  end
end

# RSpec::Matchers.define :have_header do |header|
#   match do |response|
#     response.headers.has_key?(header.to_sym)
#   end
#   
#   failure_message_for_should do |header|
#     "expected to have a header #{header}"
#   end
#   
#   failure_message_for_should_not do |header|
#     "expected to not have a header #{header}"
#   end
#   
#   description do
#     "have a header #{header}"
#   end
# end