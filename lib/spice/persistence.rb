module Spice
  module Persistence
    def self.included(base)
      base.after_create :do_post
      base.after_update :do_put
      base.after_destroy :do_delete
    end

    def endpoint(ep=nil)
      @endpoint = ep if !ep.nil?
      @endpoint
    end

    def all(options={})
      connection.send(endpoint, options)
    end

    def get(options)
      connection.send(endpoint, options).first
    end

    def connection
      Spice.connection
    end

    def do_post
      response = connection.post("/#{self.class.endpoint}", attributes)
      update_attributes(response.body)
      response = connection.get("/#{self.class.endpoint}/#{name}")
      update_attributes(response.body)
    end

    def do_put
      connection.put("/#{self.class.endpoint}/#{name}", attributes)
    end

    def do_delete
      connection.delete("/#{self.class.endpoint}/#{name}")
    end

    def new_record?
      raise NotImplementedError, "Override this method in the class that includes this module."
    end
  end
end