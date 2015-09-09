class CreateVocabs < ActiveRecord::Migration
  def change
    create_table :vocabs do |t|

      t.timestamps null: false
    end
  end
end
