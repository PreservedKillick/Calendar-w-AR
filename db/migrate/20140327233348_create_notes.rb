class CreateNotes < ActiveRecord::Migration
  def change
    create_table :notes do |t|
      t.column :notabene, :string
      t.column :record_id, :int
      t.column :record_type, :int
    end
  end
end
