class CreateFinancialMonths < ActiveRecord::Migration[7.1]
  def change
    create_table :financial_months do |t|
      t.integer :month
      t.integer :year
      t.float :monthly_salary
      t.float :projected_expense
      t.float :actual_expense
      t.timestamps
    end
  end
end
