import sys
import pathlib
import funcs

folder = str(pathlib.Path(__file__).parent.resolve())

match sys.argv[1].lower():
    case '-obvious':
        if len(sys.argv) == 3:
            votes = funcs.ObviousWinnerReadsJsonFile(folder+"/"+sys.argv[2])
        else:
            votes = funcs.ObviousWinnerReadsUserInput()
        funcs.PrintVerdict(votes)
    case '-borda':
        if len(sys.argv) == 3:
            table = funcs.BordaReadsJsonFile(folder+"/"+sys.argv[2])
        else:
            table = funcs.BordaReadsUserInput()
        points = funcs.BordaCountsPoints(table)
        funcs.PrintVerdict(points)
    case _:
        funcs.PrintHelp()
        print()
        exit()

print() # last blank line