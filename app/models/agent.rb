require 'snmp'

class Agent < ActiveRecord::Base
  DEFAULT_MIBS = ["SNMPv2-SMI", "SNMPv2-MIB", "IF-MIB", "IP-MIB", "TCP-MIB", "UDP-MIB"]
  
  serialize :mibs, Array
  before_create :set_defaults
  
  def manager(options = {})
    options[:Host] = ip_address
    options[:Community] = community
    SNMP::Manager.new(options)
  end
  
  private
  
  def set_defaults
    self.name = "Unnamed" if name.nil?
    self.ip_address = "127.0.0.1" if ip_address.nil?
    self.mibs = DEFAULT_MIBS if mibs.nil?
  end
end
