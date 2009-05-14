class MibObject < ActiveRecord::Base
	belongs_to :mib
	has_many :data_records
end
