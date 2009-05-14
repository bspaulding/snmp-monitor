class DataRecord < ActiveRecord::Base
	belongs_to :mib_object
	belongs_to :agent
end
