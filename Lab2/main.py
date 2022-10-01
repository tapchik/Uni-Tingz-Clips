from code import interact
import json
from random import choice
import pathlib

from numpy import true_divide

class rule:

    def __init__(self, name:str, conditions: list, actions: list) -> None:
        self.name = name
        self.conditions = conditions
        self.actions = actions
        self.activated = False
        if any([action["func"]=="yes_or_no" or action["func"]=="ask_int" for action in self.actions]):
            self.requires_input = True
        else:
            self.requires_input = False

class machine:

    def __init__(self, jsonfile: str) -> None:

        self.raw_data = {}
        self.rules = {}
        self.answered = {}

        with open(jsonfile, "r", encoding='utf-8') as read_rules:
            self.raw_data = json.load(read_rules)

        for name, info in self.raw_data.items():
            self.rules[name] = rule(name, info["conditions"], info["actions"])

        for r in self.rules.values():
            for condition in r.conditions:
                if isinstance(condition, list):
                    self.answered[condition[0]] = None
    
    def perform_actions(self, rule_name: str) -> None:
        rule = self.rules[rule_name]
        print(f"Performing: {rule.name} ({rule.activated}, {rule.requires_input})")
        for action in self.rules[rule_name].actions:
            if action["func"] == "ask_int":
                self.answered[action["arg_1"]] = self.ask_int(action["arg_2"])
            elif action["func"] == "yes_or_no":
                self.answered[action["arg_1"]] = self.yes_or_no(action["arg_2"])
            elif action["func"] == "assert":
                self.answered[action["arg_1"]] = action["arg_2"]
            elif action["func"] == "print":
                self.print(action["arg_1"])
    
    @staticmethod
    def ask_int(question: str) -> int:
        while True:
            answer = input(question)
            try:
                answer = int(answer)
                return answer
            except:
                continue

    @staticmethod
    def yes_or_no(question: str) -> str:
        while True:
            answer = input(question)
            if answer.lower() in ["yes", "y"]:
                return "yes"
            elif answer.lower() in ["no", "n"]:
                return "no"
    
    @staticmethod
    def print(text: str) -> None:
        print(text)
    
    def interprete(self, rule_name: str) -> bool:
        condition = self.rules[rule_name].conditions
        text = ""
        for item in condition:
            temp = ""
            if isinstance(item, list):
                temp += f"self.answered[\"{item[0]}\"]"
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
        #print(eval(text))
        return eval(text)
    
    def run(self) -> None:
        while True:
            # perform all available
            for rule in self.rules.values():
                ready = self.interprete(rule.name)
                if rule.name == "RULE-15-rule-likes-russian-setting":
                    x = 5
                if  ready == True and rule.activated == False and rule.requires_input == False:
                    self.perform_actions(rule)
                    rule.activated = True

            options = []
            for rule in self.rules.values():
                if self.interprete(rule.name) == True and rule.activated == False:
                    options += [rule.name]
            try:
                chosen_rule = choice(options)
                self.perform_actions(chosen_rule)
                self.rules[chosen_rule].activated = True
            except:
                break
        
        

jsonfile = pathlib.Path(__file__).parent.resolve()
jsonfile = str(jsonfile) + "/rules.json"
machine = machine(jsonfile)
machine.run()

#for info in machine.data:
#    machine.interprete(info["conditions"])

#yes_or_no("manka", "Тебе нравится манная каша? Ответ: ")
#print(rules)