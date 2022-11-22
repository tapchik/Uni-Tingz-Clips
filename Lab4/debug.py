import sys
import pathlib
import funcs

folder = str(pathlib.Path(__file__).parent.resolve())

DEBUG = (1, 1)

if DEBUG != None:
    print("\nDebug mode is on! ")

if DEBUG == (0, 0):
    votes = funcs.ObviousWinnerReadsJsonFile(folder+"/voted.json")
    funcs.PrintVerdict(votes)
    print()
    exit()
elif DEBUG == (0, 1):
    votes = funcs.ObviousWinnerReadsUserInput()
    funcs.PrintVerdict(votes)
    print()
    exit()
elif DEBUG == (1, 0):
    table = funcs.BordaReadsJsonFile(folder+"/voted3.json")
    points = funcs.BordaCountsPoints(table)
    funcs.PrintVerdict(points)
    print()
    exit()
elif DEBUG == (1, 1):
    table = funcs.BordaReadsUserInput()
    points = funcs.BordaCountsPoints(table)
    funcs.PrintVerdict(points)
    print()
    exit()