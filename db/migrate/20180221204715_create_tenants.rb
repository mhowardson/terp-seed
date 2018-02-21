class CreateTenants < ActiveRecord::Migration[5.0]
  def change
    create_table :tenants do |t|
      t.references :tenant, foreign_key: true
      t.string :name
      t.string :address1
      t.string :address2
      t.string :city
      t.string :province
      t.string :postal_code
      t.string :sales_phone
      t.string :qa_phone
      t.string :production_phone
      t.string :fax
      
      t.timestamps
    end
    add_index :tenants, :name
  end
end
