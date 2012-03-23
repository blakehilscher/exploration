class Quotation < ActiveRecord::Base
  default_scope :order => "position ASC"
end
