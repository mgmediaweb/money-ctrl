class Transaction < ApplicationRecord
  belongs_to :user
  # has_and_belongs_to_many :categories
  has_and_belongs_to_many :categories
  # has_many :CategoriesTransactions, dependent: :destroy
  # has_many :categories, through: :CategoriesTransactions
end
