# ColdFusion Oxford Dictionary API

---

This is a ColdFusion Wrapper written to interact with the Oxford Dictionary API.


## Authors

Developed by Matt Gifford (aka coldfumonkeh)

- http://www.mattgifford.co.uk
- http://www.monkehworks.com


### Share the love

Got a lot out of this package? Saved you time and money?

Share the love and visit Matt's wishlist: http://www.amazon.co.uk/wishlist/B9PFNDZNH4PY

---

## Requirements

This library requires ColdFusion 9+

The package has been tested against:

* Adobe ColdFusion 9+
* Adobe ColdFusion 10
* Railo 4
* Railo 4.1
* Railo 4.2
* Lucee 4.5
* Lucee 5

# CommandBox Compatible

## Installation
This CF wrapper can be installed as standalone or as a ColdBox Module. Either approach requires a simple CommandBox command:

`box install oxforddictionary`

Then follow either the standalone or module instructions below.

### Standalone
This wrapper will be installed into a directory called `oxforddictionary` and then can be instantiated via `new oxforddictionary.oxforddictionary()` with the following constructor arguments:

```
     appID    =	'',
     appKey   =	''
```

### ColdBox Module
This package also is a ColdBox module as well. The module can be configured by creating a `oxforddictionary configuration structure in your application configuration file: config/Coldbox.cfc with the following settings:

```
oxforddictionary = {
     appID    =	'',
     appKey   =	''
};
```
Then you can leverage the CFC via the injection DSL: `oxforddictionary@oxforddictionary`

## Useful Links

Please visit the official documentation for details on the methods available:

https://developer.oxforddictionaries.com/documentation
