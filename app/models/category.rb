class Category < ApplicationRecord
  belongs_to :user
  has_many :CategoriesTransaction, dependent: :destroy
  # has_and_belongs_to_many :transactions
  # has_one :transaction
  # has_many :transactions
  # has_many :transactions, through: :CategoriesTransactions
  # has_and_belongs_to_many :transactions
end
