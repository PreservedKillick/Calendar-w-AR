class CreateToDos < ActiveRecord::Migration
  def change
    create_table :to_dos do |t|
      t.column :description, :string
      t.column :user_id, :int
    end
    add_column :users, :to_do_id, :int
  end
end
