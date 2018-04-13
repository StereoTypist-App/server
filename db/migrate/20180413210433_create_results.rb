class CreateResults < ActiveRecord::Migration[5.2]
  def change
    create_table :results do |t|
      t.references :user
      t.float :wpm
      
      t.timestamps
    end
  end
end
