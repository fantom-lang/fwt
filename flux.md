
# Overview

Included in this repo is desktop tool called *flux*.  Flux is a
framework for building general purpose desktop applications with
the FWT toolkit.  The standard Fantom distribution includes with
a set of flux plugins which provide basic IDE support for Fantom.

Run flux with this command:

```
fan flux

// open a specific file
fan flux Foo.open
```

# Navigation Model

Flux is based on a browser based paradigm.  Users hyperlink from
one Uri to another.  They can navigate back or forward in their
navigation history just like a browser.

Unlike a normal browser, we leverage Fantom's built-in [naming](https://fantom.org/doc/docLang/Naming)
framework.  This means we can use Flux to browser any Uri mapped into
the Fantom's namespace including the file system, "fan:" namespaces, or any
of the protocols plugged into Fantom via `UriScheme`.

When a user navigates to a uri, the uri is resolved into a Fantom object
via the standard naming subsystem.  We call the resolved
object a *resource*.  Then the runtime uses [indexed props](https://fantom.org/doc/docLang/Env#index)
to find all the *views* registered to view and edit the resource.  It is
not uncommon for a resource to have multiple views, in which case the user
can switch between them using the pull down on the right side of the locator bar.

See flux pod docs for the details regarding the navigation and the
various APIs and framework hooks.

# Text Editor

The `fluxText` pod provides a text editor plugin for working with
files mapped to a "text/*" MIME type.  The flux editor is pretty
basic if you are used to working with a monster like Eclipse.
But you'll find quite a number of useful features:
  - syntax color coding
  - auto indent
  - block indent and unindent
  - brace matching
  - various options for whitespace handling
  - find and replace

# Options
Flux options are stored in plain text fog files under "etc/flux" and
"etc/fluxText".  In most cases editing the text file will be reloaded
the next time a view is loaded.

## Key Bindings

All the commands in flux have a globally unique string id.  Common
predefined commands have an id like "cut" or "save".  By default commands are
configured as localized props.  But you can custom the key binding for
any command via `flux::KeyOptions`.

## Text Editor

See the `fluxText::TextEditorOptions` to configure general options
when working with text files:
  - char encoding
  - Unix or Window's newline
  - convert tabs to spaces
  - tab spacing
  - strip trailing whitespace on save
  - configure styling for syntax color coding

## Syntax Color Coding

You can add syntax color coding for new languages easily through
the options.  First step is to map file extensions to a syntax
definition in "etc/syntax/ext.props".

For example let's say we want to add support for "foolang".  First
we edit "etc/syntax/ext.props" to map the file extension "foo" to
the definition named "foolang":

```fantom
foo=foolang
```

Next we create the syntax rules in "etc/syntax/syntax-foolang.fog"
using `syntax::SyntaxRules`.  This is where we define our keywords
and syntax for comments and string literals.  It is easiest to start
off with a definition for a language you are already familiar with.
For example Java's syntax rules are:

```fantom
  // java syntax rules
  SyntaxRules
  {
    // list of end of line comment tokens
    comments = ["//"]

    // block comments
    blockCommentStart = "/*"
    blockCommentEnd   = "*/"
    blockCommentsNest = false

    // string and character literals
    strs =
    [
      SyntaxStr { delimiter = "\""; escape = '\\'; multiLine = false }, // String
      SyntaxStr { delimiter = "'"; escape = '\\'; multiLine = false }   // char
    ]

    // keyword list
    keywords =
    [
      "abstract",
      "assert",
      "boolean",
      ...
```

# Tools

You can add your own commands into the Tools menu.  Tools are nothing
but a Fantom script file which declares a `flux::FluxCommand` class.  The
Tools menu structure reflects the "etc/flux/tools/" directory.  Sub-directories
are represented as sub-menus and scripts ending in ".fan" are the command
menu items.  When the command is executed the script is compiled if out
of date and the `FluxCommand.invoke` is invoked.  Here is an example
tool script:

```fantom
  using fwt
  using flux

  class HelloWorld : FluxCommand
  {
    new make(Str id) : super(id) {}

    override Void invoke(Event? event)
    {
      Dialog.openInfo(frame, "Hello world tool!")
    }
  }
```

A common use of tools is to spawn an external program such as a compiler.
You can do this via the console sidebar.  For example assuming "fan" is
your path, the following will run "fan -version" and show the output in
the console:

```fantom
  override Void invoke(Event? event)
  {
    frame.console.show.exec(["fan", "-version"])
  }
```

The console will detect any absolute paths in the process output
and turn them into "marks" which you can use to jump to with the
JumpNext and JumpPrev commands.  You can also also click on any
line in the console with a blue underline to jump to that file
location.

If you wish to have an accelerator to your tool, then add the command
to your "etc/flux/keys.fog" file, where the key is "tools.{filename}":

```fantom
  bindings =
  [
    "tools.HelloWorld": "Ctrl+F9",
    ...
```

# Compiling Fantom

The standard Fantom distribution includes a tools script called "Build".
If you run this tool in any file which is under a directory which contains
a "build.fan" script, it will run the build script with the default
target - this a convenient way to recompile the current pod you are
working on.

By default the fan installation used to run the build script is found by
looking up the directory tree if your source tree is under fan home.  If
your source is not under a fan installation, then the installation being
used to run Flux is used to run the build script.

The compiler output is sent to the console.  Errors locations are
marked with blue underlines in the console.  You can click the console
to jump to that location, or use the JumpNext/JumpPrev commands to
cycle thru the errors.

Remember that "Build" is just a tool script in the "etc/flux/tools" directory.
You can change the script, or use it as a template to define new scripts.

# Developing for Flux

Flux is itself a framework designed to be customized and extended with
its plugin architecture.  See the `flux::pod-doc` to learn how to use
the `flux` APIs for creating your own plugins.