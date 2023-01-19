class CreateDisbursements < ActiveRecord::Migration[7.0]
  def change
    create_table :disbursements do |t|
      t.references :merchant, null: false, foreign_key: true
      t.decimal :amount, null: false, precision: 8, scale: 2
      t.date :disbursed_at, null: false

      t.timestamps
    end
  end
end
