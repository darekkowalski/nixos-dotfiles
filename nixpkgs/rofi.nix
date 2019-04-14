{ pkgs, ...}:
  let t = import ./theme.nix;
in
{
  enable = true;

  extraConfig = ''
    rofi.font:		          DejaVu Sans Mono 16
    rofi.line-margin:	      5
    rofi.separator-style:	  solid

    rofi.modi:              drun,window,ssh
    rofi.ssh-client:        ssh
    rofi.ssh-command:       {terminal} -e {ssh-client} {host}
    rofi.run-shell-command: {terminal} -e {cmd}

    ! Background | Foreground | Background (Alternate) | Background (Highlighted) | Foreground (Highlighted)
    rofi.color-normal: argb:00282a36, #f8f8f2, argb:00282a36, #44475a, #f8f8f2

    ! Background | Border | Separator
    rofi.color-window: argb:ee282a36, #282a36, #f1fa8c

    ! Key bindings
    rofi.kb-row-select:
    rofi.kb-mode-next:

    rofi.kb-cancel:		Escape,Control+space,Control+Tab
  '';
}
