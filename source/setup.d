module setup;

import std.file;
import std.stdio;
import std.string;
import std.conv;

import models.orb;
import models.ground;
import models.spike;
import models.block;
import models.level_object;

LevelObject[] loadObjectsFromFile(ref Ground ground, string filename = "level.csv")
{
    string[] lines = readText(filename).splitLines();
    LevelObject[] objects;
    foreach (line; lines)
    {
        auto parts = line.split(',');
        if (parts.length != 3)
        {
            writeln("Invalid line format: ", line);
            continue;
        }

        string type = parts[0].strip();
        int x = to!int(parts[1].strip());
        int y = to!int(parts[2].strip());

        switch (type)
        {
            case "1": // block
                objects ~= new Block(x, (ground.groundY() + 15) - y);
                break;
            case "8": // Spike
                objects ~= new Spike(x, (ground.groundY() + 15) - y);
                break;
            case "83": // block made of 9 subblocks
                objects ~= new Block(x, (ground.groundY() + 15) - y);
                break;
            case "141": //purple orb
                objects ~= new PurpleOrb(x, (ground.groundY() + 15) - y, 20);
                break;
            case "36": //yellow orb
                objects ~= new YellowOrb(x, (ground.groundY() + 15) - y, 20);
                break;
            case "1333": //red orb
                objects ~= new RedOrb(x, (ground.groundY() + 15) - y, 20);
                break;
            case "1330": //black orb
                objects ~= new BlackOrb(x, (ground.groundY() + 15) - y, 20);
                break;
            default:
                writeln("Unknown object type: ", type);
                break;
        }
    }
    return objects;
}