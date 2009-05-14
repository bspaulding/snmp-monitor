# = Agent
#
# Author: Bradley J. Spaulding
#
# === Purpose
# Notifier encapsulates an email notification. 
# These are currently only generated when a Trap is created.
# TODO: This notification is currently completely static. 
#				There needs to be a mechanism for configuring who gets notifications.
class Notifier < ActionMailer::Base
	def trap_notification(snmptrap)
		recipients	"brad.spaulding@gmail.com"
		from 				"brad.spaulding@gmail.com"
		subject			"SNMP Trap Received"
		body				notification_body(snmptrap)
	end
	
	private
	
	def notification_body(snmptrap)
		"SNMP Trap Received\n\n"
	end
end
