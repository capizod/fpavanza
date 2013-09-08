class AddForeignCapCapReg < ActiveRecord::Migration
  def up
    execute <<-SQL
      ALTER TABLE capacities
        ADD CONSTRAINT fk_cap_region
        FOREIGN KEY (region_id)
        REFERENCES regions(id);
    SQL
  end

  def down
  end
end
