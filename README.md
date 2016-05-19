# CSSSanity
Cool CSS minifier written in bash!

## How it works?
First, CSSSanity will use the given file name to determine where to lookup for file to minify.
Then, it'll use `cat` to merge files matching `*.css` pattern in the given file name.
After that CSSSanity will use some `tr`, `perl` and `sed` commands to remove all the useless characters and save the final minified file in the location you specified!

That's simple as this!

## Usage
Online version:
```shell
wget https://csssanity.pw | bash -e "static/styles/filename.min.css"
```

Offline version:
```shell
./csssanity static/styles/filename.min.css
```
