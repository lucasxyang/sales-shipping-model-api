class CreateDocumentLines < ActiveRecord::Migration[5.1]
  def change
    create_table :document_lines do |t|
      t.decimal :qty
      t.references :document, foreign_key: true
      t.references :product, foreign_key: true

      t.timestamps
    end
  end
end
