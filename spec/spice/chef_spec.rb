module Spice
  describe Chef do
    describe "#initialize" do
    end
    
    describe '#connection' do
    end
    
    describe '.connection' do
      it ""
    end
    
    describe '#clients' do
      it "should return a list of all clients" do
        let(:clients) { Chef.clients }
      end
    end
    
    describe '#nodes' do
      it "should return a list of all nodes" do
        let(:nodes) { Chef.nodes }
      end
    end
    
    describe '#data_bags' do
      it "should return a list of all data bags" do
        let(:data_bags) { Chef.data_bags }
      end
    end
    
    describe '#roles' do
      it "should return a list of all roles" do
        let(:roles) { Chef.roles }
      end
    end
    
    describe '#cookbooks' do
      it "should return a list of all cookbooks" do
        let(:cookbooks) { Chef.cookbooks }
      end
    end
  end
end

module Spice
  class Chef
    attr_accessor :host, :client_name, :key_file, :port, :path, :scheme, :connection
    

    def initialize(options={})
      @client_name = options[:client_name] || Spice.client_name
      @key_file    = options[:key_file]    || Spice.key_file
      @host        = options[:host]        || Spice.host        
      @port        = options[:port]        || Spice.port
      @scheme      = options[:scheme]      || Spice.scheme
      @connection  = Connection.new(
                       :url => "#{@scheme}://#{@host}:#{@port}", 
                       :client_name => options[:client_name], 
                       :key_file => options[:key_file]
                     )                     || Spice.connection
      
      
      @default_headers = options[:headers] || {}
      @sign_on_redirect, @sign_request = true, true       
    end
    
    def connection
      @connection || Spice.connection
    end
    
    def self.connection
      @connection || Spice.connection
    end
    
    def clients
      Client.all
    end
    
    def nodes
      Node.all
    end
    
    def data_bags
      DataBag.all
    end