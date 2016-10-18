class CreateTasks < ActiveRecord::Migration[5.0]
  def change
    create_table :tasks do |t|
      t.references :user, foreign_key: true
      t.text :content
      t.string :slug
      t.boolean :private

      t.timestamps
    end
    add_index :tasks, :slug
  end
end
