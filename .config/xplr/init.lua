version = "0.10.1"

package.path = os.getenv("HOME") .. '/.config/xplr/plugins/?/src/init.lua'

require("zoxide").setup()

-- Or

require("zoxide").setup{
  mode = "default",
  key = "Z",
}

-- Type `Z` to spawn zoxide prompt.
