if [ -r "$HOME/.bash_profile.dotold" ]; then
  . "$HOME/.bash_profile.dotold"
elif [ -r "$HOME/.bash_login.dotold" ]; then
  . "$HOME/.bash_login.dotold"
elif [ -r "$HOME/.profile.dotold" ]; then
  . "$HOME/.profile.dotold"
fi
