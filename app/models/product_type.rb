class ProductType < ActiveRecord::Base
  attr_accessible :description, :alias, :product_category_id
  has_one    :product_category
  
  validates_presence_of :description, :message => :missing_description
  validates_presence_of :alias, :message => :missing_alias
  validates_presence_of :product_category_id, :message => :missing_product_category
  
  # Default values provided through class methods.
  #----------------------------------------------------------------------------
  def self.per_page ; 20 ; end
  def self.description_position ; "before" ; end
  
  ActiveSupport.run_load_hooks(:fat_free_crm_product_type, self)
  
end
