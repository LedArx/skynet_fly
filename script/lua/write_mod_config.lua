local assert = assert
local ARGV = {...}
local skynet_fly_path = ARGV[1]
assert(skynet_fly_path,'缺少 skynet_fly_path')

package.cpath = skynet_fly_path .. "/luaclib/?.so;"
package.path = './?.lua;' .. skynet_fly_path .."/lualib/?.lua;"

local lfs = require "lfs"
local json = require "cjson"
local util = require "util"

local skynet_path = skynet_fly_path .. '/skynet/'
local server_path = "./"

local mod_config_path = server_path .. '/' .. 'mod_config.lua'

local old_mod_config = loadfile(mod_config_path)

if not old_mod_config then
    local file = io.open(mod_config_path,'w+')
    assert(file)
    local str = util.readallfile(server_path.. '/load_mods.lua')
    file:write(str)
    file:close()
else
    local new = require "load_mods"
    local old = old_mod_config()
    local def = util.check_def_table(new,old)
    print(util.dump(def))
end