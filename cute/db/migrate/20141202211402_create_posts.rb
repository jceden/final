class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :comment
      t.string :username
      t.references :image, index: true
      t.references :user, index: true

      t.timestamps
    end
  end
end
