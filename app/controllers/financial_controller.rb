class FinancialController < ApplicationController

  LAST_SIX = 6

  def index
    @fin_month = FinancialMonth.last
  end

  def new
    @new_fin = FinancialMonth.new
  end

  def create
    salary = params[:financial_month][:monthly_salary]
    previous_month = FinancialMonth.last.month
    if previous_month >= Time.now.month
      redirect_to financial_index_path
      return
    end

    count_of_last = FinancialMonth.all.size >= LAST_SIX ? LAST_SIX : FinancialMonth.all.size

    last_six_month_expenses = (FinancialMonth.last(count_of_last).sum(0) { |it| it.actual_expense } / count_of_last)
                                   .round(2)

    same_month_previous_year = FinancialMonth.find_by(month: (previous_month + 1), year: (Time.now.year - 1))

    same_month_last_year_expenses = same_month_previous_year.nil? ? FinancialMonth.last.actual_expense
                                      : same_month_previous_year.actual_expense

    projected_expenses = same_month_last_year_expenses.nil? ? last_six_month_expenses
                              : (last_six_month_expenses + same_month_last_year_expenses) / 2

    FinancialMonth.create(
      month: previous_month + 1,
      year: Time.now.year,
      monthly_salary: salary.to_f.round(2),
      projected_expense: projected_expenses.round(2),
      actual_expense: 0
    )

    redirect_to financial_index_path
  end

  def new_expense
    fin_month = FinancialMonth.last
    DailyExpense.create(
      amount: params[:amount].to_f,
      category: params[:category],
      expense_date: Time.now,
      financial_month: fin_month
    )

    fin_month.update(actual_expense: (fin_month.actual_expense + params[:amount].to_f).round(2))

    redirect_to financial_index_path
  end

  def current_month_history
    @daily_expenses = FinancialMonth.last.daily_expenses
  end

  def history
    @fin_months = FinancialMonth.all
  end
end
