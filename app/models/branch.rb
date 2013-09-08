class Branch < ActiveRecord::Base
  attr_accessible :name, :bank_id
  belongs_to :bank
  
  scope :for_bank, lambda { |id| where('bank_id = ?', id) }
  
  validates_presence_of :name, :message => :missing_name  

  # Default values provided through class methods.
  #----------------------------------------------------------------------------
  def self.per_page ; 20 ; end
  def self.name_position ; "before" ; end
  
  # Save the branch along with its permissions.
  #----------------------------------------------------------------------------
  def save_with_permissions(params)
    self.bank = Bank.find(params[:bank_id]) unless params[:bank_id].blank?
    if params[:bank][:access] == "Bank" && self.bank # Copy bank permissions.
      save_with_model_permissions(Bank.find(self.bank_id))
    else
      self.attributes = params[:branches]
      save
    end
  end
  
  # Update branch attributes taking care of campaign lead counters when necessary.
  #----------------------------------------------------------------------------
  def update_with_branch_counters(attributes)
    if self.bank_id == attributes[:bank_id] # Same bank (if any).
      self.attributes = attributes
      self.save
    else                                            # Bank has been changed -- update branches counters...      
      self.attributes = attributes                  # Assign new bank.
      lead = self.save
      branch
    end
  end

  ActiveSupport.run_load_hooks(:fat_free_crm_branch, self)
 
end
