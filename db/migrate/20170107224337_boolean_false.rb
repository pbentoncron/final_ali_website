class BooleanFalse < ActiveRecord::Migration
  def change
    change_column_default :reviews, :approved, false
    change_column_default :users, :admin, false
  end
end
