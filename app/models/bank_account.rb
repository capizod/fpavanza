class BankAccount < ActiveRecord::Base
  belongs_to :account
  belongs_to :bank
  attr_accessible :bank_key
  validates :bank_key, :numericality => { :only_integer => true }
  validates :bank_plaza, :numericality => { :only_integer => true }
  validates :account_number, :numericality => { :only_integer => true}
  validates :account_number, :presence => true
end
