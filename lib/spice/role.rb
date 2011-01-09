module Spice
  class Role < Spice::Chef
    def self.all(options={})
      connection.get("/roles")
    end
    
    def self.[](name)
      connection.get("/roles/#{name}")
    end
    
    def self.show(options={})
      name = options.delete(:name)
      connection.get("/roles/#{name}")
    end
    
    def self.create(options={})
      connection.post("/roles", options)
    end
    
    def self.update(options={})
      name = options.delete(:name)
      connection.put("/roles/#{name}", options)
    end
    
    def self.delete(options={})
      name = options.delete(:name)
      connection.delete("/roles/#{name}")
    end
  end
end