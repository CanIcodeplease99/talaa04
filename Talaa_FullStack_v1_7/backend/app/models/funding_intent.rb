class FundingIntent < ApplicationRecord; belongs_to :settlement, optional: true; end
