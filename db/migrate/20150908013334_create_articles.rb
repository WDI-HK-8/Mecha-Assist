class CreateArticles < ActiveRecord::Migration
  def change
    create_table :articles do |t|
      t.string "title"
      chinese_permalink [:category, :title]

      t.timestamps null: false
    end
  end
end
