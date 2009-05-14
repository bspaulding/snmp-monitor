class Mib < ActiveRecord::Base
	has_and_belongs_to_many :agents
	has_many :mib_objects
end
