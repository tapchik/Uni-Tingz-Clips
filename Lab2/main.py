import json

with open("rules.json", "r", encoding='utf-8') as read_rules:
    data = json.load(read_rules)

#print(data)

for rule in data:
    for action in rule["actions"]:
        print(rule["name"], action["func"])
