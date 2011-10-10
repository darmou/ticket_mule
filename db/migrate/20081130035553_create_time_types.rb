class CreateTimeTypes < ActiveRecord::Migration
  def self.up
    create_table :time_types do |t|
      t.string :name, :null => false
      t.datetime :disabled_at
    end
  end

  def self.down
    drop_table :time_types
  end
end
