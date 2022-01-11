# ZSH and rofi Version

I wanted some fuzzy feeling in the way I can search in my abbrevations. And some interaction with greenclip.

Two new tools in the spirit of texpander

* texpander.zsh
* clippy.zsh

For this to work one needs 

* greenclip installed and daemon running
* rofi installed
* zsh installed (bash would remove newlines where rofi needs them)

For arch based linux one can do 

```
yay -S rofi-greenclip zsh xsel xdotool
systemctl --user enable greenclip.service
```

follow the rest of the original guide to setup this scipts in your desktop environment.

# Texpander

Texpander is a simple text expander for Linux. It is sort of like Autokey, except it works off of text files that you put in your `~/.texpander` directory. Texpander is a bash script that uses xclip, xdotool, and zenity to let you type an abbreviation for something and it expands to whatever you have in the matching text file.

## Installation

1. Put `texpander.sh` somewhere on your system, perhaps your `~/bin` directory.
1. Create a keyboard shortcut that calls `~/bin/texpander.sh`
1. Create a `~/.texpander` directory where you store text files for expanding abbreviations

Texpander relies on a couple command line tools:

- xdotool
- zenity
- xsel

If those aren't already installed on your system you can probably grab them from your distros package manager without any trouble. For example for Ubuntu you can get what you need with the following commands.

```
sudo apt install xsel 
sudo apt install xdotool 
sudo apt install zenity
```

## Usage

The text expansion files reside in your `~/.texpander` directory and can be organized in subdirectories. Name the files in the format of `abbreviation` where the filename is the thing you want to type and the content of the file is what you want to have pasted into your document.

I have `crtl+space` assigned to run `~/bin/texpander.sh`. So, if I'm typing an email, it doesn't matter if I'm in gmail (using Firefox, Chrome, Opera, or Vivaldi), Thunderbird, Vim, or Nylas, the workflow is the same. I have a couple different email signatures that I use. For example, if want to use my email signature, I'll create a file `~/.texpander/sig.txt` that has all of my contact information.

### Setting Up Custom Keyboard Shortcuts

This process may be slightly different for you depending on what desktop environment and Linux distribution you have. I've personally tested this on Pop!_OS and Elementary OS 5.1 but each desktop environment has a slightly different way of setting up keyboard shortcuts. But the bottom line is I just map `Ctrl+Shift+T` to the `texpander.sh` bash script. 

### How To Use Texpander

After setting up the keyboard shortcut to launch Texpander, to use Texpander:

- Start writing an email to somebody (or start editing any document)
- Put your cursor where you want your email signature to be pasted
- Type `Ctrl+Shift+T` (or whatever keyboard shortcut you set up)
- A zenity window will appear asking for your abbreviation
- Type in `sig` and hit Enter (or click "OK")
- The contents of `~/.texpander/sig.txt` is pasted into your document

If I'm not in a web browser I'm in the terminal working in Vim. I've got some texpander files that I use in Vim. The terminal works a little differently from other GUI apps in that you have to type `ctrl+shift+v` to paste stuff. In texpander.sh there is a check to see if the active window is a terminal. If so, it will paste using `ctrl+shift+v` if not then it will paste normally as `ctrl+v`

## Contributing

1. Fork Texpander
2. Create your feature branch: `git checkout -b my-new-feature`
3. Commit your changes: `git commit -am 'Add some feature'`
4. Push to the branch: `git push origin my-new-feature`
5. Submit a pull request :D

## History

**Version 2.1 - January 11, 2021**

- Change: added infinite multilevel selection based on directories.

**Version 2.0 - November 24, 2017**

- Change: Replace `xclip` with `xsel` because `xclip` tends to strip newlines when pasting into certain application like Gmail on Firefox.
- Change: Use `shift+Insert` to be compatible with more programs for pasting rather than trying to figure out if the current app should use `ctrl+v` or `ctrl+shift+v`.
- New: Add an optional `type` mode so if pasting doesn't work, the `xdotool` can `type` (rather than paste) text into the active window.

**Version 1.1.1 - November 22, 2016**

- Update: Look for "terminal" pattern anywhere in proc name to match names like "gnome-terminal" for pasting text into terminals.
- Update: Update README with instructions for the new selection list functionality

**Version 1.1 - November 7, 2016**

- New: Using zenity list to show abbreviations. You can still just type the abbreviations and then hit Enter, or select your choice with the mouse and click OK.
- New: The value in the clipboard is preserved so it is not overwritten when expanding an abbreviation
- New: Add pasting support for the terminator terminal emulator pasting
- Update: Use the focus window rather than the active window as the target for pasting


**Version 1.0.1 - June 23, 2016**

- New: If the active window is a terminal paste with `ctrl+shift+v`

**Version 1.0 - May 17, 2016**

- Initial release

## Credits

Written by Lee Blue

## License

General Public License v3.0

