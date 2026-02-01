#!/usr/bin/env python3

import asyncio
import os
import sys
from pathlib import Path

async def run_command(*args):
    process = await asyncio.create_subprocess_exec(
        *args,
        stdout=asyncio.subprocess.PIPE,
        stderr=asyncio.subprocess.PIPE
    )
    stdout, stderr = await process.communicate()
    if process.returncode != 0:
        print(f"Error running {' '.join(args)}: {stderr.decode().strip()}", file=sys.stderr)
    return stdout.decode().strip()

async def apply_gtk3_colors(config_dir: Path):
    gtk3_dir = config_dir / "gtk-3.0"
    colors_file = gtk3_dir / "noctalia.css"
    gtk_css = gtk3_dir / "gtk.css"

    if not colors_file.exists():
        print(f"Error: noctalia.css not found at {colors_file}", file=sys.stderr)
        return False

    if gtk_css.is_symlink():
        gtk_css.unlink()
    elif gtk_css.exists():
        backup_name = f"gtk.css.backup.{int(os.path.getmtime(gtk_css))}"
        gtk_css.rename(gtk3_dir / backup_name)
        print(f"Backed up existing gtk.css to {backup_name}")

    gtk_css.symlink_to("noctalia.css")
    print(f"Created symlink: {gtk_css} -> noctalia.css")
    return True

async def apply_gtk4_colors(config_dir: Path):
    gtk4_dir = config_dir / "gtk-4.0"
    colors_file = gtk4_dir / "noctalia.css"
    gtk_css = gtk4_dir / "gtk.css"
    gtk4_import = '@import url("noctalia.css");'

    if not colors_file.exists():
        print(f"Error: GTK4 noctalia.css not found at {colors_file}", file=sys.stderr)
        return False

    gtk_css.write_text(gtk4_import)
    print("Updated GTK4 CSS import")
    return True

async def refresh_theme():
    raw_theme = await run_command("gsettings", "get", "org.gnome.desktop.interface", "gtk-theme")
    current_theme = raw_theme.strip("'")
    
    raw_scheme = await run_command("gsettings", "get", "org.gnome.desktop.interface", "color-scheme")
    current_scheme = raw_scheme.strip("'")
    
    if not current_theme: current_theme = "adw-gtk3-dark"
    if not current_scheme: current_scheme = "prefer-dark"
        
    temp_scheme = "default" if current_scheme == "prefer-dark" else "prefer-dark"

    # await run_command("gsettings", "set", "org.gnome.desktop.interface", "color-scheme", temp_scheme)
    # await run_command("dconf", "write", "/org/gnome/desktop/interface/color-scheme", f"'{temp_scheme}'")
    
    # await run_command("gsettings", "set", "org.gnome.desktop.interface", "gtk-theme", "")
    # await run_command("dconf", "write", "/org/gnome/desktop/interface/gtk-theme", "''")
    
    # await asyncio.sleep(0.01)
    
    await run_command("gsettings", "set", "org.gnome.desktop.interface", "color-scheme", current_scheme)
    await run_command("dconf", "write", "/org/gnome/desktop/interface/color-scheme", f"'{current_scheme}'")
    
    await run_command("gsettings", "set", "org.gnome.desktop.interface", "gtk-theme", current_theme)
    await run_command("dconf", "write", "/org/gnome/desktop/interface/gtk-theme", f"'{current_theme}'")

async def main():
    config_dir_path = sys.argv[1] if len(sys.argv) > 1 else os.path.expanduser("~/.config")
    config_dir = Path(config_dir_path)

    if not config_dir.is_dir():
        print(f"Error: Config directory not found: {config_dir}", file=sys.stderr)
        sys.exit(1)

    (config_dir / "gtk-3.0").mkdir(parents=True, exist_ok=True)
    (config_dir / "gtk-4.0").mkdir(parents=True, exist_ok=True)

    results = await asyncio.gather(
        apply_gtk3_colors(config_dir),
        apply_gtk4_colors(config_dir)
    )

    if all(results):
        await refresh_theme()
        print("GTK colors applied successfully")
    else:
        sys.exit(1)

if __name__ == "__main__":
    asyncio.run(main())
