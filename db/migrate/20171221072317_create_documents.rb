class CreateDocuments < ActiveRecord::Migration[5.1]
  def change
    create_table :documents do |t|
      t.string :status
      t.date :placed_on
      t.references :customer, foreign_key: true

      t.timestamps
    end
  end
end
