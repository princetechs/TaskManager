class CreateTodos < ActiveRecord::Migration[7.1]
  def change
    create_table :todos do |t|

      t.timestamps
    end
  end
end
