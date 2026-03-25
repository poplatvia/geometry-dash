module setup;

import std.file;
import std.stdio;
import std.string;
import std.conv;

import models.orb;
import models.portal;
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

        // normalize to cube size. Multiply everything by 110/15
        x = cast(int)(x * (110.0 / 15.0))/2+55;
        y = cast(int)(y * (110.0 / 15.0));

        int offset = 110/2;

        switch (type)
        {
            case "1": // block
                objects ~= new Block(x - offset, (ground.groundY()) - y/2);
                break;
            case "8": // Spike
                objects ~= new Spike(x - offset, (ground.groundY()) - y/2);
                break;
            case "39": // small spike
                objects ~= new SmallSpike(x - offset, (ground.groundY()) - y + offset);
                break;
            case "83": // block made of 9 subblocks
                objects ~= new Block(x - offset, (ground.groundY()) - y/2);
                break;
            case "141": //purple orb
                objects ~= new PurpleOrb(x - offset, (ground.groundY()) - y + offset, 20);
                break;
            case "36": //yellow orb
                objects ~= new YellowOrb(x - offset, (ground.groundY()) - y + offset, 20);
                break;
            case "1333": //red orb
                objects ~= new RedOrb(x - offset, (ground.groundY()) - y + offset, 20);
                break;
            case "1330": //black orb
                objects ~= new BlackOrb(x - offset, (ground.groundY()) - y + offset, 20);
                break;
            case "10": // blue portal
                objects ~= new BluePortal(x - offset, (ground.groundY()) - y/2 + offset);
                break;
            case "11": // yellow portal
                objects ~= new YellowPortal(x - offset, (ground.groundY()) - y/2 + offset);
                break;
            case "2926": //green portal
                objects ~= new GreenPortal(x - offset, (ground.groundY()) - y/2 + offset);
                break;
            default:
                writeln("Unknown object type: ", type);
                break;
        }
    }
    return objects;
}