class AddPaidToAttendances < ActiveRecord::Migration[7.2]
  def change
    add_column :attendances, :paid, :boolean
  end
end
