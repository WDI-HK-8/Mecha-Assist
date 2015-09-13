class AddImageToProfile < ActiveRecord::Migration
  def change
    add_attachment :user; :image
  end
end
