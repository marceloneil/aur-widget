# AUR widget for awesomewm

A simple widget for awesomewm that notifies you when specified AUR packages are out of date

### Setup
```
cd ~/.config/awesome
git clone https://github.com/marceloneil/aur-widget.git
vim rc.lua
```
Add the following after initializing beautiful:
```
local aur = require("aur-widget.aur")
aur.init(3607)  -- Updates every hour
```
Then add the `aur.widget` into the wibox:
```
...
wibox.widget.systray(),
aur.widget,
mytextclock,
...
```

### Add packages
Add a new python file for each package in `packages/`. Use `example.py` for reference. Add each package to `__init__.py` when you are done. Note: the method name must match the filename.
