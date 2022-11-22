import sys
import pathlib
import funcs

folder = str(pathlib.Path(__file__).parent.resolve())

if len(sys.argv) == 2:
    votes = funcs.ObviousWinnerReadsJsonFile(folder+"/"+sys.argv[1])
else:
    votes = funcs.ObviousWinnerReadsUserInput()
funcs.PrintVerdict(votes)

print() # last blank line