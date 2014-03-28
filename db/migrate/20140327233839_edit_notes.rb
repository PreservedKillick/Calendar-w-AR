class EditNotes < ActiveRecord::Migration
  def change
    remove_column :notes, :record_type, :int

    add_column :notes, :record_type, :string
  end
end
