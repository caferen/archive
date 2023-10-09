import requests
import json

reqs = [
    {"pools": ['ANKARA-10']},
    {"pools": ['ANKARA-11']},
    {"pools": ['ANKARA-2']},
    {"pools": ['ANKARA-3']},
]


for data in reqs:
    req = requests.post('http://127.0.0.1:8080/route',
                        json=data)

    with open(data["pools"][0] + '.json', 'w') as file:
        json.dump(req.json(), file, ensure_ascii=True, indent=4)
