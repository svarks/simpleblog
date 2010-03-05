class CreateComments < ActiveRecord::Migration
  def self.up
    create_table :comments do |t|
      t.references :commentable, :polymorphic => true
      t.references :user
      t.string :author_name
      t.text :body
      t.timestamps
    end
  end

  def self.down
    drop_table :comments
  end
end
