class CreateProjects < ActiveRecord::Migration[6.0]
  def change
    create_table :projects do |t|
      t.string :title
      t.text :description
      t.string :auther
      t.datetime :deadline

      t.timestamps
    end
  end
end
