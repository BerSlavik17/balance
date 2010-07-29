class DestroyBalansSchemaInfos < ActiveRecord::Migration
  def self.up
    drop_table :balans_schema_infos
  end

  def self.down
    create_table "balans_schema_infos", :force => true do |t|
      t.float "version"
    end
  end
end
