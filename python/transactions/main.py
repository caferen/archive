import json
from datetime import datetime
import csv

transactions = {}
by_desc = {}

with open('TransactionHistory.csv', 'r') as history:
    reader = csv.reader(history)
    for row in reader:
        date = row[0]
        description = row[1]
        value = row[2].replace(',', '')
        value = float(value)

        date = datetime.strptime(date, "%d/%m/%Y")
        year = str(date.year)
        month = date.strftime("%B")

        date = f"{year}-{month}"

        if date not in transactions:
            transactions[date] = {}
            transactions[date]["total"] = 0

        if description not in transactions[date]:
            transactions[date][description] = 0

        if description not in by_desc:
            by_desc[description] = {}
            by_desc[description]["total"] = 0

        if date not in by_desc[description]:
            by_desc[description][date] = 0

        transactions[date][description] += value
        if value < 0:
            transactions[date]["total"] += value
        by_desc[description][date] += value
        by_desc[description]["total"] += value

with open('transactions.json', 'w') as f:
    json.dump(transactions, f)
with open('by_desc.json', 'w') as f:
    json.dump(by_desc, f)
