# Talaa v1.7 (Backend + Flutter)
- Admin auth (Devise) → /auth/sign_in → RailsAdmin /admin
- KYC endpoints: /v1/kyc/start|upload|submit
- Transfers: /v1/transfers (domestic), /v1/transfers/intl (intl w/ Stripe PaymentIntent)
- Metrics: /metrics  • Rail health: /v1/rails/health

## Run
cd backend && bundle install && cp .env.example .env && rails db:create db:migrate db:seed && redis-server & bundle exec sidekiq & rails s
cd ../superapp_flutter && flutter pub get && flutter run --dart-define=API_BASE=http://localhost:3000 --dart-define=STRIPE_PUBLISHABLE_KEY=pk_test_xxx
