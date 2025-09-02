Talaa — Admin Dashboard (RailsAdmin + Ops)

Purpose
- Full control over: Transfers/Settlements, Holds/Blocks, Fraud Events, Business KYB, KYC, External Accounts, Bank Credits.
- Quick actions: Approve/Reject business, Release Hold, Reverse Settlement, Freeze/Unfreeze account.

Steps
1) Ensure RailsAdmin & Devise are installed (already in your repo). Seeds create admin user via .env.
2) Add to Gemfile (if not present): `gem 'rails_admin'`, `gem 'devise'`, `gem 'sidekiq'`
3) Mount dashboards in `config/routes.rb`:
   ```ruby
   require 'sidekiq/web'
   authenticate :admin_user do
     mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
     mount Sidekiq::Web => '/ops/sidekiq'
   end
   ```
4) Drop the files in this patch, migrate, restart.
