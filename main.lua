-- Author : Prosper
-- Addon made for Pleinozas

-- Hello

print("ChatExtractor - /chextract - /chex")
print("The extracted data is in WTF\\Account\\<account_number>\\SavedVariables\\ChatExtractor.lua")
print("To force a save, just use /reload")


-- Env

ED = nil
recording = false

-- Catching system messages

local msg_frame = CreateFrame("Frame")
msg_frame:RegisterEvent("CHAT_MSG_SYSTEM")
msg_frame:SetScript("OnEvent",
    function(self, event, ...)
	    local arg1 = ...

        if recording and string.find(arg1, "Hgameobject_entry:") then
            --print(string.len(arg1))
            --print(tostring(arg1))
            Id = tonumber(string.match(arg1, '%d*'))
            Name = string.sub(string.match(arg1, '%[.*%]'), 2, -2)
            --print(Id.." - "..Name)

            ED[Id] = Name
            ED["size"] = ED["size"] + 1
            --print(ED["size"])

            ExtractedData = ED -- save
        end

end)

-- Slash commands

SLASH_CHEXTR1 = "/chextract"
SLASH_CHEXTR2 = "/chex"
SlashCmdList["CHEXTR"] = function(msg)
    if msg == "start" then
        print("ChatExtractor now records system messages")
        recording = true
    elseif msg == "end" then
        print("ChatExtractor no longer records system messages")
        recording = false
    elseif msg == "reset" then
        print("ChatExtractor : content deleted")
        recording = false
        ExtractedData = {}
        ExtractedData["size"] = 0
        ED = ExtractedData
    elseif msg == "size" then
        print(ED["size"])
    else
        print("ChatExtractor : ")
        print(" /chextract start    : start recording system messages")
        print(" /chextract end      : stop recording system messages")
        print(" /chextract reset    : delete all saved content")
    end
end

-- Init on load

local load_frame = CreateFrame("Frame")
load_frame:RegisterEvent("ADDON_LOADED")
load_frame:SetScript("OnEvent",
    function(self, event, ...)
        --print(ExtractedData)
        recording = false
        ED = ExtractedData
        if ED == nil then
            ED = {}
            ED["size"] = 0
        end
        if ED["size"] == nil then
            ED = {}
            ED["size"] = 0
        end
        --print(ED)
        --print(ED["size"])
end)
