#! /usr/bin/env fan
// Copyright (c) 2023, Brian Frank and Andy Frank
// Licensed under the Academic Free License version 3.0
//
// History:
//   3 Aug 23  Brian Frank  Creation

using build
using fanr

**
** Build script for directory
**
class Build : BuildGroup
{
  new make()
  {
    childrenScripts =
    [
      `icons/build.fan`,
      `gfx/build.fan`,
      `fwt/build.fan`,
      `flux/build.fan`,
      `fluxText/build.fan`,
      `webfwt/build.fan`,
    ]
  }

  @Target { help="Publish to EggBox" }
  Void publish()
  {
    pods := ["icons", "gfx", "fwt", "flux", "fluxText", "webfwt"]
    user := Env.cur.prompt("Eggbox user> ")
    pass := Env.cur.prompt("Eggbox pass> ")

    pods.each |pod|
    {
      Main().main(["publish", "-u", user, "-p", pass, pod])
    }
  }

}

