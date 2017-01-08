class CreateReviews < ActiveRecord::Migration
  def change
    create_table :reviews do |t|
      t.text :content
      t.boolean :approved
      t.references :user, index: true

      t.timestamps
    end
  end
end
