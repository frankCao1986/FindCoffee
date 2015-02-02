Introducing [FindCoffee](https://github.com/smileyborg/PureLayout)
=================

Setup
-----
*Note: you must be developing for iOS 7.0 or later to use FindCoffee.*

**Manually from GitHub**

1.	Download the whole project files in the [Source directory](https://github.com/smileyborg/UIView-AutoLayout/tree/master/Source).
2.  Please add CoreLocation and Mapkit Framework for this project
3.  After launching project, please to setting - > privacy -> location, and allow tihs app to access user location

Approach
-----

1.  MVC Structure, Data Model are Venues.h and Venues.m files.
2.  MVC Structure, View cotnains user-defined TableView Cell. Cell contains name label, distance label and address label. Also , there are two buttons. One button is for show location in apple map. Another button is to call cafe phone. If there is no phone number available. A hint is how
3.  Controller, there is only one controller. CaftTableViewController
4.  http request method is GET. using SynchronousRequest;

Testing
-----
1.  testing: unit test is mainly on the data model which is Venues.h and Venues.m. all margin values are tested.
    test file is VenuesTests.m
2.  controller's sorted data by distance are also tested, test case file is CafeTableViewControllerTests.m








