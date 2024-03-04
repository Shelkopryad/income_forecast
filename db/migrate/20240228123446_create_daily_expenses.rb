class CreateDailyExpenses < ActiveRecord::Migration[7.1]
  def change
    create_table :daily_expenses do |t|
      t.date :expense_date
      t.references :financial_month, foreign_key: true
      t.string :category
      t.float :amount
      t.timestamps
    end
  end
end
