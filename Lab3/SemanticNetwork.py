import json

class SemanticNetwork:

    def __init__(self, fileNameEntities: str, fileNameRelations: str) -> None:
        self.Entities = self.ReadJsonFileEntities(fileNameEntities)
        self.Relations = self.ReadJsonFileRelations(fileNameRelations)

    def ReadJsonFileEntities(self, jsonFileName: str) -> dict[str, str]:
        entities = {}
        with open(jsonFileName, "r", encoding='utf-8') as read_entities:
            raw_data = json.load(read_entities)
            for key, value in raw_data.items():
                entities[key] = value
        return entities
    
    def ReadJsonFileRelations(self, jsonFileName: str) -> list[list[str]]:
        relations = []
        with open(jsonFileName, "r", encoding='utf-8') as read_relations:
            raw_data = json.load(read_relations)
            for item in raw_data:
                relations += [item]
        return relations

    def ListRelationsWith(self, entity: str) -> None:
        """
        Lists relations where entity take part in. \n
        Parameter \"entity\" can be an id or a value of an entity. 
        """

        if self.Entities.get(entity): 
            id = entity
        else:
            id = self._GetEntityIdByValue(entity)
            # print(f"{id} = {entity}\n") # debug, checking if id is correct
        
        if id == None:
            print("Entity with such id or name doesn't exist")
            return

        count = 1
        for item in self.Relations:
            if id in (item[0], item[2]):
                print(f"{count}. {self.Entities[item[0]]} {item[1]} {self.Entities[item[2]]}")
                count += 1

    def ListAll(self) -> None:
        count = 1
        for item in self.Relations:
            print(f"{count}. {self.Entities[item[0]]} {item[1]} {self.Entities[item[2]]}")
            count += 1
    
    def _GetEntityIdByValue(self, name: str) -> str | None:
        """ Returns enitity's id or None. """
        for id, value in self.Entities.items():
                if value == name:
                    return id
        return None
    
    def PrintHelp(self) -> None:
        print("""Try running: 
- \"python main.py -all\" to get a list of all relations
- \"python main.py id100\" to select relations with specific entity
- \"python main.py 'Robert Pattinson'\" to select relations with specific entity
""")
