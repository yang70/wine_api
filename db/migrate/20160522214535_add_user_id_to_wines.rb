class AddUserIdToWines < ActiveRecord::Migration
  def change
    add_reference :wines, :user, index: true
  end
end
