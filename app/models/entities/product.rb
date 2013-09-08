class Product < ActiveRecord::Base  
  
  belongs_to  :user
  belongs_to  :product_type
  belongs_to  :provider_type
  belongs_to  :product_state
  has_many    :account_products, :dependent => :destroy
  has_many    :accounts, :through => :account_products, :uniq => true, :order => "accounts.id DESC"
  has_one     :account
  
  validates_presence_of :name, :message => :missing_name 
  validates_presence_of :product_type_id, :message => :missing_product_type  
  validates_presence_of :starts_on, :message => :missing_starts_date  
#  validates_presence_of :ends_on, :message => :missing_ends_date  
  validates :account_number, :allow_nil => true, :allow_blank => true, :numericality => true
  validates :monto_mex, :format => { :with => /^\d+??(?:\.\d{0,2})?$/ }, :numericality => {:greater_than => 0, :less_than => 100000000000}
  validate :start_and_end_dates
  validate :users_for_shared_access
  
#  has_ransackable_associations %w(accounts)
#  ransack_can_autocomplete
  
  scope :text_search, lambda { |query|
    t = Product.arel_table
    # We can't always be sure that names are entered in the right order, so we must
    # split the query into all possible first/last name permutations.
    name_query = t[:name].matches("%#{query}%")        

    where( name_query.nil? ? other : name_query.or(other) )
  }
  
  scope :my, lambda {
    accessible_by(Product.current_ability)
  }
  
  scope :by_name, order(:name)
  
  has_fields
  exportable
  sortable :by => [ "name ASC", "created_at DESC", "updated_at DESC" ], :default => "created_at DESC"
  
  # Store current user in the class so we could access it from the activity
  # observer without extra authentication query.
  cattr_accessor :current_product
  
  # Default values provided through class methods.
  #----------------------------------------------------------------------------
  def self.per_page ; 20                  ; end
  def self.name_position ; "before" ; end 
  
  # Backend handler for [Create New product] form (see product/create).
  #----------------------------------------------------------------------------
  def save_with_account_and_permissions(params)    
    save_account(params)
    result = self.save    
    result
  end

  # Backend handler for [Update product] form (see product/update).
  #----------------------------------------------------------------------------
  def update_with_account_and_permissions(params)
    save_account(params)
    # Must set access before user_ids, because user_ids= method depends on access value.
    self.access = params[:product][:access] if params[:product][:access]
    self.attributes = params[:product]
    self.save
  end
  
  # Attach given attachment to the product if it hasn't been attached already.
  #----------------------------------------------------------------------------
  def attach!(attachment)
    unless self.send("#{attachment.class.name.downcase}_ids").include?(attachment.id)
      self.send(attachment.class.name.tableize) << attachment
    end
  end

  # Discard given attachment from the product.
  #----------------------------------------------------------------------------
  def discard!(attachment)
    if attachment.is_a?(Task)
      attachment.update_attribute(:asset, nil)
    else # Opportunities
      self.send(attachment.class.name.tableize).delete(attachment)
    end
  end

  # Class methods.
  #----------------------------------------------------------------------------
  def self.create_for(model, account, opportunity, params)
    attributes = {
#      :lead_id     => model.id,
#      :user_id     => params[:account][:user_id],
#      :assigned_to => params[:account][:assigned_to],
#      :access      => params[:access]
    }
    %w(name product_type_id account_number starts_on ends_on provider_type_id).each do |name|
      attributes[name] = model.send(name.intern)
    end

    product = Product.new(attributes)

    # Set custom fields.
    if model.class.respond_to?(:fields)
      model.class.fields.each do |field|
        if product.respond_to?(field.name)
          product.send "#{field.name}=", model.send(field.name)
        end
      end
    end

    product.business_address = Address.new(:street1 => model.business_address.street1, :street2 => model.business_address.street2, :city => model.business_address.city, :state => model.business_address.state, :zipcode => model.business_address.zipcode, :country => model.business_address.country, :full_address => model.business_address.full_address, :address_type => "Business") unless model.business_address.nil?

    # Save the product only if the account and the opportunity have no errors.
    if account.errors.empty?
      # Note: product.account = account doesn't seem to work here.
      product.account_product = AccountProduct.new(:account => account, :product => product) unless account.id.blank?
      if product.access != "Lead" || model.nil?
        product.save
      else
        product.save_with_model_permissions(model)
      end      
    end
    product
  end
  
  private
  
  # Make sure end date > start date.
  #----------------------------------------------------------------------------
  def start_and_end_dates
    if (self.starts_on && self.ends_on) && (self.starts_on > self.ends_on)
      errors.add(:ends_on, :dates_not_in_sequence)
    end
  end
  
  # Make sure at least one user has been selected if the product is being shared.
  #----------------------------------------------------------------------------
  def users_for_shared_access
#    errors.add(:access, :share_product) if self[:access] == "Shared" && !self.permissions.any?
  end
  
  # Handles the saving of related accounts
  #----------------------------------------------------------------------------
  def save_account(params)
    if (params[:account] != nil)
      if params[:account][:id] != ""
        self.accounts << Account.find(params[:account][:id]) unless params[:account].blank?
 #       for acc in self.accounts do        
 #         if (acc.id.present?)
  #          self.account_product = AccountProduct.new(:account => acc, :product => self)
   #       end  
      # end
      end          
    end
   self.reload unless self.new_record? # ensure the account association is updated
  end
  
  # Define class methods
  #----------------------------------------------------------------------------
  class << self

    def current_ability
      Ability.new(Product.current_product)
    end

  end
    
  ActiveSupport.run_load_hooks(:fat_free_crm_product, self)
end
