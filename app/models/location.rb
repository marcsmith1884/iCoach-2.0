class Location < ApplicationRecord
    
    validates :name, presence: true, uniqueness: true
    validates :name, uniqueness: { case_sensitive: false }
    validates :duration, numericality: {greater_than_or_equal_to: 0, less_than_or_equal_to: 180}
    
    
    def to_s
     name
    end

end
