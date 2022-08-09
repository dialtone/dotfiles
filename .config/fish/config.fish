# have to use fish_user_paths here to avoid the $PATH growing unbounded
# basically in each subshell
# seup cargo/rust and erlang and home bin
set -g fish_user_paths $HOME/.pyenv/versions/2.7.18/bin /opt/homebrew/bin /usr/local/opt/llvm/bin $HOME/.cargo/bin $HOME/bin /usr/local/opt/erlang@21/bin $fish_user_paths
fish_add_path /opt/homebrew/opt/arm-gcc-bin@8/bin/

# support virtualenv
eval (python -m virtualfish)


# setup go
set -gx GOROOT /opt/homebrew/opt/google-go/libexec/
set -gx GOPATH $HOME/dev/go
set -g fish_user_paths $GOROOT/bin $GOPATH/bin $fish_user_paths

set -gx GOARCH amd64
set -gx GOOS darwin
set -gx ARCHFLAGS "-arch arm64"

# remove the legacy keybindings from the fzf app since they conflict anyway
set -U FZF_LEGACY_KEYBINDINGS 0
#set -gx FZF_DEFAULT_COMMAND 'fd --type f'
set -gx FZF_DEFAULT_COMMAND 'fd --type f --hidden --follow --exclude .git'

# setup node
set -gx NODE_ENV development
set -gx SHELL /opt/homebrew/bin/fish

set -gx MACOSX_DEPLOYMENT_TARGET 12.1
set -gx PYTHONSTARTUP $HOME/.pythonstartup.py

# Some popular shell variables, useful in pdb as well
set -gx GREP_OPTIONS '--color=auto'
set -gx VISUAL nvim
set -gx LESSEDIT code -g %f:%l
set -gx TEXEDIT code -g %s:%d

# Avoid ._ file creation
set -gx COPYFILE_DISABLE true
set -gx LANG en_US.UTF-8
set -gx LC_CTYPE en_US.UTF-8

# this is needed to avoid any issue with the wrong version of python importing weakref
alias rust-lldb='env PATH=/usr/bin ~/.cargo/bin/rust-lldb'
# basically top for docker containers
alias docker-top='docker ps -q | xargs docker stats'
alias ssm='/usr/local/bin/aws ssm start-session --target'
alias rustc='rustc --edition=2021'

zoxide init fish | source
set -gx TERM_PROGRAM Alacritty.app

# autocomplete aws command if installed
test -x (which aws_completer); and complete --command aws --no-files --arguments '(begin; set --local --export COMP_SHELL fish; set --local --export COMP_LINE (commandline); aws_completer | sed \'s/ $//\'; end)'

# ruby stuff
set -g fish_user_paths $fish_user_paths ~/.rbenv/shims
status --is-interactive; and source (rbenv init -|psub)

# git prompt
set -g __fish_git_prompt_show_informative_status 1
set -g __fish_git_prompt_hide_untrackedfiles 1

set -g __fish_git_prompt_color_branch magenta bold
set -g __fish_git_prompt_showupstream "informative"
set -g __fish_git_prompt_char_upstream_ahead "↑"
set -g __fish_git_prompt_char_upstream_behind "↓"
set -g __fish_git_prompt_char_upstream_prefix ""

set -g __fish_git_prompt_char_stagedstate "●"
set -g __fish_git_prompt_char_dirtystate "✚"
set -g __fish_git_prompt_char_untrackedfiles "…"
set -g __fish_git_prompt_char_conflictedstate "✖"
set -g __fish_git_prompt_char_cleanstate "✔"

set -g __fish_git_prompt_color_dirtystate blue
set -g __fish_git_prompt_color_stagedstate yellow
set -g __fish_git_prompt_color_invalidstate red
set -g __fish_git_prompt_color_untrackedfiles $fish_color_normal
set -g __fish_git_prompt_color_cleanstate green bold

set -g fish_user_paths "/usr/local/opt/avr-gcc@8/bin" $fish_user_paths
set -g fish_user_paths "/usr/local/opt/openssl@1.1/bin" $fish_user_paths
set -g fish_user_paths "/usr/local/opt/sqlite/bin" $fish_user_paths
set -g fish_user_paths "/usr/local/opt/arm-gcc-bin@8/bin" $fish_user_paths

