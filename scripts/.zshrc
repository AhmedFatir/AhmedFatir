export ZSH="$HOME/.oh-my-zsh"
export EDITOR="/Applications/Visual\ Studio\ Code.app/Contents/MacOS/Visual\ Studio\ Code" 
export PATH="$PATH:/Applications/Visual Studio Code.app/Contents/Resources/app/bin"
export LDFLAGS="-L/Users/afatir/.brew/opt/readline/lib"
export CPPFLAGS="-I/Users/afatir/.brew/opt/readline/include"

ZSH_THEME="bira"
# ZSH_THEME="robbyrussell"

plugins=(
    git
    kubectl
    docker
    docker-compose
)

source $ZSH/oh-my-zsh.sh

# auto push
alias PUSH='
#!/bin/bash
find . -name ".DS_Store" -type f -delete
if [ "$PWD" = "$HOME" ]; then
    echo -e "\033[1;31mError: You are in the home directory!\033[0m"
else
    rm -rf .vscode
fi

if [ ! -f .gitignore ]; then
    echo -e "\033[1;31mWarning: .gitignore file is missing in the working directory!\033[0m"
fi
echo "
feat: (new feature for the user, not a new feature for build script)
fix: (bug fix for the user, not a fix to a build script)
docs: (changes to the documentation)
style: (formatting, missing semi colons, etc; no production code change)
refactor: (refactoring production code, eg. renaming a variable)
test: (adding missing tests, refactoring tests; no production code change)
chore: (updating grunt tasks etc; no production code change)"

echo -n "\e[1;32m\nenter the commit message: \e[0;37m"
read commit_message

echo "\n\033[4;31mGIT ADD .\033[0;37m\n"
git add .

echo "\n\033[4;31mGIT STATUS\033[0;37m\n"
git status
echo -n "\e[1;32m\nWould you like to continue?: \e[0;37m"
read continue
if [ $continue = "n" ]
then
    return
fi

echo "\n\033[4;31mGIT COMMIT -M\033[0;37m\n"
git commit -m "$commit_message"

echo "\n\033[4;31mGIT PUSH\033[0;37m\n"
git push'

# auto merge
alias merge='
#!/bin/bash
echo -n "\e[1;32m\nEnter the brach name: \e[0;37m"
read branch_name
current_branch=$(git rev-parse --abbrev-ref HEAD)

echo "\nMerge branch $branch_name into $current_branch."
echo "Automatically resolve conflicts in favor of $branch_name."

echo -n "\e[1;32m\nWould you like to continue?: \e[0;37m"
read continue
if [ $continue = "n" ]
then
    echo "Merge cancelled."
    return
fi
git merge -X theirs "$branch_name"
'

# clean commands
bash ~/AhmedFatir/ccl.sh
alias rmf='rm -rf'
alias cl="bash ~/AhmedFatir/ccl.sh && find ~/.Trash/ -mindepth 1 -delete" 
alias cclean="bash ~/AhmedFatir/ccl.sh && find ~/.Trash/ -mindepth 1 -delete"
alias kilan='killall "Android File Transfer" && killall "Android File Transfer Agent"'
alias dua='du -sh * | sort -n'

# update commands
alias zshup='source ~/.zshrc'
alias sas='osascript ~/AhmedFatir/dark_mode_key_repeat.scpt &>/dev/null'

# compile commands
alias c17='c++ -std=c++17'
alias c98='c++ -std=c++98'
alias cdd="cd ~/Desktop"
alias py='python3.9'

# Docker commands
alias cpd='
rsync -a ~/Library/Containers/com.docker.docker ~/goinfre/DockerData
mv ~/Library/Containers/com.docker.docker ~/Library/Containers/com.docker.docker.backup
ln -s ~/goinfre/DockerData/com.docker.docker ~/Library/Containers/com.docker.docker'
mkdir -p /Users/afatir/goinfre/DockerData/com.docker.docker/Data
alias dquit='killall Docker'
alias dopen='open -a Docker'
alias ip="echo $(ifconfig | grep 'inet 10' | awk '{print $2}')"

source /Users/afatir/.docker/init-zsh.sh || true # Added by Docker Desktop




# export ZSH="$HOME/.oh-my-zsh"
# export EDITOR="/Applications/Visual\ Studio\ Code.app/Contents/MacOS/Visual\ Studio\ Code" 
# export PATH="$PATH:/Applications/Visual Studio Code.app/Contents/Resources/app/bin"
# ZSH_THEME="robbyrussell"
# plugins=(git)
# source $ZSH/oh-my-zsh.sh
# alias rmf='rm -rf'
# alias py='python3.9'
# alias zshup='source ~/.zshrc'
alias pyenv='python3.9 -m venv env && source env/bin/activate'
alias pym='python3.9 manage.py'
alias pymm='python3.9 manage.py makemigrations && python3.9 manage.py migrate'
alias pymr='python3.9 manage.py runserver'
alias pymt='python3.9 manage.py test --verbosity 2'
alias pyma='python3.9 manage.py createsuperuser --username admin --email admin@email.com'
alias pipi='pip install -r requirements.txt'
alias pipf='pip freeze > requirements.txt'


# for Linux
# alias zshup='source ~/.zshrc && xmodmap ~/.Xmodmap && xrandr --output "eDP" --mode "3200x1800"'
# Xmodmap //
#remove Control = Control_L
#remove Mod4 = Super_L
#keysym Super_L = Control_L
#keysym Control_L = Super_L
#add Control = Control_L
#add Mod4 = Super_L
# printf "%02d:%02d\n" $(($(($(date +%s) - $(date -d "$(who -u | grep "$USER" | awk 'NR==1 {print $3, $4}')" +%s))) / 3600)) $(($(($(($(date +%s) - $(date -d "$(who -u | grep "$USER" | awk 'NR==1 {print $3, $4}')" +%s))) % 3600)) / 60))
