class Capacity < ActiveRecord::Base
  belongs_to  :user  
  belongs_to :capacity_tc
  belongs_to :capacity_te
  belongs_to :region
  belongs_to :city
  
  validates_presence_of :capacity_emploee_id, :message => :missing_emploee_id
  validates_uniqueness_of :capacity_emploee_id
  validates_presence_of :capacity_tc_id, :message => :missing_cap_tc
  validates_presence_of :region_id, :message => :missing_region
  validates_presence_of :city_id, :message => :missing_city_id
  validates_presence_of :capacity_add_date, :message => :missing_add_date
  validates_presence_of :capacity_te_id, :message => :missing_cap_te 
  validates :monto_mex, :format => { :with => /^\d+??(?:\.\d{0,2})?$/ }, :numericality => {:greater_than => 0, :less_than => 100000000000}

  scope :state, lambda { |filters|
    where([ 'status IN (?)' + (filters.delete('other') ? ' OR status IS NULL' : ''), filters ])
  }
  
  scope :created_by, lambda { |user| where('user_id = ?' , user.id) }  

  scope :text_search, lambda { |query| search('first_name_or_last_name_or_company_or_email_cont' => query).result }

  uses_user_permissions
  has_fields
  exportable
  sortable :by => [ "created_at DESC", "updated_at DESC" ], :default => "id ASC"

  has_ransackable_associations %w(contact campaign tasks tags activities emails addresses comments)
  ransack_can_autocomplete  

  # Default values provided through class methods.
  #----------------------------------------------------------------------------
  def self.per_page ; 20 ; end
  def self.first_name_position ; "before" ; end

  # Save the capacity along with its permissions.
  #----------------------------------------------------------------------------
  def save_with_permissions(params)
    self.attributes = params[:capacities]
    save    
  end

  # Deprecated: see update_with_capacity_counters
  #----------------------------------------------------------------------------
  def update_with_permissions(attributes, users = nil)
    #ActiveSupport::Deprecation.warn "capacity.update_with_permissions is deprecated and may be removed from future releases, use user_ids and group_ids inside attributes instead and call capacity.update_with_capacity_counters"
    update_with_capacity_counters(attributes)
  end

  # Update capacity attributes taking care of campaign capacity counters when necessary.
  #----------------------------------------------------------------------------
  def update_with_capacity_counters(attributes)          
      self.attributes = attributes                  # Assign new campaign.
      capacity = self.save
      capacity    
  end      

  #----------------------------------------------------------------------------
  def full_name(format = nil)
    if format.nil? || format == "before"
      "#{self.id}"
    else
      "#{self.id}"
    end
  end
  alias :name :full_name

private

  # Make sure at least one user has been selected if the capacity is being shared.
  #----------------------------------------------------------------------------
  def users_for_shared_access
    errors.add(:access, :share_capacity) if self[:access] == "Shared" && !self.permissions.any?
  end

  ActiveSupport.run_load_hooks(:fat_free_crm_capacity, self)
end
