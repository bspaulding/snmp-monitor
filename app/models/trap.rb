# = Trap
#
# Author: Bradley J. Spaulding
#
# === Purpose
# Encapsulates an SNMP Trap received by the application. Upon creation,
# a notification is created and sent.
class Trap < ActiveRecord::Base
	belongs_to :agent
	
	after_create :send_notification
	
	private

	def send_notification
		Notifier.deliver_trap_notification(self)
	end
end
