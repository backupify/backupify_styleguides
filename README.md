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

You can also take a look at this example for how to create a git hook that will run a check before you push: https://gist.github.com/jbodah/6c3448056d1fe727de10

### Editor Configs

Below are some common configs for various editors that help you conform to the styleguides:

#### Atom

#### Sublime

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

