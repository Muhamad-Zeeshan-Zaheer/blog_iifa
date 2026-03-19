class CreateBoooks < ActiveRecord::Migration[7.2]
  def change
    create_table :boooks do |t|
      t.datetime :published_at
      t.references :author, null: false, foreign_key: true

      t.timestamps
    end
  end
end
