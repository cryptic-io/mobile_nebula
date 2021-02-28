source $stdenv/setup
set -e

# create a fake HOME for flutter which has all dependencies pre-loaded. HOME
# must be a write-able directory because flutter likes to grab lock files and
# other nonsense.
export HOME=$(pwd)/flutter_home
mkdir $HOME
rsync -a --copy-links --chmod=D755,F644 "$flutterHome"/ $HOME

# actually do the thing.
cd $src
#flutter doctor -v
flutter build apk --no-shrink --debug -v

