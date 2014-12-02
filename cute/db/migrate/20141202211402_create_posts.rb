class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :comment
      t.references :image, index: true
      t.references :user, index: true
      t.datetime :posted

      t.timestamps
    end
  end
end
