class AccountProduct < ActiveRecord::Base
  # attr_accessible :title, :body
  belongs_to :account
  belongs_to :product
  
  validates :account_id, :presence => true
  validates :product_id, :presence => true
  
  ActiveSupport.run_load_hooks(:fat_free_crm_account_product, self)
end
