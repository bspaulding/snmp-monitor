require 'snmp'

class Agent < ActiveRecord::Base  
	extend ActiveSupport::Memoizable
	
  # Associations
  has_and_belongs_to_many :mibs
  has_many :data_records
  
  # Validations
  validates_presence_of :ip_address, :community
  
  before_create :set_defaults
  
  # Named Scopes
  named_scope :favorites, :conditions => {:favorite => true}
	
	def self.down
		Agent.with_status("Down")
	end

	def self.testing
		Agent.with_status("Testing")
	end
	
	def self.up
		Agent.with_status("Up")
	end
	
	def self.with_status(status)
		resulting_agents = []
		Agent.all.each do |agent|
			if agent.status == status
				resulting_agents << agent
			end
		end
		resulting_agents
	end
	
  # Constants
  DEFAULT_MIB_NAMES = ["SNMPv2-SMI", "SNMPv2-MIB", "IF-MIB", "IP-MIB", "TCP-MIB", "UDP-MIB"]
  
  OID_NAMES = {
  							"1.3.6.1.2.1.2.2.1.1" => "ifIndex",
  							"1.3.6.1.2.1.2.2.1.2" => "ifDescr",
  							"1.3.6.1.2.1.2.2.1.3" => "ifType",
  							"1.3.6.1.2.1.2.2.1.4" => "ifMtu",
  							"1.3.6.1.2.1.2.2.1.5" => "ifSpeed",
  							"1.3.6.1.2.1.2.2.1.6" => "ifPhysAddress",
  							"1.3.6.1.2.1.2.2.1.7" => "ifAdminStatus",
  							"1.3.6.1.2.1.2.2.1.8" => "ifOperStatus",
  							"1.3.6.1.2.1.2.2.1.9" => "ifLastChange",
  							"1.3.6.1.2.1.2.2.1.10" => "ifInOctets",
  							"1.3.6.1.2.1.2.2.1.11" => "ifInUcastPkts",
  							"1.3.6.1.2.1.2.2.1.12" => "ifInNUcastPkts",
  							"1.3.6.1.2.1.2.2.1.13" => "ifInDiscards",
  							"1.3.6.1.2.1.2.2.1.14" => "ifInErrors",
  							"1.3.6.1.2.1.2.2.1.15" => "ifInUnknownProtos",
  							"1.3.6.1.2.1.2.2.1.16" => "ifOutOctets",
  							"1.3.6.1.2.1.2.2.1.17" => "ifOutUcastPkts",
  							"1.3.6.1.2.1.2.2.1.18" => "ifOutNUcastPkts",
  							"1.3.6.1.2.1.2.2.1.19" => "ifOutDiscards",
  							"1.3.6.1.2.1.2.2.1.20" => "ifOutErrors",
  							"1.3.6.1.2.1.2.2.1.21" => "ifOutQLen",
  							"1.3.6.1.2.1.2.2.1.22" => "ifSpecific"
  						}
  
  IF_TYPES = {	
  							1 => "other",
  							2 => "regular1822",
  							3 => "hdh1822",
  							4 => "ddn-x25",
  							5 => "rfc877-x25",
  							6 => "ethernetCsmacd",
  							7 => "iso88023Csmacd",
  							8 => "iso88024TokenBus",
  							9 => "iso88025TokenRing",
  							10 => "iso88026Man",
  							11 => "starLan",
  							12 => "proteon-10Mbit",
  							13 => "proteon-80Mbit",
  							14 => "hyperchannel",
  							15 => "fddi",
  							16 => "lapb",
  							17 => "sdlc",
  							18 => "dsl",
  							19 => "el",
  							20 => "basicISDN",
  							21 => "primaryISDN",
  							22 => "propPointToPointSerial",
  							23 => "ppp",
  							24 => "softwareLoopback",
  							25 => "eon",
  							26 => "ethernet-3Mbit",
  							27 => "nsip",
  							28 => "slip",
  							29 => "ultra",
  							30 => "ds3",
  							31 => "sip",
  							32 => "frame-relay",
  							33 => "rs232",
  							34 => "para",
  							35 => "arcnet",
  							36 => "arcnetPlus",
  							37 => "atm",
  							38 => "miox25",
  							39 => "sonet",
  							40 => "x25ple",
  							41 => "iso880211c",
  							42 => "localTalk",
  							43 => "smdsDxi",
  							44 => "frameRelayService",
  							45 => "v35",
  							46 => "hssi",
  							47 => "hippi",
  							48 => "modem",
  							49 => "aa15",
  							50 => "sonetPath",
  							51 => "sonetVT",
  							52 => "smdsIcip",
  							53 => "propVirtual",
  							54 => "propMultiplexor",
  							55 => "ieee80212",
								56 => "fibreChannel",
								57 => "hippiInterface",
								58 => "frameRelayInterconnect",
								59 => "aflane8023",
								60 => "aflane8025",
								61 => "cctEmul",
								62 => "fastEther",
								63 => "isdn",
								64 => "v11",
								65 => "v36",
								66 => "g703at64k",
								67 => "g703at2mb",
								68 => "qllc",
								69 => "fastEtherFX",
								70 => "channel",
								71 => "ieee80211",
								72 => "ibm370parChan",
								73 => "escon",
								74 => "dlsw",
								75 => "isdns",
								76 => "isdnu",
								77 => "lapd",
								78 => "ipSwitch",
								79 => "rsrb",
								100 => "voiceEM",
								101 => "voiceFXO",
								102 => "voiceFXS",
								103 => "voiceEncap",
								104 => "voiceOverIp",
								105 => "atmDxi",
								106 => "atmFuni",
								107 => "atmIma",
								108 => "pppMultilinkBundle",
								109 => "ipOverCdlc",
								140 => "dtm",
								141 => "dcn",
								142 => "ipForward",
								143 => "msdsl",
								144 => "ieee1394",
								145 => "if-gsn",
								146 => "dvbRccMacLayer",
								147 => "dvbRccDownstream",
								148 => "dvbRccUpstream",
								149 => "atmVirtual",
								150 => "mplsTunnel",
								151 => "srp",
								152 => "voiceOverAtm",
								153 => "voiceOverFrameRelay",
								154 => "idsl",
								155 => "compositeLink",
								156 => "ss7SigLink",
								157 => "propWirelessP2P",
								158 => "frForward",
								159 => "rfc1483",
								160 => "usb",
								161 => "ieee8023adLag",
								162 => "bgppolicyaccounting",
								163 => "frf16MfrBundle",
								164 => "h323Gatekeeper",
								165 => "h323Proxy",
								166 => "mpls",
								167 => "mfSigLink",
								168 => "hdsl2",
								169 => "shdsl",
								170 => "ds1FDL",
								171 => "pos",
								172 => "dvbAsiIn",
								173 => "dvbAsiOut",
								174 => "plc",
								175 => "nfas",
								176 => "tr008",
								177 => "gr303RDT",
								178 => "gr303IDT",
								179 => "isup",
								180 => "propDocsWirelessMaclayer",
								181 => "propDocsWirelessDownstream",
								182 => "182",
								210 => "linegroup",
								211 => "voiceEMFGD",
								212 => "voiceFGDEANA",
								213 => "voiceDID",
								214 => "mpegTransport",
								215 => "sixToFour",
								216 => "gtp",
								217 => "pdnEtherLoop1",
								218 => "pdnEtherLoop2",
								219 => "opticalChannelGroup",
								220 => "homepna",
								221 => "gfp",
								222 => "ciscoISLvlan",
								223 => "actelisMetaLOOP",
								224 => "fcipLink",
								225 => "rpr",
								226 => "qam",
								227 => "lmp",
								228 => "cblVectaStar",
								229 => "docsCableMCmtsDownstream",
								230 => "adsl2",
								231 => "macSecControlledIF",
								232 => "macSecUncontrolledIF",
								233 => "aviciOpticalEther",
								234 => "atmbond"
  					 }
  
  IF_COLUMNS =	[	"ifIndex", "ifDescr", "ifType", "ifMtu", "ifSpeed", "ifPhysAddress", 
  								"ifAdminStatus", "ifOperStatus", "ifLastChange", "ifInOctets", "ifInUcastPkts",
  								"ifInNUcastPkts", "ifInDiscards", "ifInErrors", "ifInUnknownProtos", "ifOutOctets",
  								"ifOutUcastPkts", "ifOutNUcastPkts", "ifOutDiscards", "ifOutErrors", "ifOutQLen", "ifSpecific"
  							]
  
  STATUS =	{
							1 => "Up",
							2 => "Down",
							3 => "Testing"  
  					}
  
  #== Public Methods
  def sys_name
  	result = ""
  	begin
	  	result = manager.get(["1.3.6.1.2.1.1.5.0"]).varbind_list[0].value
	  rescue
	  	result = "Error"
	  end
	  result
  end
  
  def sys_location
	  result = ""
  	begin
  		result = manager.get(["1.3.6.1.2.1.1.6.0"]).varbind_list[0].value
  	rescue
	  	result = "Error"
	  end
	  result
  end
  
  def sys_contact
	  result = ""
  	begin
	  	result = manager.get(["1.3.6.1.2.1.1.4.0"]).varbind_list[0].value
	  rescue
	  	result = "Error"
	  end
	  result
  end
  
  def status
  	begin
	  	result = manager.walk(["ifAdminStatus", "ifOperStatus"]) do |row|
	  		row.each do |vb|
	  			Rails.logger.info "#{vb.name} => #{vb.value}"
	  			if vb.value == 2
	  				return "Down"
	  			elsif vb.value == 3
	  				return "Testing"
	  			end
	  		end
	  	end
	  rescue
	  	result = "Error"
	  end
	  return "Up"
  end
  memoize :status
  
  def sys_uptime
	  result = ""
  	begin
	  	result = manager.get(["1.3.6.1.2.1.1.3.0"]).varbind_list[0].value.to_s
	  rescue
	  	result = "Error"
	  end
	  result
  end
  
  # Walk the Agent's iftable with the specified columns, or the defaults.
  #
  # Returns a 2d Array, so as to easily tableize the results
  def iftable_walk(columns = IF_COLUMNS)
  	result = []
  	begin
	  	result << columns
	  	manager.walk(columns) do |row|
	  		result << row.collect {|vb| 
	  			Rails.logger.info "vb.name = #{vb.name}, vb.value = #{vb.value}"
	  			base_oid = vb.name.to_s.split('.')[0..9].join('.')
	  			#Rails.logger.info "base_oid = #{base_oid}"
	  			if base_oid == "1.3.6.1.2.1.2.2.1.3"
	  					insertable = IF_TYPES[vb.value.to_i]
	  			elsif base_oid == "1.3.6.1.2.1.2.2.1.6"
	  					insertable = vb.value.to_mac
	  			else
	  					insertable = vb.value
	  			end
	  			#Rails.logger.info "vb.value = #{insertable}"
	  			insertable
	  		}
	  	end
		rescue SNMP::RequestTimeout
			result = ["Request to Agent Timed Out."]
		end
		Rails.logger.info "result.class = #{result.class}"
		result
  end
  
  # Simplified and Specific implementation of the walk.
  # Groups by interface.
  def interfaces
  	result = {}
  	begin
	  	manager.walk(IF_COLUMNS) do |interface|
	  		interface.each do |vb|
	  			index = vb.name.to_s.split('.')[-1].to_i
	  			if result[index].nil?
	  				result[index] = []
	  			end
	  			base_oid = vb.name.to_s.split('.')[0..-2].join('.')
	  			if base_oid == "1.3.6.1.2.1.2.2.1.3"
	  					vb_value = IF_TYPES[vb.value.to_i]
	  			elsif base_oid == "1.3.6.1.2.1.2.2.1.6"
	  					vb_value = vb.value.to_mac
	  			else
	  					vb_value = vb.value
	  			end
	  			result[index] << [OID_NAMES[base_oid], vb_value]
	  		end
	  	end
		rescue SNMP::RequestTimeout
			result = "Request to Agent Timed Out."
		end
		result.sort
  end
  
  private
	
	def manager(options = {})
    @manager ||= create_manager(options = {})
  end
  
  def create_manager(options = {})
  	options[:Host] = ip_address
    options[:Community] = community
    options[:MibModules] = mibs.collect {|mib| mib.name}
    SNMP::Manager.new(options)
  end
  
  def set_defaults
    self.name = "Unnamed" if name.nil?
    self.ip_address = "127.0.0.1" if ip_address.nil?
    if self.mibs.empty? 
    	DEFAULT_MIB_NAMES.each do |mib_name|
    		self.mibs << Mib.find_or_create_by_name(mib_name)
    	end
    end
  end
end
