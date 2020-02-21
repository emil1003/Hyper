
--Get lfs package
local lfs = require("lfs")

--Patch unpack on Lua >= 5.2
unpack = unpack or table.unpack

local args = {...}

--Set default options
local opts = {
	"--pickle-source=lib/Pickle.lua",
	"--minify-source=lib/Minify.lua",
	"--titanium-disable-check",
	"--vfs-allow-raw-fs-access",
	"--vfs-allow-raw-fs-access",
	"--source=Hyper",
	"--class-source=Hyper/Class",
	"--init=Hyper/Lua/Hyper.lua",
	"--pre-init=Hyper/Lua/pre-init.lua",
	"--output=Hyper.tpkg"
}

--Print build script info
print("build.lua invoked")

--Print working directory
print("Working directory: "..lfs.currentdir())

--Parse arguments
for _, arg in pairs(args) do
	if arg == "minify" or arg == "m" then
		table.insert(opts, "--minify")
	end
end

--Print options
print("Build options:")

for _, opt in pairs(opts) do
	print(opt)
end

--Execute
print("Invoking lib/package.lua...")

local package = assert(loadfile("lib/package.lua"))

local state, out = pcall(package, unpack(opts))

--Print status
if state then
	print("[ OK ] lib/package.lua succeeded")
else
	print("[FAIL] lib/package.lua encountered error:")
	error(out)
end
