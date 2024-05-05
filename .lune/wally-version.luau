local fs = require("@lune/fs")
local serde = require("@lune/serde")
local stdio = require("@lune/stdio")

local manifest = serde.decode("toml", fs.readFile("wally.toml"))
stdio.write(manifest.package.version)
