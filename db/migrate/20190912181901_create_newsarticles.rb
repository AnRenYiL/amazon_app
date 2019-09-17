class CreateNewsarticles < ActiveRecord::Migration[6.0]
  def change
    create_table :newsarticles do |t|
      t.string :title
      t.string :description
      t.datetime :published_at
      t.integer :view_count

      t.timestamps
    end
  end
end
