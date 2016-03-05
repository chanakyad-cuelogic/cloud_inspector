class CreateSecurityGroups < ActiveRecord::Migration
  def change
    create_table :security_groups do |t|
      t.hstore :data

      t.timestamps null: false
    end
  end
end
