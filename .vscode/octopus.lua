--[[
    这里是章鱼开发模块
    你可以用这个库实现一系列功能。    
--]]

Octopus = {
    logic = {
        

    },
    Assets = {
        SOUND = {
            MISC = {},
            
        },
        PICTURES = {

        },
        ICONS = {

        },
    },
    GUI = {
        
        build = function (...)---@type string
            local result = ""
            for i,v in pairs(...) do
                result = result..v.."\n"

            end
            return result
            
        end,
        PixelMonitor = function ()
            
        end
        
    }

}