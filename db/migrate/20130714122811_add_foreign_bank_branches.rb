class AddForeignBankBranches < ActiveRecord::Migration
  def up
    # add a foreign key
    execute <<-SQL
      ALTER TABLE branches
        ADD CONSTRAINT fk_branches_bank
        FOREIGN KEY (bank_id)
        REFERENCES banks(id)
    SQL
  end

  def down
  end
end
