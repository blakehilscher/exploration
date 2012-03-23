class FormItem < ActiveRecord::Base  
  belongs_to :form
  default_scope :order => :position
  
  def to_s
    (self.content) ? self.content : ''
  end
  
  def to_i
    (self.score) ? self.score : ''
  end
  
  def to_h
    { "#{position}" => {:content => to_s, :score => to_i} }
  end
  
end