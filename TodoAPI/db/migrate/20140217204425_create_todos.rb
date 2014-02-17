class CreateTodos < ActiveRecord::Migration
  def change
    create_table :todos do |t|
      t.text :text, null: false
      t.date :due_date
      t.integer :priority, default: 3
      t.boolean :completed, default: false

      t.timestamps
    end
  end
end
