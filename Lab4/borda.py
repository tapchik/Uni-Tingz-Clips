import sys
import pathlib
import funcs

folder = str(pathlib.Path(__file__).parent.resolve())

if len(sys.argv) == 2:
    table = funcs.BordaReadsJsonFile(folder+"/"+sys.argv[1])
else:
    table = funcs.BordaReadsUserInput()
points = funcs.BordaCountsPoints(table)
funcs.PrintVerdict(points)

print() # last blank line