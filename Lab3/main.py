import pathlib
import sys
from SemanticNetwork import SemanticNetwork

folder = str(pathlib.Path(__file__).parent.resolve())

jsonFileNameEntities = folder + "/entities.json"
jsonFileNameRelations = folder + "/relations.json"

m = SemanticNetwork(jsonFileNameEntities, jsonFileNameRelations)

print() # first blank line

if len(sys.argv) == 1:
    m.PrintHelp()
    exit()

if sys.argv[1] == "-all":
    m.ListAll()
else:
    m.ListRelationsWith(sys.argv[1])

print() # last blank line before exit
