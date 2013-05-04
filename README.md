math-core-fp11
==============

Plugin.IO Math Core Library
===========================

The Plugin.IO math core library provides a set of classes that can be used for performing algebraic and geometric functions. This library focuses in the areas of computational geometry. 



Details
-------

The Plugin.IO math package is written in ActionScript 3 and provides greater functionality than the built in `flash.geom` package. This library also adopts a more accurate mathematical representation by distinguishing between the concepts of Affine and Homogeneous space.

* [Affine Space - wikipedia article](http://en.wikipedia.org/wiki/Affine_space/ "Affine space on wikipedia")
* [Homogeneous Space - wikipedia article](http://en.wikipedia.org/wiki/Homogeneous_space/ "Homogeneous space on wikipedia")


The Plugin.IO math library is designed to be very fast but due to the extra functionality, objects have a slightly heavier memory footprint. As with any library, if you are creating and disposing of many objects, we recommend using an object pool. This Math library supports inlining which can be used for optimizing the execution speed when compiled using Adobes ASC 2.0 compiler.

* [ASC 2.0 compiler at ByteArray.org](http://www.bytearray.org/?p=4789/ "ASC 2.0 compiler at ByteArray.org")


Unit Tests
----------

* [math-tests-fp11](https://github.com/PluginIO/math-tests-fp11/ "math-tests-fp11")



Packages
--------

* `plugin.math.algebra`
* `plugin.math.base`
* `plugin.math.intersection`
* `plugin.math.objects3d`



Usage
-----

This library is well suited to tasks involved in computational geometry, engineering, robotics and/or mathematical software and was written for [Zest3D](http://www.zest3d.com/ "Zest3D"), a real-time, GPU based, Flash/Air 3D engine.



Zest3D Links
------------

* [Official site](http://www.zest3d.com/ "official site")
* [Facebook](http://www.facebook.com/zest3d/ "facebook")
* [Twitter](http://www.twitter.com/zest3d/ "twitter")