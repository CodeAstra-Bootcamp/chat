class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.string :nick
      t.string :note

      t.timestamps null: false
    end
  end
end
