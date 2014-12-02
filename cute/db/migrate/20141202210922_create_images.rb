class CreateImages < ActiveRecord::Migration
  def change
    create_table :images do |t|
      t.string :filename
      t.integer :cute_vote
      t.integer :total_vote
      t.references :user, index: true

      t.timestamps
    end
  end
end
