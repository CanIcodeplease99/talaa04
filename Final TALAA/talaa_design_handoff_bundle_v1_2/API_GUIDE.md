# Talaa API Guide v1.2

## Transfers
POST /v1/transfers
- body: {recipient_id, amount, boost}
- boost=true => Instant transfer rail

## Split
POST /v1/split
- body: {participants, amount_each}

## AI Assistant
POST /v1/ai/assistant
- body: {user_id, prompt}
- returns: structured reply JSON

## QR
POST /v1/qr/pay
- body: {qr_data}
