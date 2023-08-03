#! /usr/bin/env fan
// Copyright (c) 2023, Brian Frank and Andy Frank
// Licensed under the Academic Free License version 3.0
//
// History:
//   3 Aug 23  Brian Frank  Creation

using build

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
}

