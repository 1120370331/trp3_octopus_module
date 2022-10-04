--[[
    这里是章鱼开发模块
    你可以用这个库实现一系列功能。    
--]]

Octopus = {
    logic = {
        conclude = function (table,obj) --是否有此值
    
            for i,v in pairs(table) do
    
                if v == obj then
                    return true
                end
    
            end
    
            return false
    
    
    
        end,
        haskey = function (table,key)--是否有此键
            for i,v in pairs(table,key) do
                if tostring(key) == tostring(i) then
                    return true
                end
    
            end
            return false
    
    
        end,
        allset = function(table,value)
    
            for i,v in pairs(table)do
                if type(i) == "table" then
                    Octopus.logic.allset(table,value)
                else
                    table[i] = value
                end
            end
    
            return table
    
        end ,
        isEmpty = function (tbl)
            if next(tbl) ~= nil then
                return false
            else
                return true
            end
        end,
    
        tostring = function ( tb )
    
            --禁止使用以下字符：" [ ] $ ^
    
            local str = "{"
    
            for i,v in pairs(tb) do
    
                if type(v) == "string" then
    
                    str = str.."["..tostring(i).."] = ".."$"..v.."^"..","
                
                elseif type(v) == "table" then
    
                    str = str.."["..tostring(i).."] = "..Octopus.logic.tostring(v)..","
    
                else
    
                    str = str.."["..tostring(i).."] = ".."$"..tostring(v).."^"..","
                end
    
            end
    
            str = str.."}"
    
            return str
    
            --[[
                [key] = $value$
            ]]
    
    
    
        end,
    
        strtotable = function (tstring,runargs)
    
            local function wordstotable(str) --将字符串拆开，每个字符表内的一个元素。
                local i = 0
                local tbl = {}
                while i<= string.len(str) do
                    i = i+1
                    local tmp = string.sub(str,i,i)
                    tbl[i] = tmp
    
                end
                return tbl
            end
    
    
    
            tstring = string.sub(tstring,2,tstring.len(tstring)-1)
    
            local onkeytyping = false
            local onvaluetyping = false
            local onmorestrtyping = false
    
            local tbl = {}
    
            local count_key = 0
    
            local tempkey = ""
    
            local tempfield = ""
    
            local sontableamount = 0
    
            if type(runargs) == "nil" then
                runargs = {
    
                    tablelevel = 1,
                    tableamount = 0,
    
                }
            end
    
            local level = "【第 "..tostring(runargs["tablelevel"]).." 层】"
    
            --Logger.log(level.."开始处理，要处理的字符串："..tstring)
    
    
    
    
    
            for i,v in pairs(wordstotable(tstring)) do
    
                --Logger.log(level.."一次新循环，onkeytyping = "..tostring(onkeytyping).."| onvaluetyping = "..tostring(onvaluetyping).."| onmorestrtyping = "..tostring(onmorestrtyping).."| count_key = "..tostring(count_key).."| tempfield = "..tempfield.."| 已有发现子表数量 = " ..tostring(sontableamount))
    
                if tostring(v) == "{" then
    
                    if sontableamount == 0 and onvaluetyping == false then
    
    
    
                        onmorestrtyping = true
    
                        --Logger.log(level.."开始处理一个表中表")
    
                    end
    
                end
    
    
    
    
                if onkeytyping == false or onvaluetyping == false or onmorestrtyping  == false then
    
    
                    if tostring(v) == "[" and onmorestrtyping == false then
    
                        if count_key == 0 then
    
                            --Logger.log(level.."开始处理一个键")
    
                            onkeytyping = true
    
                        end
    
    
    
    
                    elseif tostring(v) == "$" and onmorestrtyping == false then
    
                        --Logger.log(level.."开始处理一个值")
    
                        onvaluetyping = true
    
                    end
    
                end
                if onkeytyping  == true and onvaluetyping == false and onmorestrtyping == false then
    
                    if tostring(v) == "]" then
    
                        tbl[tempfield] = "NOVALUE"
    
                        --Logger.log(level.."已完成储存一个键："..tempfield)
    
                        count_key = count_key + 1
    
                        --Logger.log(level.."现有的键数量："..tostring(count_key))
    
                        tempkey = tempfield
    
                        --Logger.log(level.."临时的键值："..tempkey)
    
                        tempfield = ""
    
                        --Logger.log(level.."（键）tempfield清零")
    
                        onkeytyping = false
    
                    else
                        if tostring(v) ~= "[" then
    
                        tempfield = tempfield..tostring(v)
                        --Logger.log(level.."（键）tempfield被写为"..tempfield)
                        end
                    end
                end
    
                if onvaluetyping == true and onkeytyping == false and onmorestrtyping == false then
    
                    if tostring(v) == "^" then
    
                        tbl[tempkey] = tempfield
    
                        --Logger.log(level.."已完成储存一个值："..tempfield)
    
                        count_key = count_key - 1
    
                        --Logger.log(level.."现有的键数量："..tostring(count_key))
    
                        tempkey = ""
    
                        tempfield = ""
    
                        --Logger.log(level.."（值）tempfield清零")
    
                        onvaluetyping = false
    
                    else
    
                        if tostring(v) ~= "$" then
    
    
    
                        tempfield = tempfield..tostring(v)
                        --Logger.log(level.."（值）tempfield被写为"..tempfield)
                        end
                    end
                end
    
    
    
    
                if onmorestrtyping == true then
    
    
    
    
    
                    if tostring(v) == "{" then
                        sontableamount = sontableamount + 1
    
                        tempfield = tempfield..tostring(v)
                    end
    
    
    
                    if tostring(v) == "}"  then
    
                        --Logger.log(level.."}处理中，目前有子表："..tostring(sontableamount))
    
    
                        if tonumber(sontableamount) == 1 then
    
    
    
                            tempfield = tempfield..tostring(v)
    
                            runargs["tablelevel"] = runargs["tablelevel"] + 1
    
    
    
    
                            local temptable = Octopus.logic.strtotable(tempfield,runargs)
    
                            runargs["tablelevel"] = runargs["tablelevel"] - 1
    
                            --Logger.log(level.."已完成处理一个嵌套表！")
    
                            tbl[tempkey] = temptable
    
                            count_key = count_key - 1
    
                            tempfield = ""
    
                            sontableamount = sontableamount - 1
    
    
    
                            --Logger.log(level.."（表）tempfield清零")
    
                            onmorestrtyping = false
    
                        else
    
                            tempfield = tempfield..tostring(v)
    
                            sontableamount = sontableamount - 1
    
                            --Logger.log(level.."已录入完一个子表")
    
    
    
    
                        end
                    end
    
    
    
                    if tostring(v) ~= "{" and tostring(v) ~= "}" then
    
    
    
    
    
    
    
                        --Logger.log(level.."（表）tempfield被写为"..tempfield)
    
                        tempfield = tempfield..tostring(v)
    
                        --Logger.log(level.."tempfield被写为"..tempfield)
    
    
                    end
    
    
    
    
                end
    
    
            end
    
            --Logger.log(level.."已返回最终结果。")
    
            return tbl
    
    
    
        end,
        
    
    
        complete = function ( tb ,targettb,temp)---@targettb为模板表，按照targettb将tb中不包含的键一一赋值
            if temp == nil then
                model = targettb
            else
                model = temp
            end
    
    
            for i , v in pairs(model) do
    
                if type(v) ~= "table" and type(tb[i]) == nil then
    
                    tb[i] = model[i]
                end
    
                if type(v) == "table" and type(tb[i]) == "nil" then
    
                    tb[i] = model[i]
                end
    
                    
    
                if type(v) == "table" and type(tb[i]) == "table" then
    
                    tb[i] = Octopus.logic.complete(tb[i],targettb,v)
                end
    
    
    
            end
    
            return tb
    
        end,
    
        length = function (table)
            
            local count = 0
            for i,v in pairs(table) do
                count = count + 1
            end
            return count
            
    
        end
    
    },

    Assests = {
        PICTURES = {},
        SOUNDS = {},
        ICONS = {},

    },
    GUI = {
        PixelMonitor = {
            new = function (size)---@param size table {length,width}
                local length = size[1] 
                local width = size[2]
                --could not be nil
                length = length or 32
                width = width or 32
                local monitor = {}
                local a = 0
                local b = 0
                
                local function drawapixel()
                    return {
                        colour = "FFFFFF",
                        link = "NOLINK",
                    }
                end
                while a < length do
                    a = a + 1
                    monitor[tostring(a)] = {}
                    while b < width do
                        b = b + 1
                        monitor[tostring(a)][tostring(b)] = drawapixel()
                        
                    end
                end
                return monitor


            end,
            set_colour = function (monitor,mode,Aargs) --mode : point[{x,y}],xaxis[x],yaxis[y],square[x1,y1,x2,y2],circle[x,y],fill[x,y]
                local function coordinate_is_legal(monitor,coordinate) ---@param coordinate table {x,y}
                    coordinate[1] = coordinate[1] or -999
                    coordinate[2] = coordinate[2] or -999
                    local gety = function (m)
                        local a = 0
                        for i,v in pairs(m["1"]) do
                            a = a + 1
                            
                        end
                        return a
                        
                    end
                    local x = Octopus.logic.length(monitor)
                    local y = gety(monitor)
                    if (coordinate[1] < x) and (coordinate[2] < y ) then
                        return true
                    else
                        return false
                    end
                end
                
            end,
            
            
        }
        
    }
    ,}
