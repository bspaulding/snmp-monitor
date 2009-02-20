require 'snmp'

class TestController < ApplicationController
  def index
    @mibs = SNMP::MIB.list_imported
  end

end
