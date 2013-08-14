require_relative 'region/region'

module AwsSgAudit
  def region(place, &block)
    Region.new(place).instance_eval &block
  end
end
