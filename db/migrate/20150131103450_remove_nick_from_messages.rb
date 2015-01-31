class RemoveNickFromMessages < ActiveRecord::Migration
  def change
    remove_column :messages, :nick, :string
  end
end
