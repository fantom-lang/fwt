#! /usr/bin/env fan
//
// Copyright (c) 2008, Brian Frank and Andy Frank
// Licensed under the Academic Free License version 3.0
//
// History:
//   21 Jul 08  Brian Frank  Creation
//

using build

**
** Build: flux
**
class Build : BuildPod
{
  new make()
  {
    podName = "flux"
    summary = "Flux: Core Application"
    meta    = ["org.name":     "Fantom",
               "org.uri":      "https://fantom.org/",
               "proj.name":    "Fantom Core",
               "proj.uri":     "https://fantom.org/",
               "license.name": "Academic Free License 3.0",
               "vcs.name":     "Git",
               "vcs.uri":      "https://github.com/fantom-lang/fwt"]
    depends = ["sys 1.0", "concurrent 1.0", "gfx 1.0", "fwt 1.0", "compiler 1.0"]
    srcDirs = [`fan/`, `fan/views/`, `fan/sidebars/`, `test/`]
    resDirs = [`locale/`, `test/files/`, `test/files/sub/`]
    docSrc  = true

    index  =
    [
      // uri scheme
      "sys.uriScheme.flux": "flux::FluxScheme",

      // sidebars
      "flux.sideBar": ["flux::Console", "flux::NavBar"],

      // resources
      "flux.resource.sys::File": "flux::FileResource",

      // views
      "flux.view.flux::StartResource": "flux::StartView",
      "flux.view.mime.x-directory": "flux::DirView",
      "flux.view.mime.image": "flux::ImageView",
      // crashes 2012-08-12
      //"flux.view.mime.text/html": "flux::HtmlView",
    ]
  }
}