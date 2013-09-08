class Bank < ActiveRecord::Base
  attr_accessible :name
  has_many    :branches, :dependent => :destroy, :order => "id DESC"
  
  validates_presence_of :name, :message => :missing_name
  
  accepts_nested_attributes_for :branches
  
  # Default values provided through class methods.
  #----------------------------------------------------------------------------
  def self.per_page ; 20 ; end
  def self.name_position ; "before" ; end
  
  ActiveSupport.run_load_hooks(:fat_free_crm_lead, self)
  
end
