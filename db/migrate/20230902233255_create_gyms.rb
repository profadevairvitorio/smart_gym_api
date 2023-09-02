class CreateGyms < ActiveRecord::Migration[7.0]
  def change
    create_table :gyms do |t|
      t.string :name
      t.string :document_number
      t.string :document_type
      t.string :email
      t.json :config, default: {}

      t.timestamps
    end
  end
end
