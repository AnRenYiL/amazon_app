class CreateDiscussions < ActiveRecord::Migration[6.0]
  def change
    create_table :discussions do |t|
      t.text :body
      t.string :title
      t.references :project, null: false, foreign_key: true

      t.timestamps
    end
  end
end
