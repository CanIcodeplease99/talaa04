Talaa Combined Patches v1.9 (admin + bank/direct-deposit + fraud + AI prompts)

Contents
- admin_dashboard_v1/  — RailsAdmin enhancements, Sidekiq Web mount, custom actions.
- Talaa_Bank_DirectDeposit_v1_patch.zip — bank link + debit intent + direct deposit.
- Talaa_Fraud_Module_v1_8_1_patch.zip — risk engine + holds/blocks + FaceID lock/banner.
- ai_agent/emergent_prompt_v2.txt — detailed builder prompt.
- ai_agent/Talaa_Agent_Starter_Pack_v1_1.zip — OpenAPI + tokens + Flutter theme.

Apply Order
1) Fraud module (if not yet applied) → migrate.
2) Bank + DirectDeposit patch → migrate.
3) Admin dashboard patch → mount routes, restart.
4) Feed `emergent_prompt_v2.txt` + starter pack to AI builder for prototype UIs.
