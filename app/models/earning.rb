class Earning < ApplicationRecord
  belongs_to :asset
  belongs_to :user

  enum :kind, [ :dividend, :interest_on_equity, :income ], scopes: true
end
