--[[
    Copyright (c) Dmitriy. All rights reserved.
    Licensed under the MIT license. See LICENSE file in the project root for details.
]]

local RUI = LibStub('AceAddon-3.0'):GetAddon('RetailUI')
local moduleName = 'BuffFrame'
local Module = RUI:NewModule(moduleName, 'AceConsole-3.0', 'AceHook-3.0', 'AceEvent-3.0')

Module.buffFrame = nil

local function ReplaceBlizzardFrame(frame)
    frame.toggleButton = frame.toggleButton or CreateFrame('Button', nil, UIParent)
    local toggleButton = frame.toggleButton
    toggleButton.toggle = true
    toggleButton:SetPoint("LEFT", frame, "LEFT", 0, -3)
    toggleButton:SetSize(9, 17)
    toggleButton:SetHitRectInsets(0, 0, 0, 0)

    local normalTexture = toggleButton:GetNormalTexture() or toggleButton:CreateTexture(nil, "BORDER")
    normalTexture:SetAllPoints(toggleButton)
    SetAtlasTexture(normalTexture, 'CollapseButton-Left')

    toggleButton:SetNormalTexture(normalTexture)

    local highlightTexture = toggleButton:GetHighlightTexture() or toggleButton:CreateTexture(nil, "HIGHLIGHT")
    highlightTexture:SetAllPoints(toggleButton)
    SetAtlasTexture(highlightTexture, 'CollapseButton-Left')

    toggleButton:SetHighlightTexture(highlightTexture)

    toggleButton:SetScript("OnClick", function(self)
        if self.toggle then
            local normalTexture = self:GetNormalTexture()
            SetAtlasTexture(normalTexture, 'CollapseButton-Right')

            local highlightTexture = toggleButton:GetHighlightTexture()
            SetAtlasTexture(highlightTexture, 'CollapseButton-Right')

            for index = 1, BUFF_ACTUAL_DISPLAY do
                local button = _G['BuffButton' .. index]
                if button then
                    button:Hide()
                end
            end
        else
            local normalTexture = self:GetNormalTexture()
            SetAtlasTexture(normalTexture, 'CollapseButton-Left')

            local highlightTexture = toggleButton:GetHighlightTexture()
            SetAtlasTexture(highlightTexture, 'CollapseButton-Left')

            for index = 1, BUFF_ACTUAL_DISPLAY do
                local button = _G['BuffButton' .. index]
                if button then
                    button:Show()
                end
            end
        end

        self.toggle = not self.toggle
    end)

    local consolidatedBuffFrame = ConsolidatedBuffs
    consolidatedBuffFrame:SetMovable(true)
    consolidatedBuffFrame:SetUserPlaced(true)
    consolidatedBuffFrame:ClearAllPoints()
    consolidatedBuffFrame:SetPoint("RIGHT", toggleButton, "LEFT", 6, 0)
end

local function ShowToggleButtonIf(condition)
    if condition then
        Module.buffFrame.toggleButton:Show()
    else
        Module.buffFrame.toggleButton:Hide()
    end
end

local function GetUnitBuffCount(unit, range)
    local count = 0
    for index = 1, range do
        local name = UnitBuff(unit, index)
        if name then
            count = count + 1
        end
    end
    return count
end

function Module:OnEnable()
    self:RegisterEvent("PLAYER_ENTERING_WORLD")
    self:RegisterEvent("UNIT_AURA")
    self:RegisterEvent("UNIT_ENTERED_VEHICLE")
    self:RegisterEvent("UNIT_EXITED_VEHICLE")

    self.buffFrame = CreateUIFrame(BuffFrame:GetWidth(), BuffFrame:GetHeight(), "BuffFrame")
end

function Module:OnDisable()
    self:UnregisterEvent("PLAYER_ENTERING_WORLD")
    self:UnregisterEvent("UNIT_AURA")
    self:UnregisterEvent("UNIT_ENTERED_VEHICLE")
    self:UnregisterEvent("UNIT_EXITED_VEHICLE")
end

function Module:PLAYER_ENTERING_WORLD()
    ReplaceBlizzardFrame(self.buffFrame)

    ShowToggleButtonIf(GetUnitBuffCount("player", 16) > 0)

    CheckSettingsExists(Module, { 'buffs' })
