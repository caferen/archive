import json
import pandas

with open("data.json","r") as f:
    proton = f.read()

proton = json.loads(proton)

vaults = proton["vaults"]

logins = []

for vault in vaults.values():
    items = vault["items"]

    for item in items:
        if item["data"]["type"] == "login":
            username = item["data"]["content"]["username"]
            password = item["data"]["content"]["password"]
            note = item["data"]["metadata"]["note"]
            name = item["data"]["metadata"]["name"]
            
            for url in item["data"]["content"]["urls"]:
                login = {
                    "username": username,
                    "password": password,
                    "note": note,
                    "url": url,
                    "name": name,
                }
                logins.append(login)
                
df = pandas.DataFrame(logins) 
df.to_csv("data.csv", index=False)
