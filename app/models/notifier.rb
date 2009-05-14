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
