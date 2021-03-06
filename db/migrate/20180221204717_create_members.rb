class CreateMembers < ActiveRecord::Migration[5.0]
  def change
    create_table :members do |t|
      t.references :tenant, foreign_key: true
      t.references :user, foreign_key: true
      t.string :first_name
      t.string :last_name
      t.string :home_phone
      t.string :mobile_phone
      t.string :title
      t.datetime :start_date
      t.datetime :termination_date

      t.timestamps
    end
  end
end
