require_relative 'proto/proto'

module AwsSgAudit
  class Type
    attr_reader :client

    def initialize(action, client)
      puts
      puts "---> #{action}"
      @client = client.public_send("#{action.to_s}_ip_permissions")
    end

    # For now they do the same thing
    [:from, :to].each do |sd|
      define_method sd do |cidr, &block|
        Proto.new(cidr, client).instance_eval &block
      end
    end
  end
end