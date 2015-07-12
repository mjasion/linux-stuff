# http://mariuszs.github.io/
set -g __fish_git_prompt_show_informative_status 1
set -g __fish_git_prompt_showcolorhints 1

set -g __fish_git_prompt_color_branch magenta
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
set -g __fish_git_prompt_color_cleanstate green


## magic
function fish_prompt --description 'Write out the prompt' 
	set -l last_status $status # Just calculate these once, to save a few cycles when displaying the prompt 

	if not set -q __fish_prompt_normal 
		set -g __fish_prompt_normal (set_color normal) 
	end 

	if not set -q -g __fish_classic_git_functions_defined 
		set -g __fish_classic_git_functions_defined 

		function __fish_repaint_user --on-variable fish_color_user --description "Event handler, repaint when fish_color_user changes"

			if status --is-interactive 
				set -e __fish_prompt_user 
				commandline -f repaint ^/dev/null 
			end 
		end

		function __fish_repaint_host --on-variable fish_color_host --description "Event handler, repaint when fish_color_host changes" 
			if status --is-interactive 
				set -e __fish_prompt_host 
				commandline -f repaint ^/dev/null 
			end 
		end 
 	end

	switch $USER 
		case root; set prompt_symbol '#' 
	 	case '*'; set prompt_symbol '$' 
	end

	switch $USER 
		case root; set fish_color_user red --bold
	end

	if not set -q __fish_prompt_cwd 
		set -g __fish_prompt_cwd (set_color $fish_color_host) 
	end 

	if not set -q __fish_prompt_user 
		set -g __fish_prompt_user (set_color $fish_color_user) 
	end 
	echo -n -s "$__fish_prompt_user" "$USER" "$__fish_prompt_normal" "$__fish_prompt_normal" ' ' "$__fish_prompt_cwd" (prompt_pwd) "$__fish_prompt_normal" (__fish_git_prompt) "$__fish_prompt_user" "$prompt_symbol" ' ' 
end 
if not set -q __prompt_initialized_2 
	set -U fish_color_user -o green 
	set -U fish_color_host cyan 
	set -U __prompt_initialized_2 
end

function fish_right_prompt -d "Write out the right prompt"

  # Time
  set_color -o black
  echo (date +%R)
  set_color $fish_color_normal

end
