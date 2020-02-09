# Flutter GUI

We are Doing our base architecture again having learnt from the MVP.


DB
https://github.com/AKushWarrior/tailor
- DB with crypt and hive

Themes
https://github.com/AKushWarrior/verve
- Flutter Themes make easy with IOC

SEARCH
https://github.com/AKushWarrior/autotrie
- Text indexing and search. 
- Perfect for Doc search.
- How to integrate with our Modules to have search ? https://github.com/AKushWarrior/autotrie/issues/1

Mock Data Gen
https://github.com/AKushWarrior/destiny
- Needed to quickly build up data to test GUI's

Logging
https://github.com/leisim/logger_flutter

GUI Layout
https://github.com/rodydavis/navigation_rail
- Basis for app layout that works on Web, Desktop and Mobile how we want.

Responsive Layout Web, Deskop ( google flutter) and Mobile
https://github.com/rodydavis/flutter_everywhere
- Has Windows.

Responsive Master Details
https://github.com/MaikuB/master_detail_scaffold
- works much better than the way we do it now in main repo
- Issue include it: https://github.com/rodydavis/navigation_rail/issues/5

IOC
https://github.com/fluttercommunity/get_it
- forces Singleton pattern which we need.
- Typically used for Storage aspects being available from ANY packages without packages needing to have a hard dependency
- Also allows easy swap out of dependencies.