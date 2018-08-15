class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true
  validates :quantity, numericality: {greater_than: 0}
end
