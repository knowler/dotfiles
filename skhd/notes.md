A list of all built-in modifier and literal keywords can be found at https://github.com/koekeishiya/skhd/issues/1

## Modifiers

```
fn

cmd
lcmd
rcmd

shift
lshift
rshift

alt
lalt
ralt

ctrl
lctrl
rctrl

hyper (cmd + shift + alt + ctrl)
```

## Key literals

```
"return"     (kVK_Return)
"tab"        (kVK_Tab)
"space"      (kVK_Space)
"backspace"  (kVK_Delete)
"escape"     (kVK_Escape)

The following keys can not be used with the fn-modifier:

"delete"     (kVK_ForwardDelete)
"home"       (kVK_Home)
"end"        (kVK_End)
"pageup"     (kVK_PageUp)
"pagedown"   (kVK_PageDown)
"insert"     (kVK_Help)
"left"       (kVK_LeftArrow)
"right"      (kVK_RightArrow)
"up"         (kVK_UpArrow)
"down"       (kVK_DownArrow)
"f1"         (kVK_F1)
"f2"         (kVK_F2)
```

```
A hotkey is written according to the following rules:

  hotkey   = <mode> '<' <action> | <action>

  mode     = 'name of mode' | <mode> ',' <mode>

  action   = <keysym> ':' <command> | <keysym> '->' ':' <command>
             <keysym> ';' <mode>    | <keysym> '->' ';' <mode>

  keysym   = <mod> '-' <key> | <key>

  mod      = 'built-in mod keyword' | <mod> '+' <mod>

  key      = <literal> | <keycode>

  literal  = 'single letter or built-in keyword'

  keycode  = 'apple keyboard kVK_<Key> values (0x3C)'

  ->       = keypress is not consumed by skhd

  command  = command is executed through '$SHELL -c' and
             follows valid shell syntax. if the $SHELL environment
             variable is not set, it will default to '/bin/bash'.
             when bash is used, the ';' delimeter can be specified
             to chain commands.

             to allow a command to extend into multiple lines,
             prepend '\' at the end of the previous line.

             an EOL character signifies the end of the bind.
```


A mode is declared according to the following rules:

```
mode_decl = '::' <name> '@' ':' <command> | '::' <name> ':' <command> |
            '::' <name> '@'               | '::' <name>

name      = desired name for this mode,

@         = capture keypresses regardless of being bound to an action

command  = command is executed through '$SHELL -c' and
           follows valid shell syntax. if the $SHELL environment
           variable is not set, it will default to '/bin/bash'.
           when bash is used, the ';' delimeter can be specified
           to chain commands.

           to allow a command to extend into multiple lines,
           prepend '\' at the end of the previous line.

           an EOL character signifies the end of the bind.
```
