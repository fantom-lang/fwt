# Fantom Window Toolkit

Pods related to Fantom's original UI toolkit based on SWT.

# SWT

In order to build and run the FWT, you must install the SWT jar file
for your platform into your Fantom "lib/java/{platform}" environment:

  1. Download your platform's "swt.jar" from
     [eclipse.org]`https://www.eclipse.org/swt/`
  2. Put "swt.jar" into '{home}/lib/java/ext/swt.jar'

You can easily test SWT support by attempting to run flux via 'fan flux'.

Note that common SWT jars for Windows, Mac OS, and Linux are
checked into this repo under "lib/java/ext", but must be copied into
your Fantom home "lib/java/ext" directory.

# Mac OS

In order to run on Mac OS, you must uncomment this line bin/fanlaunch:

```
osFlags="-XstartOnFirstThread"
```

If not, you will get this error:

```
***WARNING: Display must be created on main thread due to Cocoa restrictions.
```


