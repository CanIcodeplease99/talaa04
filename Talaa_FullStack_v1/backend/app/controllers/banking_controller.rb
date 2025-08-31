class BankingController < ApplicationController; def direct_deposit; render json:{account_number:'0012345678', routing_number:'110000000', bank_name:'Talaa Partner Bank'}; end; end
