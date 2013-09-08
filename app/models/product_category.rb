class ProductCategory < ActiveRecord::Base
  attr_accessible :description  
  
  validates_presence_of :description, :message => :missing_description  
  
  # Default values provided through class methods.
  #----------------------------------------------------------------------------
  def self.per_page ; 20 ; end
  def self.description_position ; "before" ; end
  
  ActiveSupport.run_load_hooks(:fat_free_crm_product_category, self)
end
