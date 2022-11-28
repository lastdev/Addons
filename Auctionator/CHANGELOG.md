# Auctionator

## [10.0.14](https://github.com/Auctionator/Auctionator/tree/10.0.14) (2022-11-24)
[Full Changelog](https://github.com/Auctionator/Auctionator/compare/10.0.13...10.0.14) 

- [Fixes #1079] Classic: Show posting history in item history view (#1278)  
- Remove docs and spec as they are unused  
- [Fixes #1277] Mainline: Selling: Item price doesn't update for new results  
- Mainline: Fix split second freezes after doing a blank search in shopping tab  
- [Fixes #1269] Mainline: Undercut scan stops without explanation (#1276)  
    Rework SellSearch and Search queries to avoid dropped queries when the item's info is not in the Blizzard item cache.  
- Update prices when use best quality reagents gets ticked/unticked  
