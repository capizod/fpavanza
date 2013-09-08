class AddForeign < ActiveRecord::Migration
  def up
    execute <<-SQL
      ALTER TABLE capacities
        ADD CONSTRAINT fk_cap_cap_tc
        FOREIGN KEY (capacity_tc_id)
        REFERENCES capacity_tcs(id);
    SQL
  end

  def down
  end
end
