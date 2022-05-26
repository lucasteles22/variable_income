class Earning < ApplicationRecord
  belongs_to :asset
  belongs_to :user

  enum kind: { dividend: 'dividend', interest_on_equity: 'interest_on_equity', income: 'income' }
end
