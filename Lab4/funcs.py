import json
from itertools import permutations

def ObviousWinnerReadsJsonFile(filePathVotes: str) -> dict[str, int]:
    # reading options
    with open(filePathVotes, "r", encoding='utf-8') as reading:
        raw_data = json.load(reading)
        # collecting options
        options = []
        for option in raw_data.values():
            if option not in options:
                options += [option]
    # initiating votes dict
    votes = {option: 0 for option in options}
    for option in raw_data.values():
        votes[option] += 1
    # sorting
    votes = dict(sorted(votes.items(), key=lambda item: item[1], reverse=True))
    return votes

def ObviousWinnerReadsUserInput() -> dict[str, int]:
    chosen = []
    # listening to user input
    n = int(input("\nNumber of voters: "))
    for _ in range(n):
        user_input = input("What do you choose: ")
        chosen += [user_input]
    # initiating votes
    votes = {}
    for option in chosen:
        if option not in votes:
            votes[option] = 0
    # counting votes
    for option in chosen:
        votes[option] += 1
    votes = dict(sorted(votes.items(), key=lambda item: item[1], reverse=True))
    return votes

def BordaReadsJsonFile(filePathVotes: str) -> list[dict[str, any]]:
    '''
    Returns: table = [{"options": [one, two, three], "votes": 5}, etc...]
    '''
    with open(filePathVotes, "r", encoding='utf-8') as reading:
        table = json.load(reading)
    return table

def BordaReadsUserInput() -> list[dict[str, any]]:
    '''
    Returns: table = [{"options": [one, two, three], "votes": 5}, etc...]
    '''
    # getting possible options
    user_input = input("\nGive me a list of options (comma separated): ")
    options = [option for option in user_input.split(', ')]
    # generating possible combinations
    combinations = list(permutations(options))
    # initinating dict of votes
    votes = []
    for options in combinations:
        prompt = f"How many people agree with {options}: "
        value = int(input(prompt))
        votes += [value]
    # assemblying table
    table = []
    for i in range(len(votes)):
        line = {"options": combinations[i], "votes": votes[i]}
        table += [line]
    return table

def BordaCountsPoints(table: list[dict[str, any]]) -> dict[str, int]:
    options = table[0]["options"]
    # calculating points
    points = {option: 0 for option in options}
    for option in options:
        for line in table:
            value = (len(options) - line["options"].index(option)) * line["votes"]
            points[option] += value
    # sorting
    points = dict(sorted(points.items(), key=lambda item: item[1], reverse=True))
    return points

def PrintVerdict(score: dict[str, int]) -> None:
    # defining core parameters
    options = _options(score)
    top_options = _top_options(score)
    # greeting message
    if len(top_options) == 0:
        raise Exception
    elif len(top_options) == 1:
        print("\nTop option: ")
    else:
        print(f"\nTop options: ")
    # printing top options
    count = 1
    for option in top_options:
        print(f"{count}. {option} with score {score[option]}")
        count += 1
    
    if len(score) - count == -1:
        return
    
    # in case there are unnamed options left
    print("\nThe remaining options are: ")
    for option, votes in score.items():
        if option not in top_options:
            print(f"{count}. {option} with score {votes}")
            count += 1
    return

def PrintHelp():
    print("""\nProgram takes parameters, try running: 
- python main.py -obvious
- python main.py -obvious voted.json
- python main.py -borda
- python main.py -borda voted3.json""")

def _options(score: dict[str, int]) -> list[str]:
    # collecting possible options
    options = list(score.keys())
    return options

def _top_options(score: dict[str, int]) -> list[str]:
    # finding highest score (votes, points)
    highest_score = 0
    for _, value in score.items():
        if value > highest_score:
            highest_score = value
    # collecting options with highest score
    top_options = []
    for option, score in score.items():
        if score == highest_score:
            top_options += [option]
    return top_options