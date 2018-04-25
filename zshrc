#
# Executes commands at the start of an interactive session.
#
# Authors:
#   Sorin Ionescu <sorin.ionescu@gmail.com>
#

# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

# Source Knowler.
if [[ -s "${ZDOTDIR:-$HOME}/.kno/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.kno/init.zsh"
fi

export PATH="$HOME/.cargo/bin:vendor/bin/:$PATH"

export TERM='xterm-256color'

export ZPLUG_HOME=/usr/local/opt/zplug
source $ZPLUG_HOME/init.zsh

alias cask="brew cask"

alias reload="source ~/.zshrc"

alias vi="/usr/local/bin/vim"
alias mux="tmux -2 -u new -s"
alias att="tmux -2 -u a -t"
alias takeover="tmux detach -a"

# fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export FZF_DEFAULT_COMMAND='ag -g ""'

fd() {
  local dir
  dir=$(find . -maxdepth 1 -path './.*' -prune -o -type d -print | sed '1d;s#^./##' |
  fzf --height 20 --reverse --query "$1" --select-1 --exit-0) && cd "$dir"
}

fzf-down() {
  fzf --height 50% "$@" --border
}

is_in_git_repo() {
  git rev-parse HEAD > /dev/null 2>&1
}

gf() {
  is_in_git_repo || return
  git -c color.status=always status --short |
  fzf-down -m --ansi --nth 2..,.. \
    --preview '(git diff --color=always -- {-1} | sed 1,4d; cat {-1}) | head -500' |
  cut -c4- | sed 's/.* -> //'
}

fs() {
  local session
  session=$(tmux list-sessions -F "#{session_name}" | \
    fzf --height 40% --reverse --query="$1" --select-1 --exit-0) &&
    tmux switch-client -t "$session"
}

tls() {
  local session
  session=$(tmux list-sessions -F "#{session_name}" | \
    fzf --height 40% --reverse --query="$1" --select-1 --exit-0) &&
    tmux attach-session -t "$session"
}

# Customize to your needs...

export PATH=/usr/local/bin:/usr/local/sbin:$HOME/.composer/vendor/bin:$PATH

# OCR an image. Outputs to clipboard.
alias ocr="tesseract *.png pasta && cat pasta.txt | pbc"

# Dates and time
week=$(date '+%V')
alias week="date '+%V'"

today=$(date '+%F')
alias today="date '+%F'"

tomorrow=$(date -v +1d '+%Y-%m-%d')
#alias tomorrow="date -v +1d '+%Y-%m-%d'"

sunday=$(date -v-sun +%F)
alias sunday="echo $sunday"
monday=$(date -v-mon +%F)
tuesday=$(date -v-tue +%F)
wednesday=$(date -v-wed +%F)
thursday=$(date -v-thu +%F)
friday=$(date -v-fri +%F)
saturday=$(date -v-sat +%F)

# Some global variables.
EDITOR=vim
ZSHRC=~/.zshrc
VIMRC=~/.vimrc
DL=~/Downloads/
NOTES=~/Dropbox/Notes
TODO=$NOTES/tasks/todo/today.md
VOCAB=$NOTES/collections/vocab.md
PHRASES=$NOTES/collections/phrases.md
PROFS=~/Dropbox/Eston\ College/Academic/profs.md
EC=~/github/ec-paper-template
SUCCESS=$NOTES/tasks/success/today.md
RN=$NOTES/tasks/success/right-now.md
SCT=$NOTES/tasks/success/.$tomorrow.md
DAILY=$NOTES/tasks/daily/$today.md
EXTRAS=$NOTES/tasks/success/extras-this-week.md
ZOOM=/Volumes/KNOJO-ZOOM
DRAFTS=$NOTES/currently/drafting
TIL=$NOTES/currently/learning
DICTIONARY=$NOTES/collections/dictionary
BUDGET=$NOTES/life/budget
JOURNAL=~/Documents/rand/journal
OH=~/Documents/rand/oh.md

# Get all the important todos
alias tt='echo "$(cat $SUCCESS)\n\n\n$(cat $DAILY)\n\n\n$(cat $TODO)"'
# Edit the right now success file.
alias rn='vi $RN'

# Alias for Spotify CLI
alias sp='spotify'

# Show what assignments are left.
alias left='grep -hv "\- \[x\]" $NOTES/tasks/todo/assignments.md'

alias prefresh='echo "tell application \"Preview\" to activate\r tell application \"iTerm3\" to activate" | osascript -'

# Read the readme
alias readme='cat readme'

# Add to the daily todo
alias dai='vi $DAILY'

# Dump the zoom
zoomed() {
  dump=/Volumes/KNOJO-2/~Eston\ College/Chapel\ Audio/2016-2017/Dump\ $today
  mkdir $dump
  cp -R $ZOOM/MULTI $dump/
  cp -R $ZOOM/STEREO $dump/
  rm -rf $ZOOM/MULTI $ZOOM/STEREO
  diskutil unmount $ZOOM
}

# This is an example for a logging command. See lines 211 and on as well.
#if [ $GRATIS != $NOTES/orgs/eston\ college/gratis/*.md ]; then
#  mv $NOTES/orgs/eston\ college/gratis/*.md $NOTES/orgs/eston\ college/gratis/archive/
#  touch $GRATIS
#fi
#
#if [ $ESL != $NOTES/orgs/eston\ college/esl/*.md ]; then
#  mv $NOTES/orgs/eston\ college/esl/*.md $NOTES/orgs/eston\ college/esl/archive/
#  touch $ESL
#fi

if [ $DAILY != $NOTES/tasks/daily/*.md ]; then
  mv $NOTES/tasks/daily/*.md $NOTES/tasks/daily/archive/
  cp $NOTES/tasks/daily/.everyday.md $DAILY
fi

if [ ! -r $SCT ]; then
  if [ -r $NOTES/tasks/success/.$today.md ]; then
    # Append old procrastinated todos to today’s list
    echo "Adding procrastinated todos to today’s life"
    echo "$(cat $NOTES/tasks/success/.$today.md)" >> $SUCCESS
    # Destroy old files
    echo "Destroying old files"
    rm -f $NOTES/tasks/success/.$today.md
  fi
  # Make a new one
  echo "Making a new tomorrow list"
  touch $SCT
fi

man() {
  env \
    LESS_TERMCAP_mb=$(printf "\e[1;31m") \
    LESS_TERMCAP_md=$(printf "\e[1;31m") \
    LESS_TERMCAP_me=$(printf "\e[0m") \
    LESS_TERMCAP_se=$(printf "\e[0m") \
    LESS_TERMCAP_so=$(printf "\e[1;44;33m") \
    LESS_TERMCAP_ue=$(printf "\e[0m") \
    LESS_TERMCAP_us=$(printf "\e[1;32m") \
    man "$@"
}

[[ -s $(brew --prefix)/etc/profile.d/autojump.sh ]] && . $(brew --prefix)/etc/profile.d/autojump.sh

ia() {
  if [ -z "$1" ]; then
    echo "No file specified."
  else
    if [ -f "$1" ]; then
      ## OPEN EXISTING SPECIFIED FILE
      open -a "iA Writer" "$1"
    else
      ## OPEN NEW OR EXISTING FILE WITH MD EXTENSION
      touch "$1.md"
      open -a "iA Writer" "$1.md"
    fi
  fi
}

draft () {
  if [ -z "$1" ]; then
    echo "No file specified."
  else
    vi $DRAFTS/"$1".md
  fi
}

til () {
  vi $TIL/$today.md
}


def () {
  if [ -z "$1" ]; then
    cd $DICTIONARY && ls
  else
    vi $DICTIONARY/"$1".md
  fi
}

journal () {
  if [ -z "$1" ]; then
    echo "No file specified."
  else
    vi $JOURNAL/"$1".md
  fi
}

# Replace ls with exa
alias ls='exa --long --git --group-directories-first'
alias la='exa -abghl --git --color=automatic'

# Replace tree with exa
# --git-ignore only works if ignore pattern doesn't have slashes
# See: https://github.com/ogham/exa/commit/827aa8bfc32eadf353f72b0ce41c88dc4ad411c1
alias tree='exa -T --group-directories-first --git-ignore'

alias weather='curl wttr.in/Calgary'

alias vimrc='vi $VIMRC'
alias zshrc='vi $ZSHRC'
todo () {
  if [ -z "$1" ]; then
    vi $TODO
  else
    vi $NOTES/tasks/todo/"$1".md
  fi
}
alias profs='vi $PROFS'
suc () {
  if [ -z "$1" ]; then
    vi $SUCCESS
  else
    vi $NOTES/tasks/success/"$1".md
  fi
}
tom () {
  if [ -z "$1" ]; then
    vi $SCT
  else
    if [ -r $SCT ]; then
      echo "Adding task to tomorrow file";
      if [ -n "$(cat $SCT)" ]; then
        printf "\n- [ ] $1" >> $SCT
      else
        printf "- [ ] $1" >> $SCT
      fi
    else 
      echo "Adding task to new tomorrow file";
      touch $SCT
      printf "- [ ] $1" >> $SCT
    fi
  fi
}
# This is an example for a logging command. See lines 88 and on as well.
#gratis () {
#  if [ -z "$1" ]; then
#    vi $GRATIS
#  else
#    echo "\r- $1" >> $GRATIS;
#  fi
#}
#esl () {
#  if [ -z "$1" ]; then
#    vi $ESL
#  else
#    echo "\r- $1" >> $ESL;
#  fi
#}
start () {
  if [ -z "$1" ]; then
    vi $NOTES/life/start.md
  else
    echo "\r- $1" >> $NOTES/life/start.md;
  fi
}

yt () {
  youtube-dl --recode-video mp4 "$1"
}

bible () {
  diatheke -b ESV -k "$1" | vi "+%s/.*\:\s//g | se tw=64 | norm ggVGgqgg | set filetype=markdown" -
}

biblec () {
  diatheke -b ESV -k "$1" | vi "+%s/.*\:\s//g | %s/(ESV)//g | g/^$/d | se tw=999 | norm ggVGgq" "+w !pbcopy" "+q!" -
}

bibleh () {
  diatheke -b MapM -k "$1" | vi "+%s/.*\:\s//g | %s/(MapM)//g | g/^$/d | se tw=999 | norm ggVGgq" "+w !pbcopy" "+q!" -
}

bibler () {
  biblec "$1" && pbp | say
}

alias c='j c && clear'

alias y='yes-no --type yes | pbcopy'
alias n='yes-no --type no | pbcopy'
alias s='superb | pbcopy'

yesterday=$(date -v -1d '+%Y-%m-%d')

alias yesterday="date -v -1d '+%Y-%m-%d'"
#alias now="date '+%T'"

common () {
  history | awk '{CMD[$2]++;count++;}END { for (a in CMD)print CMD[a] " " CMD[a]/count*100 "% " a;}' | grep -v "./" | column -c3 -s " " -t | sort -nr | nl |  head -n10
}

eject () {
  if [ -z "$1" ]; then
    echo "No drive specified."
  else
    dot_clean -m "/Volumes/$1"
    diskutil unmount "$1"
  fi
}

# Start writing a Markdown in the current directory.
md () {
  if [ -z "$1" ]; then
    echo "No filename specified."
  else
    vi "$1".md
  fi
}

# Write or add into a budget file.
budget () {
  if [ -z "$1" ]; then
    echo "No filename specified."
  else
    vi $BUDGET/"$1".csv
  fi
}

# Make a website using my boilerplate.
ws () {
  mkdir $1
  cd $1
  cp -R ~/github/web/* .
}

# Run a vagrant command on Homestead
homestead() {
  ( cd ~/Homestead && vagrant $* )
}

# This is for printing tasks
#todo () {
#  if [ -z "$1" ]; then
#    result=`grep -h '\[\s\]' todo/*`
#    echo $result
#  else
#    # This is for finding ones with tags
#    pattern="\[\s\].*\#""$1"
#    result=$(grep -h "$pattern" todo/*)
#    echo $result
#    # It would be nice to make one for general search
#  fi
#}

# This is for making tasks
#t () {
#  if [$1 = ]; then
#    echo "What is the task?"
#    read task
#    echo '- [ ] '$task >> todo.md
#  else
#    echo '- [ ] '$@ >> todo.md
#  fi
#}

# Deploying a Laravel app via Ansible.
# deploy () {
#   ( cd ~/Homestead && vagrant ssh < cd /home/vagrant/ansible-php && ansible-playbook php.yml --ask-sudo-pass )
# }

# Make a paper.

paper () {
  mkdir $1
  cd $1
  cp $EC/* .
  mv template.tex $1-draft.tex
}

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # 
# Theses are for audio conversion # # # # # # # # # # # # # # #
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # 

flacdown () {
  mkdir -p converted
  for input in "$@"
    do sox -S $input -r 44100 -b 16 "converted/$(basename $input)"
  done
}

mp3these () {
  mkdir -p mp3-320
  for input in "$@"
    do sox -S $input -C 320 "mp3-320/${input%.*}.mp3"
  done
}

makethesefaster () {
  mkdir -p faster
  for input in "$@"
    do sox $input "faster/$input" tempo -s 2
  done
}

wmatomp3 () {
  mkdir -p mp3-64
  for input in "$@"
    do ffmpeg -i $input ${input%.*}.mp3 && sox -S ${input%.*}.mp3 -C 64 -c 1 "mp3-64/${input%.*}.mp3"
   done
}

mp3these64 () {
  mkdir -p mp3-64
  for input in "$@"
    do sox -S $input -C 64 -c 1 "mp3-64/${input%.*}.mp3"
   done
}

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # 

# Save a cool word.
vocab () {
  if [ -z $1 ]; then
    vi $VOCAB
  else
    echo "\n$1" >> $VOCAB
    echo $1 "added to vocabulary."
  fi
}

# Save a cool phrase.
phr () {
  if [ -z $1 ]; then
    vi $PHRASES
  else
    echo "\n$1" >> $PHRASES
    echo $1 "added to phrases."
  fi
}

# overheard
oh () {
  if [ -z $1 ]; then
    vi $OH
  else
    echo "\n$1" >> $OH
    echo $1 "added to overheard."
  fi
}

# Node Version Manager
export NVM_DIR="/Users/knowler/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm

# Spinning a new Roots setup.
trellis() {
  if [ -z $1 ]; then
    echo "Please provide the name of the site"
  else
    mkdir "$1" && cd "$1"
    git clone --depth=1 git@github.com:roots/trellis.git && rm -rf trellis/.git 
    git clone --depth=1 git@github.com:roots/bedrock.git site && rm -rf site/.git 
    cd trellis && ansible-galaxy install -r requirements.yml
  fi
}

# Prepping a non-Bedrock Sage theme for uploading via FTP.
sage-prep() {
  yarn run build:production
  mkdir "$1" 
  cd "$1"
  cp -R ../app .
  cp -R ../dist .
  mkdir resources .
  cp -R ../resources/controllers ./resources
  cp -R ../resources/models ./resources
  cp -R ../resources/views ./resources
  cp ../resources/* ./resources
  cp -R ../vendor .
  cp ../* .
  cd ..
  zip -r "$1"-$(date '+%Y%m%d%H%M%S') "$1"
  trash "$1"
}

# Resizing images for social media
# TODO: add conversion for non-JPEGs (RAW and PNG)
rsm() {
  outputDir="resized for social media"
  mkdir $outputDir
  for input in "$@"
    do 
      sips --resampleWidth 1080 $input -s format jpeg --out ./$outputDir/${input%.*}-ig.jpg # Instagram
      sips --resampleWidth 2048 $input -s format jpeg --out ./$outputDir/${input%.*}-fb.jpg # Facebook
  done
}

# Create a new directory and enter it.
# https://github.com/jmegs/dotfiles/blob/master/zshrc#L24-L27
mkd() {
  mkdir -p "$@" && cd "$_";
}

# email draft function
email() {
  if [ -z "$1" ]; then
    echo "No filename specified."
  else
    vi $DRAFTS/"$1".md
  fi
}

# fuzzy multi-select modified file
gfmod() {
  git ls-files -m | fzf -m
}

# stage files multi-selected modified files
gfadd() {
  git add $(gfmod)
}

# Convert video to mp4 
mp4dis() {
  ffmpeg -i "$1" -vcodec libx264 ${1%.*}.mp4
}

# Remove sound from video
nosound() {
  ffmpeg -i "$1" -c copy -an ${1%.*}.nosound.mp4
}

# Prepare video for Instagram
igvid() {
  ffmpeg -i "$1" -vcodec libx264 -vf scale=w=1080:h=1080:force_original_aspect_ratio=decrease ${1%.*}-ig.mp4
}

halfvid() {
  ffmpeg -i "$1" -vf "scale=iw/2:-2" ${1%.*}.halfsize.mp4
}

alias hurlp='pbpaste | jq ".log.entries" | tee >(jq --raw-output "[.[] | .request.url] | sort | unique | .[]") | subl -'
alias hurld='pbpaste | jq ".log.entries" | jq --raw-output "[.[] | .request.url] | sort | unique | .[]" | harurls | tee >(xargs -n 1 curl -O $1)'

alias fixmp3="rename 's/\.mp3.*/\.mp3/' *"

# Browser-sync
alias bs='browser-sync start --server --no-notify --files "*"'

# WP CLI

wp-page() {
  wp @dev post create --post_type=page --post_status="publish" --post_title="$1"
}

wp-blade() {
  wp @dev blade compile --directory=views
}

quick-sage() {
  wp valet new "$1" --unsecure
  cd "$1"/web/app/themes
  composer create-project roots/sage sage dev-master
  cd sage
  yarn && yarn build
  wp theme activate sage/resources
  open "http://$1.test"
}
