local _M = {}

local mt = { __index = _M }

--- Create header.
-- @param lines     header lines
-- @return a header
function _M.new(lines)
    return setmetatable(lines or {}, mt)
end

--- Get the value of the first header of the specified name.
-- @param name    header name
-- @return the first header value
function _M.get(self, name)
    local target_name = string.lower(name)
    local sep = ': '
    for _, line in ipairs(self) do
        local i = string.find(line, sep, 1, true)
        if i ~= nil then
            if string.lower(string.sub(line, 1, i - 1)) == target_name then
                return string.sub(line, i + #sep)
            end
        end
    end
    return nil
end

-- Add a header.
-- @param name    header name
-- @param value   header value
function _M.add(self, name, value)
    local line = string.format('%s: %s', name, value)
    self:add_line(line)
end

-- Add a header line.
-- @param line    header line
function _M.add_line(self, line)
    table.insert(self, line)
end

function _M.to_opt(self)
    if #self == 0 then
        return nil
    end
    return self
end

return _M

