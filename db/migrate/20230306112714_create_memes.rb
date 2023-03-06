class CreateMemes < ActiveRecord::Migration[7.0]
  def change
    create_table :memes do |t|
      t.binary :title, limit: 2.megabytes

      t.timestamps
    end
  end
end
