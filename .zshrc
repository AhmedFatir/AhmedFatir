export ZSH="$HOME/.oh-my-zsh"
export EDITOR="/Applications/Visual\ Studio\ Code.app/Contents/MacOS/Visual\ Studio\ Code" 
export PATH="$PATH:/Applications/Visual Studio Code.app/Contents/Resources/app/bin"
export LDFLAGS="-L/Users/afatir/.brew/opt/readline/lib"
export CPPFLAGS="-I/Users/afatir/.brew/opt/readline/include"

ZSH_THEME="bira"

plugins=(git)

source $ZSH/oh-my-zsh.sh

# monitor file changes and compile and run
function crun {
    if [ -z "$1" ]; then
        echo "Usage: crun <file_name>"
        return
    fi
    file="$1"
    while true; do
    echo -n "\e[1;32m\nEnter ('r' to compile and run): \e[0;37m"
    read command
    if [ "$command" = "r" ]; then
        ls $file | tr ' ' '\n' | entr sh -c "clear && c++ -std=c++17 -o a.out $file && ./a.out"
    else
        echo "Invalid command."
        return
    fi
    done
}

function makerun {
    if [ -z "$1" ]; then
        echo "Usage: makerun <output_file>"
        return
    fi

    output_file="$1"

    while true; do
        echo -n "\e[1;32m\nEnter ('r' to compile and run): \e[0;37m"
        read command
        if [ "$command" = "r" ]; then
            find . -type f | entr sh -c "clear && make && clear && ./$output_file"
        else
            echo "Invalid command."
            return
        fi
    done
}

function makerunb {
    if [ -z "$1" ]; then
        echo "Usage: makerun <output_file>"
        return
    fi

    output_file="$1"

    while true; do
        echo -n "\e[1;32m\nEnter ('r' to compile and run): \e[0;37m"
        read command
        if [ "$command" = "r" ]; then
            find . -type f | entr sh -c "clear && make bonus && clear && ./$output_file"
        else
            echo "Invalid command."
            return
        fi
    done
}

# auto push and merge commands
alias PUSH='
#!/bin/bash
find . -name ".DS_Store" -type f -delete
rm -rf .vscode
# Check if .gitignore exists
if [ ! -f .gitignore ]; then
    echo -e "\033[1;31mWarning: .gitignore file is missing in the working directory!\033[0m"
fi

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
alias rmv='find . -name ".DS_Store" -type f -delete && rm -rf .vscode'
alias rmf='rm -rf'
alias cl="bash ~/AhmedFatir/ccl.sh && find ~/.Trash/ -mindepth 1 -delete" 
alias cclean="bash ~/AhmedFatir/ccl.sh && find ~/.Trash/ -mindepth 1 -delete"

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
alias dquit='killall Docker'
alias dopen='open -a Docker'
mkdir -p /Users/afatir/goinfre/DockerData/com.docker.docker/Data

# Load Homebrew config script
source $HOME/.brewconfig.zsh

source /Users/afatir/.docker/init-zsh.sh || true # Added by Docker Desktop
