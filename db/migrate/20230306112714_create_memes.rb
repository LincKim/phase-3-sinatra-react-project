class CreateMemes < ActiveRecord::Migration[7.0]
  def change
    create_table :memes do |t|
      # t.binary :title, limit: 2.megabytes
      t.string :top_text
      t.string :bottom_text
      t.string :url
      t.datetime :createdAt
      t.timestamps
    end
  end
end
