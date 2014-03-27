class CreateTable < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.column :description, :string
      t.column :location, :string
      t.column :start_time, :datetime
      t.column :finish_time, :datetime

      t.timestamps

    end
    create_table :users do |t|
      t.column :event_id, :integer
    end
  end
end
