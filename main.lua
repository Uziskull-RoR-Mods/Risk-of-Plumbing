----------------------
-- Risk of Plumbing --
----------------------
  -- by  Uziskull --
  ------------------

local disableTitleScreen = modloader.checkFlag("marioMod_disable_title_screen")
if not disableTitleScreen then
    require("code.titleScreen")
end

require("code.powerups")
require("code.qblocks")
require("code.mario")