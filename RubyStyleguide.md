# Ruby Styleguide

## Coding Style

<a name="method-length"></a>
* Prefer methods with less than 40 lines. [[link](#method-length)]

<a name="tabs"></a>
* Use soft-tabs with a two space indent. [[link](#tabs)]

<a name="parameter-count"></a>
* Prefer methods with 5 or less parameters. [[link](#parameter-count)]

<a name="max-line-length"></a>
* Keep lines fewer than 120 characters. [[link](#max-line-length)]

<a name="no-trailing-whitespace"></a>
* Never leave trailing whitespace. [[link](#no-trailing-whitespace)]

<a name="end-file-newline"></a>
* End each file with a newline. [[link](#end-file-newline)]

<a name="spaces-around-operators"></a>
* Use spaces around operators, after commas, colons and semicolons, around `{`, before `}`, and around block parameter pipes `|`. [[link](#spaces-around-operators)]
  * Exception: empty hashes should have no space (e.g. `{}`).
  * Exception: string interpolation should have no spaces around `{` and `}`.

```rb
sum = 1 + 2
a, b = 1, 2
1 > 2 ? true : false; puts "Hi"
[1, 2, 3].each { |e| puts e }
def my_method(name = nil); end
{}
"this is #{my_string_example}"
```

<a name="no-spaces-around-delimiters"></a>
* No spaces after `(`, `[` or before `]`, `)`. [[link](#no-spaces-around-delimiters)]

```rb
some(arg).other
[1, 2, 3].length
```

<a name="no-space-after-not"></a>
* No spaces after `!` operator. [[link](#no-space-after-not)]

```rb
!array.include?(element)
```

<a name="case-indentation"></a>
* Indent `when` as deep as `case`, `else` as much as `if`, and `rescue` and `ensure` as much as the `end`. [[link](#case-indentation)]

```rb
case
when song.name == "Misty"
  puts "Not again!"
when song.duration > 120
  puts "Too long!"
when Time.now.hour > 21
  puts "It's too late"
else
  song.play
end

kind = case year
       when 1850..1889 then "Blues"
       when 1890..1909 then "Ragtime"
       when 1910..1929 then "New Orleans Jazz"
       when 1930..1939 then "Swing"
       when 1940..1950 then "Bebop"
       else "Jazz"
       end

status = if success?
           :200
         elsif server_error?
           :500
         else
           :400
         end

def my_method
  raise 'uhoh'
rescue
  puts 'we done broke it'
end
```

<a name="lines-between-defs"></a>
* Use empty lines between `def`s and to break up a method into logical paragraphs. [[link](#lines-between-defs)]

```rb
def some_method
  data = initialize(options)

  data.manipulate!

  data.result
end

def some_method
  result
end
```

## Syntax

<a name="method-parentheses"></a>
* Use `def` with parentheses when there are arguments. Omit the parentheses when the method doesn't accept any arguments. [[link](#method-parentheses)]

```rb
def some_method
  # body omitted
end

def some_method_with_arguments(arg1, arg2)
  # body omitted
end
```

<a name="for-keyword"></a>
* Never use `for`, unless you know exactly why. Most of the time iterators should be used instead. `for` is implemented in terms of `each` (so you're adding a level of indirection), but with a twist - `for` doesn't introduce a new scope (unlike `each`) and variables defined in its block will be visible outside it. [[link](for-keyword)]

```rb
arr = [1, 2, 3]

# bad
for elem in arr do
  puts elem
end

# good
arr.each { |elem| puts elem }
```

<a name="multiline-if-then"></a>
* Never use `then` for multi-line `if/unless`. [[link](#multiline-if-then)]

```rb
# bad
if some_condition then
  # body omitted
end

# good
if some_condition
  # body omitted
end
```

* Avoid the ternary operator `(?:)` except in cases where all expressions are extremely trivial. However, do use the ternary operator `(?:)` over `if/then/else/end` constructs for single line conditionals.

```rb
# bad
result = if some_condition then something else something_else end

# good
result = some_condition ? something : something_else
```

<a name="nested-ternary"></a>
* Use one expression per branch in a ternary operator. This also means that ternary operators must not be nested. Prefer `if/else` constructs in these cases. [[link](#nested-ternary)]

```rb
# bad
some_condition ? (nested_condition ? nested_something : nested_something_else) : something_else

# good
if some_condition
  nested_condition ? nested_something : nested_something_else
else
  something_else
end
```

<a name="no-and-or-keyword"></a>
* The `and` and `or` keywords are banned. It's just not worth it. Always use `&&` and `||` instead. [[link](#no-and-or-keyword)]

<a name="multiline-ternary"></a>
* Avoid multi-line `?:` (the ternary operator), use `if/unless` instead. [[link](#multiline-ternary)]

```rb
# bad
if some_condition
  do_something
end

# good
do_something if some_condition
```

<a name="unless-else"></a>
* Never use `unless` with `else`. Rewrite these with the positive case first. [[link](#unless-else)]

```rb
# bad
unless success?
  puts "failure"
else
  puts "success"
end

# good
if success?
  puts "success"
else
  puts "failure"
end
```

<a name="parens-around-condition"></a>
* Don't use parentheses around the condition of an `if/unless/while`. [[link](#parens-around-condition)]

```rb
# bad
if (x > 10)
  # body omitted
end

# good
if x > 10
  # body omitted
end
```

<a name="block-syntax"></a>
* Prefer `{...}` over `do...end` for single-line blocks. Avoid using `{...}` for multi-line blocks (multiline chaining is always ugly). Always use `do...end` for "control flow" and "method definitions" (e.g. in Rakefiles and certain DSLs). Avoid `do...end` when chaining. [[link](#block-syntax)]

```rb
names = ["Bozhidar", "Steve", "Sarah"]

# good
names.each { |name| puts name }

# bad
names.each do |name|
  puts name
end

# good
names.select { |name| name.start_with?("S") }.map { |name| name.upcase }

# bad
names.select do |name|
  name.start_with?("S")
end.map { |name| name.upcase }
```

* Some will argue that multiline chaining would look OK with the use of `{...}`, but they should ask themselves - is this code really readable and can't the block's contents be extracted into nifty methods?

<a name="avoid-return"></a>
* Avoid `return` where not required. [[link](#avoid-return)]

```rb
# bad
def some_method(some_arr)
  return some_arr.size
end

# good
def some_method(some_arr)
  some_arr.size
end
```
<a name="space-around-param-default"></a>
* Use spaces around the `=` operator when assigning default values to method parameters. [[link](#space-around-param-default)]

```rb
# bad
def some_method(arg1=:default, arg2=nil, arg3=[])
  # do something...
end

# good
def some_method(arg1 = :default, arg2 = nil, arg3 = [])
  # do something...
end
```

* Using the return value of `=` (an assignment) is ok.

```rb
# bad
if (v = array.grep(/foo/)) ...

# good
if v = array.grep(/foo/) ...

# also good - has correct precedence.
if (v = next_value) == "hello" ...

* Use `||=` freely to initialize variables.

``rb
# set name to Bozhidar, only if it's nil or false
name ||= "Bozhidar"
```

* Don't use `||=` to initialize boolean variables. (Consider what would happen if the current value happened to be false.)

```rb
# bad - would set enabled to true even if it was false
enabled ||= true

# good
enabled = true if enabled.nil?
```

<a name="no-perlisms"></a>
* Avoid using Perl-style special variables (like `$0-9`, `$`, etc. ). They are quite cryptic and their use in anything but one-liner scripts is discouraged. Prefer long form versions such as `$PROGRAM_NAME`. [[link](#no-perlisms)]

<a name="no-space-after-method-name"></a>
* Never put a space between a method name and the opening parenthesis. [[link](#no-space-after-method-name)]

```rb
# bad
f (3 + 2) + 1

# good
f(3 + 2) + 1
```

* If the first argument to a method begins with an open parenthesis, always use parentheses in the method invocation. For example, write `f((3 + 2) + 1)`.

* Use `_` for unused block parameters.

```rb
# bad
result = hash.map { |k, v| v + 1 }

# good
result = hash.map { |_, v| v + 1 }
```

* Don't use the `===` (threequals) operator to check types. `===` is mostly an implementation detail to support Ruby features like case, and it's not commutative. For example, `String === "hi"` is true and `"hi" === String` is false. Instead, use `is_a?` or `kind_of?` if you must.

Refactoring is even better. It's worth looking hard at any code that explicitly checks types.

## Naming

<a name="variable-names"></a>
* Use `snake_case` for methods and variables. [[link](#variable-names)]

<!--
* Use `CamelCase` for classes and modules. (Keep acronyms like `HTTP`, `RFC`, `XML` uppercase.)
-->

<a name="constant-names"></a>
* Use `SCREAMING_SNAKE_CASE` for other constants. [[link](#constant-names)]

* The names of predicate methods (methods that return a boolean value) should end in a question mark. (i.e. `Array#empty?`).

* The names of potentially "dangerous" methods (i.e. methods that modify the class's state, the arguments, `exit!`, modify global state, etc.) should end with an exclamation mark. Bang methods should only exist if a non-bang method exists. (More on this).

## Classes

<a name="class-vars"></a>
* Avoid the usage of class (`@@`) variables due to their unusual behavior in inheritance. [[link](#class-vars)]

```rb
class Parent
  @@class_var = "parent"

  def self.print_class_var
    puts @@class_var
  end
end

class Child < Parent
  @@class_var = "child"
end

Parent.print_class_var # => will print "child"
```

As you can see all the classes in a class hierarchy actually share one class variable. Class instance variables should usually be preferred over class variables.

* Use `def self.method` to define singleton methods. This makes the methods more resistant to refactoring changes.

```rb
class TestClass
  # bad
  def TestClass.some_method
    # body omitted
  end

  # good
  def self.some_other_method
    # body omitted
  end
```

* Avoid `class << self` except when necessary, e.g. single accessors and aliased attributes.

```rb
class TestClass
  # bad
  class << self
    def first_method
      # body omitted
    end

    def second_method_etc
      # body omitted
    end
  end

  # good
  class << self
    attr_accessor :per_page
    alias_method :nwo, :find_by_name_with_owner
  end

  def self.first_method
    # body omitted
  end

  def self.second_method_etc
    # body omitted
  end
end
```

<a name="access-modifier-indent"></a>
* Indent the `public`, `protected`, and `private` methods as much the method definitions they apply to. Leave one blank line above and after them. [[link](#access-modifier-indent)]

```rb
class SomeClass
  def public_method
    # ...
  end

  private

  def private_method
    # ...
  end
end
```

<!--
* Avoid explicit use of `self` as the recipient of internal class or instance messages unless to specify a method shadowed by a variable.

```rb
class SomeClass
  attr_accessor :message

  def greeting(name)
    message = "Hi #{name}" # local variable in Ruby, not attribute writer
    self.message = message
  end
end
```
-->

## Exceptions

* Don't use exceptions for flow of control.

```rb
# bad
begin
  n / d
rescue ZeroDivisionError
  puts "Cannot divide by 0!"
end

# good
if d.zero?
  puts "Cannot divide by 0!"
else
  n / d
end
```

<a name="rescue-specific-exceptions"></a>
* Rescue specific exceptions, not `StandardError` or its superclasses. [[link](#rescue-specific-exceptions)]

```rb
# bad
begin
  # an exception occurs here
rescue
  # exception handling
end

# still bad
begin
  # an exception occurs here
rescue Exception
  # exception handling
end
```

## Collections

<a name="percent-w"></a>
* Prefer `%w` to the literal array syntax when you need an array of words. [[link](#percent-w)]

```rb
# bad
STATES = ["draft", "open", "closed"]

# good
STATES = %w(draft open closed)
```

* Use `Set` instead of `Array` when dealing with unique elements. `Set` implements a collection of unordered values with no duplicates. This is a hybrid of `Array`'s intuitive inter-operation facilities and `Hash`'s fast lookup.

* Use symbols instead of strings as hash keys.

```rb
# bad
hash = { "one" => 1, "two" => 2, "three" => 3 }

# good
hash = { :one => 1, :two => 2, :three => 3 }
```

<a name="banned-aliases"></a>
* `collect`, `collect!`, `inject`, `detect`, and `find_all` are banned; use `map`, `map!`, `reduce`, `find`, and `select` instead. [[link](#banned-aliases)]

## Strings

* Prefer string interpolation instead of string concatenation:

```rb
# bad
email_with_name = user.name + " <" + user.email + ">"

# good
email_with_name = "#{user.name} <#{user.email}>"
```

<!--
* Use double-quoted strings. Interpolation and escaped characters will always work without a delimiter change, and `'` is a lot more common than `"` in string literals.

```rb
# bad
name = 'Bozhidar'

# good
name = "Bozhidar"
```
-->

* Avoid using `String#+` when you need to construct large data chunks. Instead, use `String#<<`. Concatenation mutates the string instance in-place and is always faster than `String#+`, which creates a bunch of new string objects.

```rb
# good and also fast
html = ""
html << "<h1>Page title</h1>"

paragraphs.each do |paragraph|
  html << "<p>#{paragraph}</p>"
end
```

## Regular Expressions

* Avoid using `$1-9` as it can be hard to track what they contain. Named groups can be used instead.

```rb
# bad
/(regexp)/ =~ string
...
process $1

# good
/(?<meaningful_var>regexp)/ =~ string
...
process meaningful_var
```

* Be careful with `^` and `$` as they match start/end of line, not string endings. If you want to match the whole string use: `\A` and `\z`.

```rb
string = "some injection\nusername"
string[/^username$/]   # matches
string[/\Ausername\z/] # don't match
```

## Percent Literals

* In general you should avoid percent literals (`%w`, `%i`, `%r`, etc.) because they are cryptic. Exceptions might be large arrays of words or symbols where the percent literal syntax makes it much easier to read

```rb
STATES = %w(massachusetts maine kentucky vermont florida california texas)
```

<!--
## Hashes

* Use hashrocket syntax for Hash literals instead of the JSON style introduced in 1.9.

```rb
# bad
user = {
  login: "defunkt",
  name: "Chris Wanstrath"
}

# bad
user = {
  login: "defunkt",
  name: "Chris Wanstrath",
  "followers-count" => 52390235
}

# good
user = {
  :login => "defunkt",
  :name => "Chris Wanstrath",
  "followers-count" => 52390235
}
```
-->

## Keyword Arguments

* Keyword arguments are recommended but not required when a method's arguments may otherwise be opaque or non-obvious when called. Additionally, prefer them over the old "Hash as pseudo-named args" style from pre-2.0 ruby.

So instead of this:

```rb
def remove_member(user, skip_membership_check=false)
  # ...
end

# Elsewhere: what does true mean here?
remove_member(user, true)
```

Do this, which is much clearer.

```rb
def remove_member(user, skip_membership_check: false)
  # ...
end

# Elsewhere, now with more clarity:
remove_member user, skip_membership_check: true
```

A few other more expressive suggestions:

```rb
# Rather than create a hash each time this method is called, why not use something truthy?
remove_member(user, :skip_membership_check)
```

Or use a unreferenced local variable which will be removed during optimization by the compiler:

```rb
remove_member(user, _skip_membership_check = true)
```
