## Changed in v2022.22

* Macro fixes:
    * In Wrath the lines with `/print` were apparently causing issues
    * In Retail, `/click` now absolutely requires that you specify the fake mouse button you want to use rather than assuming left-click
    * As such, I've added some automatic regeneration of the macro so it can be updated to the new version without you needing to manually touch it
    * Turns out macros on secure action buttons can be much longer than real macros, so I've reduced the number of fake passthrough macro buttons I create

