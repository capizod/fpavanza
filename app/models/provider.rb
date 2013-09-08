class Provider < ActiveRecord::Base
  attr_accessible :name, :provider_type_id, :internal_key, :account_number, :provider_key
  
  belongs_to :provider_type
  has_many   :providers, :dependent => :destroy, :order => "id DESC"
    
  validates_presence_of :name, :message => :missing_name  
  validates_presence_of :provider_type_id, :message => :missing_provider_type
  validates_uniqueness_of :internal_key, :allow_nil => true, :allow_blank => true, :message => :internal_key_non_uniq  
  validates_presence_of :provider_key, :message => :missing_provider_key  
  validates_uniqueness_of :provider_key, :message => :provider_key_non_uniq
  validates :account_number, :allow_nil => true, :allow_blank => true, :numericality => true 
  
  # Default values provided through class methods.
  #----------------------------------------------------------------------------
  def self.per_page ; 20 ; end
  def self.name_position ; "before" ; end
  
  # Save the branch along with its permissions.
  #----------------------------------------------------------------------------
  def save_with_permissions(params)
    self.provider_type = ProviderType.find(params[:provider_type_id]) unless params[:provider_type_id].blank?
    if params[:provider_type][:access] == "ProviderType" && self.provider_type # Copy provider_type permissions.
      save_with_model_permissions(ProviderType.find(self.provider_type_id))
    else
      self.attributes = params[:provider_types]
      save
    end
  end
  
  # Update branch attributes taking care of campaign lead counters when necessary.
  #----------------------------------------------------------------------------
  def update_with_provider_counters(attributes)
    if self.provider_type_id == attributes[:provider_type_id] # Same provider_type (if any).
      self.attributes = attributes
      self.save
    else                                            # provider_type has been changed -- update branches counters...      
      self.attributes = attributes                  # Assign new provider_type.
      lead = self.save
      branch
    end
  end

  ActiveSupport.run_load_hooks(:fat_free_crm_provider, self)
end
