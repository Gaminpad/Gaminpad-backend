class CreateApps < ActiveRecord::Migration
  def change
    create_table :apps do |t|

      t.timestamps
      t.integer :admin_user_id
      t.string :name, :limit => 20
      t.string :url_slug, :limit => 20
      t.string :status, :limit => 10

    end
  end
end
