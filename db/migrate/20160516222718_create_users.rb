class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :uid, null: false
      t.string :provider, null: false, default: 'spotify'

      t.timestamps null: false
    end
  end
end
