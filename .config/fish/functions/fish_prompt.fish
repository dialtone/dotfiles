# Defined in /var/folders/w0/flfyxfg15nn6w10pgk5xh_040000gp/T//fish.niiZji/fish_prompt.fish @ line 2
function fish_prompt --description 'Write out the prompt'
	set -l color_cwd
    set -l suffix
    switch "$USER"
        case root toor
            if set -q fish_color_cwd_root
                set color_cwd $fish_color_cwd_root
            else
                set color_cwd $fish_color_cwd
            end
            set suffix '#'
        case '*'
            set color_cwd $fish_color_cwd
            set suffix '>'
    end

    if set -q VIRTUAL_ENV
        echo -n -s (set_color white) "(" (basename "$VIRTUAL_ENV") ")" (set_color normal) " "
    end

    echo -n -s "$USER" @ (prompt_hostname) ' ' (set_color $color_cwd) (prompt_pwd) (set_color normal) " "

    __informative_git_prompt

    echo -n -s "$suffix "
end
