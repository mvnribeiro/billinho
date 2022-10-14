class ChangeIntergerLimitStudentsPhone < ActiveRecord::Migration[7.0]
  def change
    change_column :students, :phone, :integer, limit: 8
  end
end
