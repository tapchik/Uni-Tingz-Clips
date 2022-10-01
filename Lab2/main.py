from code import interact
import json
from random import choice

class machine:

    data = []
    rules = {}

    def __init__(self, jsonfile: str) -> None:
        with open(jsonfile, "r", encoding='utf-8') as read_rules:
            self.data = json.load(read_rules)
        
        for rule in self.data:
            for condition in rule["conditions"]:
                if isinstance(condition, list):
                    self.rules[condition[0]] = None

    def ask_int(self, rule: str, question: str) -> None:
        answer = input(question)
        try:
            answer = int(answer)
            self.rules[rule] = answer
        except:
            raise

    def yes_or_no(self, rule: str, question: str) -> None:
        answer = input(question)
        if answer.lower() in ["yes", "y"]:
            self.rules[rule] = "yes"
        elif answer.lower() in ["no", "n"]:
            self.rules[rule] = "no"
        else:
            raise

    def asert(self, rule: str, value: str) -> None:
        self.rules[rule] = value

    def print(self, text: str) -> None:
        print(text)

    def interprete(self, condition: list) -> bool:
        text = ""
        for item in condition:
            temp = ""
            if isinstance(item, list):
                temp += f"self.rules[\"{item[0]}\"]"
                if item[1] == "eq":
                    temp += " == "
                elif item[1] == ">":
                    temp += " > "
                elif item[1] == "<":
                    temp += " < "
                if item[2] == "null":
                    temp += "None"
                else:
                    temp += f"\"item[2]\""
            elif isinstance(item, str):
                temp = f" {item} "
            text += temp
        #print(text, "->")
        print(eval(text))
        return eval(text)
    
    def perform_actions(self, rule_name: str) -> None:
        for rule in self.data:
            if rule["name"] == rule_name:
                
    
    def run(self) -> None:
        options = []
        for rule in self.data:
            if self.interprete(rule["conditions"]) == True:
                options += [rule["name"]]
        
        

machine = machine("rules.json")

for item in machine.data:
    machine.interprete(item["conditions"])

#yes_or_no("manka", "Тебе нравится манная каша? Ответ: ")
#print(rules)