import os, ospaths, streams, nre
import uuids

let params = commandLineParams()

let guidRe = re"(?m)^(\s*guid: )[a-z0-9]+$"
let newGuidRe = re"-"

proc replaceGuid(part: RegexMatch): string =
    let captures = part.captures()
    captures[0] & ($genUUID()).replace(newGuidRe, "")

for param in params:
    for file in walkDirRec(param):
        let (dir, name, ext) = splitFile(file)
        if ext == ".meta":
            let content = readFile(file)
            let newContent = content.replace(guidRe, replaceGuid)
            writeFile(file, newContent)
