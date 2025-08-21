-- DarkenUI.lua
local RUI = LibStub("AceAddon-3.0"):GetAddon("RetailUI")
local Module = RUI:NewModule("DarkenUI")
local color = { r = .3, g = .3, b = .3, a = .9}

 local ef=CreateFrame("Frame")
   
      ef:RegisterEvent("ADDON_LOADED")
         ef:SetScript("OnEvent", function(self, event, addon)
             if(addon=="Blizzard_TimeManager") then
                 for i,v in pairs({

		PlayerFrameTexture,
   		TargetFrameTextureFrameTexture,
  		PetFrameTexture,
		PartyMemberFrame1Texture,
		PartyMemberFrame2Texture,
		PartyMemberFrame3Texture,
		PartyMemberFrame4Texture,
		PartyMemberFrame1PetFrameTexture,
		PartyMemberFrame2PetFrameTexture,
		PartyMemberFrame3PetFrameTexture,
		PartyMemberFrame4PetFrameTexture,
   		FocusFrameTextureFrameTexture,
   		TargetFrameToTTextureFrameTexture,
   		FocusFrameToTTextureFrameTexture,
   		MinimapBorder,
		MiniMapMailBorder,
		MiniMapBattlefieldBorder,
		MiniMapLFGFrameBorder,
		CastingBarFrameBorder,
		FocusFrameSpellBarBorder,
		TargetFrameSpellBarBorder,
		
		
		-- 
		select(1, TimeManagerClockButton:GetRegions()), 
		select(1, GameTimeFrame:GetRegions()),

              }) do
  
                 v:SetVertexColor(.05, .05, .05)
		
	end    
        self:UnregisterEvent("ADDON_LOADED")
        ef:SetScript("OnEvent", nil)
    end
end)
     
          for i,v in pairs({
   		
		BonusActionBarTexture0,
		BonusActionBarTexture1,
		MainMenuBarTexture0,
		MainMenuBarTexture1,
		MainMenuBarTexture2,
		MainMenuBarTexture3,
        MainMenuMaxLevelBar0,
		MainMenuMaxLevelBar1,
		MainMenuMaxLevelBar2,
		MainMenuMaxLevelBar3,
		MainMenuXPBarTextureLeftCap,
        MainMenuXPBarTextureRightCap,
        MainMenuXPBarTextureMid,
        MainMenuXPBarTexture0,
		MainMenuXPBarTexture1,
		MainMenuXPBarTexture2,
		MainMenuXPBarTexture3,
		ReputationWatchBarTexture0,
        ReputationWatchBarTexture1,
        ReputationWatchBarTexture2,
        ReputationWatchBarTexture3,
		ReputationXPBarTexture0,
        ReputationXPBarTexture1,
        ReputationXPBarTexture2,
        ReputationXPBarTexture3,
		--ActionBar-ButtonUp-Normal,
		-- RUI_QuestTrackerFrame,
		
		
		
			
              }) do
  
                 v:SetVertexColor(.5, .5, .5)
  
              end 

          for i,v in pairs({
 
		-- MainMenuBarLeftEndCap,
                -- MainMenuBarRightEndCap,  

              }) do

                 v:SetVertexColor(.35, .35, .35)
  	      
	      end 


	local s = CreateFrame("Frame")
		s:RegisterEvent("ADDON_LOADED")
         	s:SetScript("OnEvent", function(self, event, addon)
             	if(addon=="Blizzard_ArenaUI") then
		ArenaEnemyFrame1Texture:SetVertexColor(0.1, 0.1, 0.1) ArenaEnemyFrame2Texture:SetVertexColor(0.1, 0.1, 0.1) ArenaEnemyFrame3Texture:SetVertexColor(0.1, 0.1, 0.1) ArenaEnemyFrame4Texture:SetVertexColor(0.1, 0.1, 0.1) ArenaEnemyFrame5Texture:SetVertexColor(0.1, 0.1, 0.1)
		end 
	end)
	
