
unpack = unpack or table.unpack

local args = {...}

local opts = {
	"--pickle-source=lib/Pickle.lua",
	"--minify-source=lib/Minify.lua",
	"--titanium-disable-check",
	"--vfs-allow-raw-fs-access",
	"--vfs-allow-raw-fs-access",
	"--source=Hyper",
	"--class-source=Hyper/Class",
	"--init=Hyper/Lua/SystemPreload.lua",
	"--pre-init=Hyper/Lua/pre-init.lua",
	"--output=Hyper.tpkg"
}

for _, arg in pairs(args) do
	if arg == "minify" or arg == "m" then
		table.insert(opts, "--minify")
	end
end

assert(loadfile("lib/package.lua"))(unpack(opts))
