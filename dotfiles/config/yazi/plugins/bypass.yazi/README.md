# bypass.yazi

[Yazi](https://github.com/sxyazi/yazi) plugin for bidirectional skipping of directories which only have a single subdirectory

<https://github.com/Rolv-Apneseth/bypass.yazi/assets/69486699/5487537b-fe01-40e9-bc34-4d1116b491b5>

## Requirements

- [Yazi](https://github.com/sxyazi/yazi) v25.3.2+

## Installation

```bash
ya pkg add Rolv-Apneseth/bypass
```

### Manual

```sh
# Linux / MacOS
git clone https://github.com/Rolv-Apneseth/bypass.yazi.git ~/.config/yazi/plugins/bypass.yazi
# Windows
git clone https://github.com/Rolv-Apneseth/bypass.yazi.git %AppData%\yazi\config\plugins\bypass.yazi
```

## Usage

Add this to your `keymap.toml`:

```toml
[[mgr.prepend_keymap]]
on = [ "L" ]
run = "plugin bypass"
desc = "Recursively enter child directory, skipping children with only a single subdirectory"
[[mgr.prepend_keymap]]
on = [ "H" ]
run = "plugin bypass reverse"
desc = "Recursively enter parent directory, skipping parents with only a single subdirectory"
```

And that's it. You can bind any key you like, including overriding the default `enter` and `leave` bindings by setting them to `l` and `h` respectively.

Note that  if you're using the [smart enter tip](https://yazi-rs.github.io/docs/tips#smart-enter) from the documentation, this plugin can replace that entirely by using this keybind instead:

```toml
[[mgr.prepend_keymap]]
on = [ "l" ]
run = "plugin bypass smart-enter"
desc = "Open a file, or recursively enter child directory, skipping children with only a single subdirectory"
```
