class AddUserNames < ActiveRecord::Migration
  def change
    create_table :user_names do |t|
      t.string   :user_name
    end
  end
end
