# spice

Spice is a zesty Chef API wrapper. Its primary purpose is to let you easily integrate your apps with a (Chef)[http://opscode.com/chef] server easily.  Spice provides support for the [Chef API](http://wiki.opscode.com/display/chef/Server+API)

## Installation

Install this beast via Rubygems:

    gem install spice
    
Of course, You can always grab the source from http://github.com/danryan/spice.

## Configuration

Spice has four configuration variables: 

    Spice.server_url    # default: http://localhost:4000
	  Spice.chef_version	# default: 0.10.4. Should be set to the version you have
    Spice.client_name   # default: nil. Must be set to a valid admin Chef client
    Spice.key_file      # default: nil. Must be set to a file path

To connect to a Chef server at https://chef.example.com:5000 with the "admin" API client, throw this somewhere your app can initialize:

    Spice.server_url = "http://chef.example.com:4000"
    Spice.client_name = "admin"
    Spice.key_file = "/path/to/keyfile.pem"

Say you had a Chef server v0.10.4 running locally on port 4000 over HTTP, you only need to set your `client_name` and `key_file` path:

    Spice.client_name = "admin"
    Spice.key_file = "/path/to/keyfile.pem"


You can also use the Spice.setup block if you prefer this style:

    Spice.setup do |s|
      s.server_url = "http://chef.example.com:4000"
      s.client_name = "admin"
      s.key_file = "/path/to/keyfile.pem"
    end

Next, we need to create the connection object you'll use to sign your requests and pass them to the Chef server. Previous versions of Spice required you to explicitly call `Spice.connect!` to set up the connection object. If you use the `Spice.setup` block, it will call `.connect!` for you:

    Spice.connect!
    
If you want to reset your config to their default values:

    Spice.reset!
    
### Deprecation notice

Explicitly setting a `host`, `port`, and `scheme` value has been deprecated in favor of setting a single variable, `server_url`, which matches the format of Chef's client config parameter, `chef_server_url`. The old way of defining `host`, `port`, and `scheme` are still currently available but will be removed from future versions.

## Usage

### Low-level use

Setting up spice and running `Spice.connect!` creates a connection object that can then be used to send requests to your Chef server, accessed via `Spice.connection`.  

Get a list of all clients:

    Spice.connection.get("/clients")

Get a specific node by the name "slappypants":

    Spice.connection.get("/nodes/slappypants")
    
Create a new role called "awesome":

    Spice.connection.post("/roles", :name => "awesome")

Make the client "sweet" an admin:
    
    Spice.connection.put("/clients/sweet", :admin => true)

Read the wiki for more examples.


### Contributors

* [Ian Meyer](https://github.com/imeyer) - Opscode Platform support
* [Holger Just](https://github.com/meineerde) - Search functionality
* [Sean Porter](https://github.com/portertech) - Platform bug fixes

## Contributing to spice
 
* Check out the latest master to make sure the feature hasn't been implemented or the bug hasn't been fixed yet
* Check out the issue tracker to make sure someone already hasn't requested it and/or contributed it
* Fork the project
* Start a feature/bugfix branch
* Commit and push until you are happy with your contribution
* Make sure to add tests for it. This is important so I don't break it in a future version unintentionally.
* Please try not to mess with the Rakefile, version, or history. If you want to have your own version, or is otherwise necessary, that is fine, but please isolate to its own commit so I can cherry-pick around it.

## Copyright

Copyright (c) 2011 Dan Ryan. See LICENSE.txt for
further details.

