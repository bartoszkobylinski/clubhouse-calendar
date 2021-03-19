class CreateRooms < ActiveRecord::Migration[6.1]
  has_many :host
  def change
    create_table :rooms do |t|
      t.string :hosts
      t.text :description
      t.datetime :date
      t.string :name

      t.timestamps
    end
  end
end
