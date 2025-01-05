--Int4 = Dword

function FloatToInt4(value)
    local float = string.pack("f", value)
    local int4 = string.unpack("I4", float)
    return int4
end

function Int4ToFloat(value)
    local int4 = string.pack("I4", value)
    local float = string.unpack("f", int4)
    return float
end

---------------------  DWORD XOR  ---------------------
local d = gg.getResults(gg.getResultsCount())
local f = d[1].value

--Usually,dword xor matchs with the encrypted value.
--So, dont need to convert anything.

--Edit value
local dval = 111

--This is your XOR Key value
gg.setValues({ { address = d[1].address + 0x0, flags = gg.TYPE_DWORD, value = f } })
--This will be your XOR encrypted value, "address = x[1].address + 0x0" you have to change this hex offset according to your game.
--In my game, 0x4 is encrypted value and 0xC is raw value.
gg.setValues({ { address = d[1].address + 0x4, flags = gg.TYPE_DWORD, value = bit32.bxor(f, dval) } })
--This is your raw value, if you change this value without xoring, game will crash.
gg.setValues({ { address = d[1].address + 0xC, flags = gg.TYPE_DWORD, value = dval } })

---------------------  FLOAT CONVERTION  ---------------------
--Find XOR Key with searching.
local x = gg.getResults(gg.getResultsCount())
local z = x[1].value
--Convert float to int4
local y = FloatToInt4(z)

--Edit value
local val1 = 0.3
--Conver float to int4
local val = FloatToInt4(val1)
--This is your XOR Key value
gg.setValues({ { address = x[1].address + 0x0, flags = gg.TYPE_DWORD, value = y } })
--This will be your XOR encrypted value, "address = x[1].address + 0x0" you have to change this hex offset according to your game.
--In my game, 0x4 is encrypted value and 0xC is raw value.
gg.setValues({ { address = x[1].address + 0x4, flags = gg.TYPE_DWORD, value = bit32.bxor(y, val) } })
--This is your raw value, if you change this value without xoring, game will crash.
gg.setValues({ { address = x[1].address + 0xC, flags = gg.TYPE_DWORD, value = val } })
--After xoring your value, you have to swap middle bytes.if they dont match.
--Usually, you have to swap 2nd and 3rd byte.
--Float value's xor key and encrypted value arent match at all. With swapping middle bytes we are getting the correct key value.

--Get the middle bytes
local byte1 = gg.getValues({ { address = x[1].address + 0x1, flags = gg.TYPE_BYTE } })
local byte2 = gg.getValues({ { address = x[1].address + 0x2, flags = gg.TYPE_BYTE } })
--Swap the middle bytes
gg.setValues({ { address = x[1].address + 0x1, flags = gg.TYPE_BYTE, value = byte2[1].value } })
gg.setValues({ { address = x[1].address + 0x2, flags = gg.TYPE_BYTE, value = byte1[1].value } })