class CreateGadgets < ActiveRecord::Migration
  def change
    create_table :gadgets do |t|
    	t.string :name, :null => false
    	t.string :manufacturer
    	t.boolean :retired
    	t.integer :user_id
    	t.datetime :purchased_at
      t.timestamps
    end
  end
end
