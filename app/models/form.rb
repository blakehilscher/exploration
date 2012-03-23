class Form < ActiveRecord::Base  
  
  acts_as_list
  has_many :form_items, :dependent => :delete_all, :order => :position
  
  default_scope :order => "created_at DESC"
  
  after_save :save_items
  after_save :update_previous_item_changes
  
  after_initialize :configure
  
  def configure
   # defaults + merge inherited config
   @config = {
     :admin_approved => {:count => 1},
     :email        =>  {:count => 1},
   }.merge(@config || {})
   # create virtual getters & setters
   create_accessors
  end

  def default_values
   # Example: {:document => {:content => 'example'}, :another => {'1' => {:content => 'first', :score => 10}, '2' => {:content => 'second', :score => 5} }}
   {}
  end
  
  # return items config
  def config
   @config
  end
  
  def items
    form_items
  end
  
  # PUBLIC DIRTY && CHANGED

  def item_changes
   (@item_changes || {})
  end

  def items_changed?
   !item_changes.blank?
  end

  def item_changed?(*args)
   has_this_changed?(item_changes, args.first.to_s, args.extract_options!)
  end

  def previous_item_changes
   (@previous_item_changes || {})
  end

  def previous_items_changed?
   !previous_item_changes.blank?
  end

  def previous_item_changed?(*args)
   has_this_changed?(previous_item_changes, args.first.to_s, args.extract_options!)
  end




  private
  
  def save_items
   return until items_changed?
   item_changes.each do |item_type, change_list|
     items = self.send(item_type)
     if items.blank?
       next
     elsif items.is_a?(Array)
       change_list.each{|position, changes| items.detect{|i| i.position == position.to_i}.save}
     else
       items.save 
     end
   end
  end

  # DIRTY && CHANGED

  def item_attribute_change(item)
   if item.changed?
     # change format varries
     changes = (config[item.item_type.to_sym][:count] > 1) ? {item.position.to_s => item.changes} : item.changes
     # record changes
     @item_changes = (@item_changes || {})
     @item_changes[item.item_type.to_s] = (@item_changes[item.item_type.to_s] || {}).merge(changes)
   end
  end

  def update_previous_item_changes
   @previous_item_changes = item_changes
   @item_changes = {}
  end

  def has_this_changed?(items, item_type, options)
   return false while items.blank? || item_type.blank?
   options.assert_valid_keys(:position, :column)
   if !items.has_key?(item_type)
     return false
   elsif options.has_key?(:position) && options.has_key?(:column)
     return false unless items[item_type].has_key?(options[:position].to_s) && items[item_type][options[:position].to_s].has_key?(options[:column].to_s)
   elsif options.has_key?(:position)
     return false unless items[item_type].has_key?(options[:position].to_s)
   elsif options.has_key?(:column)
     return false unless items[item_type].has_key?(options[:column].to_s)
   end
   return true
  end


  # GETTERS && SETTERS

  def create_accessors
   @config.each do |item_type, options|
     if options[:count] <= 1
       create_item_accessors item_type
     else  
       create_list_accessors item_type
     end
     create_dirty_accessors item_type
   end
  end

  def create_item_accessors(accessors)
   accessor = accessors.to_s.singularize
   # Getter and setters
   class_eval <<-END, __FILE__, (__LINE__+1)
     def #{accessors}
       item_getter('#{accessors}')
     end
     def #{accessors}=(attributes)
       item_setter('#{accessors}', attributes)
     end
   END
   # Convenience getters and setters for item attributes
   [:content, :score, :note, :checked].each do |attribute_type|
     class_eval <<-END, __FILE__, (__LINE__+1)
       def #{accessor}_#{attribute_type.to_s}
         item_attribute_getter('#{accessors}', '#{attribute_type}')
       end
       def #{accessor}_#{attribute_type.to_s}=(attribute)
         item_attribute_setter('#{accessors}', '#{attribute_type}', attribute)
       end
     END
   end

  end

  def create_list_accessors(accessors)
   accessor = accessors.to_s.singularize
   # Items getter and setters
   class_eval <<-END, __FILE__, (__LINE__+1)
     def #{accessors}
       items_getter('#{accessors}')
     end
     def #{accessors}=(collection_of_attributes)
       items_setter('#{accessors}', collection_of_attributes)
     end
   END
   # Convenience getters and setters for item attributes
   [:content, :score, :note, :checked].each do |attribute_type|
     class_eval <<-END, __FILE__, (__LINE__+1)
       def #{accessor}_#{attribute_type.to_s.pluralize}
         collection_of_item_attributes_getter('#{accessors}', '#{attribute_type}')
       end
       def #{accessor}_#{attribute_type.to_s.pluralize}=(attributes)
         collection_of_item_attributes_setter('#{accessors}', '#{attribute_type}', attributes)
       end
     END
   end
   
   config[accessors][:count].times do |ticker|
     [:content, :score, :note, :checked].each do |attribute_type|
       class_eval <<-END, __FILE__, (__LINE__+1)
         def #{accessor}_#{attribute_type}_#{ticker}
           item = items_getter('#{accessors}').detect{|i| i.item_type == '#{accessors}' && i.position == #{ticker}}
           item ? item.send('#{attribute_type}') : ''
         end
         def #{accessor}_#{attribute_type}_#{ticker}=(attributes)
           collection_of_item_attributes_setter('#{accessors}', '#{attribute_type}', {'#{ticker}' => attributes})
         end
       END
     end
   end

  end

  def create_dirty_accessors(accessors)
   accessor = accessors.to_s.singularize
   class_eval <<-END, __FILE__, (__LINE__+1)
     def #{accessors}_changed?(options = {})
       item_changed?('#{accessors}', options)
     end
     def previous_#{accessors}_changed?(options = {})
       previous_item_changed?('#{accessors}', options)
     end
     def #{accessor}_changes
       item_changes.has_key?('#{accessors}') ? item_changes['#{accessors}'] : {}
     end
     def previous_#{accessors}_changes
       previous_item_changes.has_key?('#{accessors}') ? previous_item_changes['#{accessors}'] : {}
     end
   END
  end

  def item_getter(item_type)
   items.detect{|i| i.item_type == item_type}
  end
  def item_setter(item_type, attributes)
   item = items.detect{|i| i.item_type == item_type} || create_item(item_type, 1)
   item.attributes = attributes
   item_attribute_change(item)
   item
  end

  def items_getter(item_type)
   items.select{|i| i.item_type == item_type}
  end
  def items_setter(item_type, collection_of_attributes)
   return while collection_of_attributes.blank?
   # update attributes of existing
   items.select{|item| item.item_type == item_type && collection_of_attributes.keys.include?(item.position.to_s) }.each do |item|
     item.attributes = collection_of_attributes.delete(item.position.to_s)
     item_attribute_change(item)
   end
   # create new items for remainder of attributes, if verified valid by config
   unless collection_of_attributes.blank?
     collection_of_attributes.each do |position, attributes|
       next if config[item_type.to_sym][:count] < position.to_i
       item = create_item(item_type, position)
       item.attributes = attributes
       item_attribute_change(item)
     end
   end
  end 

  # singular getter and setter
  def item_attribute_getter(item_type, attribute_type)
   item = self.send(item_type)
   item ? item.send(attribute_type) : ''
  end
  def item_attribute_setter(item_type, attribute_type, attribute)
   send "#{item_type}=", {attribute_type.to_sym => attribute}
  end

  # list getters and setters
  def collection_of_item_attributes_getter(item_type, attribute_type)
   send(item_type).inject({}){|result, item| result[item.position.to_s] = item.send(attribute_type); result}
  end
  def collection_of_item_attributes_setter(item_type, attribute_type, collection_of_attributes)
   # Array format: [1,5,7]
   if collection_of_attributes.is_a? Array
     attributes = collection_of_attributes.inject({}){|result, value| result[(result.count + 1).to_s] = {attribute_type => value}; result }
   # Hash {'1' => 10, '2' => 5}
   elsif collection_of_attributes.is_a? Hash
     attributes = collection_of_attributes.inject({}){|result, element| result[element.first] = {attribute_type => element.second}; result }
   end
   # Call the setter
   send "#{item_type}=", attributes
  end

  def create_default_items
   new_items = default_values
   new_items.each do |item_type, conditions|
     send "#{item_type}=", conditions
   end
  end
  def create_item(type, position, conditions = {})
   record = conditions.merge({:item_type => type.to_s, :position => position})
   items.create(record)
  end


end