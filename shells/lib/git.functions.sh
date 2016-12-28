# git
if [ -f ~/.git-prompt.bash ]; then
  . ~/.git-prompt.bash
  PS1="\[$GREEN\]\t\[$RED\]-\[$BLUE\]\u\[$YELLOW\]\[$YELLOW\]\w\[\033[m\]\[$MAGENTA\]\$(__git_ps1)\[$WHITE\]\$ "
fi

if [ -f ~/.git-completion.bash ]; then
  . ~/.git-completion.bash
fi

git.branches(){
  for branch in `git branch -r | grep -v HEAD`;do echo -e `git show --format="%ai %ar by %an" $branch | head -n 1` \\t$branch; done | sort -r
}

git.branch.status (){
  git for-each-ref --format="%(refname:short) %(upstream:short)" refs/heads | \
  while read local remote
  do
      [ -z "$remote" ] && continue
      git rev-list --left-right ${local}...${remote} -- 2>/dev/null >/tmp/git_upstream_status_delta || continue
      LEFT_AHEAD=$(grep -c '^<' /tmp/git_upstream_status_delta)
      RIGHT_AHEAD=$(grep -c '^>' /tmp/git_upstream_status_delta)
      echo "$local (ahead $LEFT_AHEAD) | (behind $RIGHT_AHEAD) $remote"
  done
}

git.c () { git commit -m "${1}" ;}

git.permissions.fix () { cd $(git rev-parse --show-toplevel);sudo chown -R $USER . ;}

git.logs(){
  [ $# -lt 1 ] && echo "Usage: ${FUNCNAME[0]} [date] <branch (optional)>" >&2 && return 1
  # git log --since="${1}" --pretty=oneline $2
  git log --since="${1}" --pretty=format:"%h %ad | %s%d [%an]" --graph --date=short $2

}

git.release_notes ()
{
    git_branch=$(git branch 2>/dev/null);
    if [ "$1" == "--help" -o "$1" == "-h" -o -z "$git_branch" ]; then
        echo "git_release_notes [starting_tag] [ending_tag]";
        return 0;
    fi;
    repo_url=$(git config --get remote.origin.url | sed 's/\.git//' | sed 's/:\/\/.*@/:\/\//');
    if [ -z "$1" ]; then
        last_release=$(git tag | tail -1);
    else
        last_release="$1";
    fi;
    if [ -z "$2" ]; then
        this_release="";
        echo "## Release" $(git branch | grep '^*' | awk '{print $NF}');
    else
        this_release="refs/tags/$2";
        echo "## Release $2";
    fi;
    git shortlog --no-merges refs/tags/$last_release..$this_release --format="* %s [%h]($repo_url/commit/%H)" | sed 's/      / /'
} 

git.reset(){
  git reset --hard origin/$(git rev-parse --abbrev-ref HEAD) && git pull origin $(git rev-parse --abbrev-ref HEAD)
}

git.search(){
  [ $# -lt 1 ] && echo "Usage: ${FUNCNAME[0]} [searchstring]" >&2 && return 1
  git log -S $1
}

git.show() {
    cd $1
    branch=`git branch 2> /dev/null | grep -e ^* | sed -E  s/^\\\\\*\ \(.+\)$/\\\\\1/`
    if [ -n "`git status 2> /dev/null | grep 'nothing to commit'`" ]; then
        status="\e[32mok\e[0m"
    else
        status="\e[31mmodified\e[0m"
    fi
    echo -e "\e[1m$1\e[0m (\e[34m$branch\e[0m): \e[1m$status\e[0m"
    cd ..
}

git.whatchanged(){
  [ $# -lt 1 ] && echo "Usage: ${FUNCNAME[0]} <date?" >&2 && return 1
  git whatchanged --since="${1}" --pretty=oneline
}

#--------------------------------------------------------------------------------------------------#
# Git shortcuts
alias git_undocommit='git reset --soft HEAD^'
alias git_recommit='git commit -c ORIG_HEAD'
alias git_ll='ls -alF'
alias git_la='ls -A'
alias git_l='ls -CF'
alias git_status='git status --short'
alias git_up='git smart-pull'
alias git_L='git smart-log'
alias git_m='git smart-merge'
alias git_b='git branch -rav'
alias git_fmod='git status --porcelain -uno | cut -c4-' # Only the filenames of modified files
alias git_today='git log --since="6am" --pretty=oneline'
alias git_umod='git status --porcelain -u | cut -c4-' # Only the filenames of unversioned files
alias git_branches='for branch in `git branch -r | grep -v HEAD`;do echo -e `git show --format="%ai %ar by %an" $branch | head -n 1` \\t$branch; done | sort -r'