class CreateVocabs < ActiveRecord::Migration


  def change
    create_table :vocabs do |t|
      t.string :english
      t.string :chinese
      t.string :pinyin

      t.belongs_to :users
      t.timestamps null: false
    end
  end
end
