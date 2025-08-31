class FundingController < ApplicationController; def stripe_intent; render json:{client_secret:'seti_123', publishable_key:ENV['STRIPE_PUBLISHABLE']}; end; end
