require_relative 'vpc/vpc'

module AwsSgAudit
  class Region
    attr_reader :client

    def initialize(place)
      @client = ::CLIENT.regions[place].security_groups
    end

    def vpc(id, &block)
      Vpc.new(id, client).instance_eval &block
    end
  end
end