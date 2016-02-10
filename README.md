# backupify_styleguides
code style and design guides for working with backupify code

## Description

This repository is meant to house the styleguides (e.g. best practices/conventions for writing code) for working with backupify code
as well as any code for supporting build jobs (e.g. lint files, syntax checkers, etc). It will also provide helpers for installing
these things into your development workflow.

## Contents

* [Ruby Styleguide](https://github.com/backupify/backupify_styleguides/blob/master/RubyStyleguide.md) - write you a Ruby for great good
* [Frontend Guides](https://github.com/backupify/backupify_styleguides/blob/master/FrontendGuides.md) - collection of frontend guides

## Build Configs

This repository holds the config files for various builds and linters that we use.

### Testing

You can test the rubocop configuration with the latests version of rubocop here:

```
bundle update rubocop
bundle exec rubocop -c config/.rubocop.yml
```

### Rubocop

To add the rubocop config to your project:

```rb
# Gemfile
gem 'backupify_styleguides', git: 'git@github.com:backupify/backupify_styleguides.git', require: false
gem 'rubocop', require: false
```

```yml
# .rubocop.yml
inherit_gem:
  backupify_styleguides: config/.rubocop.yml
```

Then to run rubocop use `bundle exec rubocop`

To add it to your build:

You can incoporate this into your build by doing:

```rb
desc "Run style checks"
task :style do
  abort unless system "bundle exec rubocop"
end

task :default => [:style, :test]
```

You can also take a look at this example for how to create a git hook that will run a check before you push: https://gist.github.com/jbodah/6c3448056d1fe727de10

### Editor Configs

Below are some common configs for various editors that help you conform to the styleguides:

#### Atom

Atom provides trailing whitespace removal by default via the [whitespace](https://atom.io/packages/whitespace) package.

To view and modify the settings go to `Atom -> Preferences -> Packages -> search for whitespace -> click it's settings button`

#### Sublime

Go to `SublimeText 2 > Preferences > User Settings`. This should open your User Settings as a JSON file. Add the following lines to your file:

```javascript
"trim_trailing_white_space_on_save": true
"ensure_newline_at_eof_on_save": true
```

For more features, check out the [whitespace](https://packagecontrol.io/packages/Whitespace) package.

#### Vim

```
" fix whitespace just before we write the buffer to a file
" save the cursor position
function! <SID>FixWhitespace()
    let l:save_cursor = getpos(".")
    silent! execute ':%s/\s\+$//'
    call setpos('.', l:save_cursor)
endfunction
autocmd BufWritePre * :call <SID>FixWhitespace()
```

#### Emacs

