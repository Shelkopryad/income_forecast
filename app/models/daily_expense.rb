class DailyExpense < ApplicationRecord
  belongs_to :financial_month

  CATEGORIES = %w[Cafe/Restaurants Shop Other].freeze

  def self.categories
    CATEGORIES
  end
end
