#!/usr/examples/env ruby
require 'aws-sdk'
require 'aws_sg_audit'

include AwsSgAudit

CLIENT = AWS::EC2.new(
    access_key_id: '',
    secret_access_key: ''
)

# Important! Only works for Security Groups inside a VPC at the moment

# Region
region 'us-west-1' do

  # VPC ID
  vpc 'vpc-xxxxxxxx' do

    # Security Group Name
    sgroup :push do

      # Incoming
      type :ingress do

        # (String) - For CIDR
        from '55.44.33.22/32' do
          tcp SSH,HTTP,HTTPS
          udp DNS
        end

        # (Symbol) - For Groupname
        from :default do
          tcp SSH,HTTP
          icmp ECHO_REQUEST
        end
      end

      # Outgoing
      type :egress do

        # Use -all- for everything (default for outgoing on aws)
        to '0.0.0.0/0' do
          all
        end
      end
    end
  end
end

# =>

=begin

<-> vpc-xxxxxxxx <->
-> push

---> ingress
--------> 55.44.33.22/32
		MATCH! - tcp -> [22..22, 80..80, 443..443]

    NO MATCH! - udp -> [53..53]


---> egress
--------> 0.0.0.0/0
		MATCH! - all -> all

=end
