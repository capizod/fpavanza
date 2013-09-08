class AddForeignCapCapTe < ActiveRecord::Migration
  def up
    execute <<-SQL
      ALTER TABLE capacities
        ADD CONSTRAINT fk_cap_cap_te
        FOREIGN KEY (capacity_te_id)
        REFERENCES capacity_tes(id);
    SQL
  end

  def down
  end
end
