class UserKyc < ApplicationRecord; enum status: { pending: 0, approved: 1, rejected: 2 }; end
