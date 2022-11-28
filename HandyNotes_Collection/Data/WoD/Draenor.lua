---
--- @file
--- Map point definitions.
---

local _, this = ...

local map = this.maps['draenor']

local points = {
  [34002930] = {
    summary = this.maps['frostfire_ridge'],
  },
  [57707020] = {
    summary = this.maps['shadowmoon_valley'],
  },
  [50802600] = {
    summary = this.maps['gorgrond'],
  },
  [44205680] = {
    summary = this.maps['talador'],
  },
  [47607600] = {
    summary = this.maps['spires_of_arak'],
  },
  [27005140] = {
    summary = this.maps['nagrand'],
  },
  [59104650] = {
    summary = this.maps['tanaan_jungle'],
  },
}

this.points[map] = points
