# slash-developers

This repo contains (will contain) the raw content for `www.contentful.com/developers/`

## Structure

All source content lives in the `source/` directory.

 - source/index - Landing page that directs users to other parts of the documentation
 - source/reference/ - Reference docs for each API, to be written in [API Blueprint](https://apiblueprint.org) format.
  - [ ] Delivery API
  - [ ] Management API
  - [ ] Preview API
 - source/overview/ - Summary articles providing an introduction to key concepts of Contentfuls API
  - [X] Data Model
  - [X] The three Content API's
  - [X] Content Localization - how is localized content stored and retrieved via the Delivery & Management API's
  - [X] Links and Querying - what are links, their strengths and limitations
  - [X] Includes - benefits of using `include`
  - [X] Synchronization - beneftis and concepts behind the Sync API
 - source/tutorials/ - Tutorial articles providing step-by-step instructions on acheiving certain outcomes via the Contentful API
  - [ ] Delivery API Quickstart
  - [ ] Management API Quickstart
  - [ ] Management API in depth
  - [ ] Working with Assets
 - source/libraries/ - Single page of content linking:
  - [X] official and unofficial SDKs by programming language
  - [X] the tools page below
 - source/tools/ - Single page linking developer oriented tools for working with the Content API's
  - [X] import/export tools
  - [ ] content migration & sync
  - [X] static site generator plugins
  - [ ] other higher-level libraries like `contentful_rails`

## Tips on contributing

Use our usual [git workflow](https://contentful.atlassian.net/wiki/display/ENG/Git+and+Github+workflow), essentially:

 - use branches & pull requests
 - all pull requests should be reviewed by somebody else before merging to master. Preferably they are reviewed by @eugenekudashev.