end

function Module:UNIT_AURA(eventName, unit)
    if unit == 'vehicle' then
        ShowToggleButtonIf(GetUnitBuffCount("vehicle", 16) > 0)
    elseif unit == 'player' then
        ShowToggleButtonIf(GetUnitBuffCount("player", 16) > 0)
    end
end

function Module:UNIT_ENTERED_VEHICLE(eventName, unit)
    if unit ~= 'player' then return end

    ShowToggleButtonIf(GetUnitBuffCount("vehicle", 16) > 0)
end

function Module:UNIT_EXITED_VEHICLE(eventName, unit)
    if unit ~= 'player' then return end

    ShowToggleButtonIf(GetUnitBuffCount("player", 16) > 0)
end

function Module:LoadDefaultSettings()
    RUI.DB.profile.widgets.buffs = { anchor = "TOPLEFT", posX = 0, posY = -20 }
end

function Module:UpdateWidgets()
    local widgetOptions = RUI.DB.profile.widgets.buffs
    self.buffFrame:SetPoint(widgetOptions.anchor, widgetOptions.posX, widgetOptions.posY)
end

function Module:ShowEditorTest()
    HideUIFrame(self.buffFrame)
end

function Module:HideEditorTest(refresh)
    ShowUIFrame(self.buffFrame)
    SaveUIFramePosition(self.buffFrame, 'buffs')

    if refresh then
        self:UpdateWidgets()
    end
end

-- Reposition buff buttons and set their size
hooksecurefunc("BuffFrame_Update", function()
    local buffSize = 40       -- ← change buff icon size here
    local debuffSize = 46      -- ← change debuff icon size here
    local spacing = 5
    local buffsPerRow = 8
    local anchorX, anchorY = 26, -0
    local initialAnchor = consolidatedBuffFrame

    local previousButton = nil

    for i = 1, BUFF_ACTUAL_DISPLAY do
        local button = _G["BuffButton"..i]
        if not button then break end

        button:ClearAllPoints()
        button:SetSize(buffSize, buffSize)

        if i == 1 then
            button:SetPoint("TOPLEFT", initialAnchor, "TOPLEFT", anchorX, anchorY)
        elseif (i - 1) % buffsPerRow == 0 then
            local aboveIndex = i - buffsPerRow
            button:SetPoint("TOPLEFT", _G["BuffButton"..aboveIndex], "BOTTOMLEFT", 0, -spacing)
        else
            button:SetPoint("LEFT", previousButton, "RIGHT", spacing, 0)
        end

        previousButton = button
    end
	
	 for i = 1, BUFF_ACTUAL_DISPLAY do
        local button = _G["TempEnchant"..i]
        if not button then break end

        button:ClearAllPoints()
        button:SetSize(buffSize, buffSize)

        if i == 1 then
            button:SetPoint("TOPLEFT", initialAnchor, "TOPLEFT", anchorX, -55)
        elseif (i - 1) % buffsPerRow == 0 then
            local aboveIndex = i - buffsPerRow
            button:SetPoint("TOPLEFT", _G["TempEnchant"..aboveIndex], "BOTTOMLEFT", 0, -spacing)
        else
            button:SetPoint("LEFT", previousButton, "RIGHT", spacing, 0)
        end

        previousButton = button
    end

    -- Reposition and resize debuffs
    local previousDebuff = nil
    for i = 1, 16 do
        local button = _G["DebuffButton"..i]
        if not button then break end

        button:ClearAllPoints()
        button:SetSize(debuffSize, debuffSize)

        if i == 1 then
            button:SetPoint("TOPLEFT", initialAnchor, "TOPLEFT", anchorX, anchorY - (buffSize + 10) * 2)
        elseif (i - 1) % buffsPerRow == 0 then
            local aboveIndex = i - buffsPerRow
            button:SetPoint("TOPLEFT", _G["DebuffButton"..aboveIndex], "BOTTOMLEFT", 0, -spacing)
        else
            button:SetPoint("LEFT", previousDebuff, "RIGHT", spacing, 0)
        end

        previousDebuff = button
    end
end)
