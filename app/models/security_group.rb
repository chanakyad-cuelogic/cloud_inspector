class SecurityGroup < ActiveRecord::Base

	def self.fetch_all_sgs(compute)
		compute.security_groups.all
	end

	def self.fetch_all_inbound_rule(sgs)
		sgs.each do |sg|
			inbound_rules = SecurityGroup.get_formatted_ip_permissions(sg.ip_permissions)
			puts "inbound_rules #{inbound_rules}"
		end
	end


	def self.get_formatted_ip_permissions(ip_permissions)
    	return ip_permissions unless ip_permissions.is_a?(Array)
    	ip_permissions.inject([]) do |final_arr, ip_permission|
      		final_arr = SecurityGroup.get_ip_permission_array(ip_permission, 'ipRanges', 'groups', final_arr)
      		get_ip_permission_array(ip_permission, 'groups', 'ipRanges', final_arr)
    	end
  	end

  	def self.get_ip_permission_array(ip_permission, key, blank_value_key, final_arr)
    	if ip_permission[key].is_a?(Array) && ip_permission[key].present?
	      	ip_permission[key].each do |permission_attr|
	        	new_hash = ip_permission.dup
	        	new_hash[key] = [permission_attr]
	        	new_hash[blank_value_key] = []
	        	new_hash["status"] = SecurityGroup.get_status_of_permissions(new_hash)
	        	final_arr << new_hash
	      	end
    	end
    	final_arr
  	end

  	def self.get_status_of_permissions(ip_permission_hash)
  		puts "ip_permission_hash #{ip_permission_hash["ipRanges"]}"
  		fromPort = ip_permission_hash["fromPort"]
      toPort = ip_permission_hash["toPort"]
  		unless ip_permission_hash["ipRanges"][0].blank?
  			cidr_ip = ip_permission_hash["ipRanges"][0]["cidrIp"]
  		else
  			cidr_ip = ""
  		end
      if (fromPort == 80 && toPort == 80) || (fromPort == 443 && toPort == 443)
        0
  		elsif cidr_ip == "0.0.0.0/0" && !((fromPort == 80 && toPort == 80) || (fromPort == 443 && toPort == 443))
  			1
  		else
  			2
  		end
  	end
end
