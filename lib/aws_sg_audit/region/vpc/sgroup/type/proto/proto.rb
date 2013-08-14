module AwsSgAudit
  class Proto
    attr_reader :cidr, :client

    def initialize(cidr, client)
      if cidr.is_a? Symbol
        @client = client.select{|perm| perm.groups.map(&:name).collect{|group| group == cidr.to_s }.first unless perm.groups.empty? }
      elsif cidr.is_a? String
        @client = client.select{|perm| perm.ip_ranges.include?(cidr) unless perm.ip_ranges.empty? }
      else
        raise 'ERROR: from/to need a symbol or string argument.'
      end
      @cidr = cidr
      puts "--------> #{cidr}"
    end

    # Need to clean this up
    [:all, :icmp, :tcp, :udp].each do |trans|
      define_method trans do |*args|
        found_ports = []
        args.each do |assumed_ports|
          client.each do |perm|
            protocol = perm.protocol
            ports = perm.port_range
            if (protocol == __method__.to_sym and assumed_ports == ports) or (protocol == :any and ports.nil?)
              found_ports << ports
            end
          end
        end
        not_found = args - found_ports
        found_ports.select!{|port| args.include? port}
        found_ports = 'all' if args.empty?
        puts "\t\tMATCH! - #{__method__} -> #{found_ports}" unless found_ports.empty?
        puts "\t\tNO MATCH! - #{__method__} -> #{not_found}" unless not_found.empty?
        puts
      end
    end
  end
end