# Observability
Scrape `GET /metrics` with Prometheus.

Example counters:
- talaa_transfers_created
- talaa_transfers_sent_ok / talaa_transfers_failed
- talaa_fx_quotes_requested
- talaa_fx_trades_started / ok / failed
- talaa_funding_intents_created / funding_cleared

Add Grafana dashboards for success rate, time-to-finality, rails health.
