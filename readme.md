# Fantom Window Toolkit

Pods related to Fantom's original UI toolkit based on SWT.

# SWT

In order to build and run the FWT, you must install the SWT jar file
for your platform into your Fantom "lib/java/{platform}" environment:

  1. Verify your platform identifier using "fan -version" (see
     `sys::Env.platform`)
  2. Download your platform's "swt.jar" from
     [eclipse.org]`https://www.eclipse.org/swt/`
  3. Put "swt.jar" into '{home}/lib/java/ext/{platform}/swt.jar'

You can easily test SWT support by attempting to run `Flux`.

Note that common SWT jars for Windows, Mac OS, and Linux are
checked into this repo, but must be copied into your Fantom home.

