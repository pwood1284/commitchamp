class AddRepos < ActiveRecord::Migration
  def change
    create_table :repos do |t|
      t.string  :name
      t.string  :owner
    end
  end
end
