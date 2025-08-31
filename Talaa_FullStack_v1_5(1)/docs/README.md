# Talaa v1.5
- Stripe funding intents (card/ACH) for international sends. Webhook advances settlement to FX on success.
- Prometheus metrics at `/metrics` with counters (transfers, FX, funding).
- Ghana rails: Zeepay primary (HMAC), Hubtel failover.
- FX providers: Wise/Thunes via orchestrator.
