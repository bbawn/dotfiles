# Set PATH, MANPATH, etc., for Homebrew.
eval "$(/opt/homebrew/bin/brew shellenv)"

# See https://scriptingosx.com/2017/04/about-bash_profile-and-bashrc-on-macos/
[ -r ~/.bashrc ] && . ~/.bashrc

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/bobbawn/google-cloud-sdk/path.bash.inc' ]; then . '/Users/bobbawn/google-cloud-sdk/path.bash.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/bobbawn/google-cloud-sdk/completion.bash.inc' ]; then . '/Users/bobbawn/google-cloud-sdk/completion.bash.inc'; fi
. "$HOME/.cargo/env"
