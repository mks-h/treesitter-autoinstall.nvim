# treesitter-autoinstall

This is a very simple plugin that provides automatic installation for the new
rewrite of [nvim-treesitter][nvim-treesitter], since it no longer provides such
option.

[nvim-treesitter]: https://github.com/nvim-treesitter/nvim-treesitter/tree/main

## Usage

You need to call the setup function in order for the plugin to work.

```lua
require("treesitter-autoinstall").setup({
	ignore = { "lua" } -- Optionally, provide a list of filetypes to ignore
})
```

## License

   Copyright 2025 Maksym Hazevych

   Licensed under the Apache License, Version 2.0 (the "License");
   you may not use this file except in compliance with the License.
   You may obtain a copy of the License at

       http://www.apache.org/licenses/LICENSE-2.0

   Unless required by applicable law or agreed to in writing, software
   distributed under the License is distributed on an "AS IS" BASIS,
   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
   See the License for the specific language governing permissions and
   limitations under the License.
