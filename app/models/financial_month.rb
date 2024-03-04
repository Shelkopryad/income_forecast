class FinancialMonth < ApplicationRecord
  has_many :daily_expenses

  def calculate_actual_income
    monthly_salary - daily_expenses.sum(0) { |it| it.amount }
  end
end
