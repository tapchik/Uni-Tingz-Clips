using System.Collections.Generic;
using System.Text.Json;
using System.Text.Json.Serialization;

class Program {
    public static void Main() {

        string fileNameEntities = @"entities.json";
        string fileNameRelations = @"relations.json";
        Machine Machine = new Machine(fileNameEntities, fileNameRelations);

        // one

        foreach (var item in Machine.Entities) {
            Console.WriteLine($"{item.Key}: {item.Value}");
        }

        // two

        foreach (var item in Machine.Relations) {
            Console.WriteLine($"{item[0]} {item[1]} {item[2]}");
        }

        // three

        Console.WriteLine();

        foreach (var item in Machine.Relations) {
            Console.WriteLine($"{Machine.Entity(item[0])} {item[1]} {Machine.Entity(item[2])}");
        }

        // four

        Console.WriteLine("\n FOUR \n");

        foreach (var item in Machine.Relations) {
            if (item[0] == "id100" || item[2] == "id100")
                Console.WriteLine($"{Machine.Entity(item[0])} {item[1]} {Machine.Entity(item[2])}");
        }

        //Console.WriteLine(Machine.Entities["id002"]);
    }
}

public class Machine {
    
    public Dictionary<string, string> Entities;
    public List<string[]> Relations;

    public Machine(string fileNameEntities, string fileNameRelations) {
        Entities = ReadJsonFileEntities(fileNameEntities);
        Relations = ReadJsonFileRelations(fileNameRelations);
    }
    
    public Dictionary<string, string> ReadJsonFileEntities(string filename) {
        string jsonstring = File.ReadAllText(filename);
        var entities = JsonSerializer.Deserialize<Dictionary<string, string>>(jsonstring)!;
        return entities;
    }

    public List<string[]> ReadJsonFileRelations(string filename) {
        string jsonstring = File.ReadAllText(filename);
        var relations = JsonSerializer.Deserialize<List<string[]>>(jsonstring)!;
        return relations;
    }

    public string Entity(string id) {
        return Entities[id];
    }
}