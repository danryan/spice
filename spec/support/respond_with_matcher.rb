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