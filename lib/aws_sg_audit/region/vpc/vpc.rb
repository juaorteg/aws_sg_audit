require_relative 'sgroup/sgroup'

module AwsSgAudit
  Vpc = Struct.new(:id, :client) do
    def sgroup(name, &block)
      SGroup.new(name, id, client).instance_eval &block
    end
  end
end