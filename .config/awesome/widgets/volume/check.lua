local fd = io.popen(os.getenv("HOME") .. "/.config/awesome/widgets/volume/pa-vol.sh " .. "plus")
local status = fd:read("*a")
fd:close()
error(status)
