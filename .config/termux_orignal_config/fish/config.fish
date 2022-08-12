set fish_greeting

if status is-interactive
and not set -q TMUX
	tmux new-session -A -s main 
end

starship init fish | source
alias ls="exa -bghHliSa"
#neofetch

