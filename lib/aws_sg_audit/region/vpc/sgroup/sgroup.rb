require_relative 'type/type'

module AwsSgAudit
  class SGroup
    attr_reader :client, :group, :id

    def initialize(group, id, client)
      @client = client.filter('group-name', group.to_s).select{|name| id == name.vpc_id}.first
      puts "\n<-> #{@client.vpc_id} <->\n-> #{@client.name}" unless @client.nil?
      @group = group
      @id    = id
    end

    def type(name, &block)
      if client.nil?
        puts "\nCannot find #{group} in #{id}"
        return
      end
      Type.new(name, client).instance_eval &block
    end
  end
end