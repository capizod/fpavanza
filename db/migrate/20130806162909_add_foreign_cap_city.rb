class AddForeignCapCity < ActiveRecord::Migration
  def up
    execute <<-SQL
      ALTER TABLE capacities
        ADD CONSTRAINT fk_cap_cities
        FOREIGN KEY (city_id)
        REFERENCES cities(id);
    SQL
  end

  def down
  end
end
