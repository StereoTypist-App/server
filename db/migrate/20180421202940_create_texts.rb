class CreateTexts < ActiveRecord::Migration[5.2]
  def change
    create_table :texts do |t|
      t.text :text
      t.string :title
      t.references :user

      t.timestamps
    end
  end
end
