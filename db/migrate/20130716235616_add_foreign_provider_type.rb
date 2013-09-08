class AddForeignProviderType < ActiveRecord::Migration
  def up
    execute <<-SQL
      ALTER TABLE providers
        ADD CONSTRAINT fk_providers_provider_type
        FOREIGN KEY (provider_type_id)
        REFERENCES provider_types(id);
    SQL
  end

  def down
  end
end
