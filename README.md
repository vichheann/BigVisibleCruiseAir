# Big Dashboard for Monitoring Continuous Integration Tools
Back to 2009, it was inspired by other tools like BigVisibleCruise. I made an AIR application, so you can use it on Windows, Mac OS X and Linux.

Basically, it fetches the same xml feed used by `cctray` tools. So you will be able to monitor the `CruiseControl` family and  the `Hudson` family. See each tool documentation. If your tool does not provide natively `cctray` feed, you may try third party plugins.

The back story is that it was my first AIR application and also I wanted to try the `mate` framework. So it may need some refactoring!

## Install
You need to install the [Adobe AIR Runtime](http://get.adobe.com/air/).
On Linux, the lastest version is [2.6](http://helpx.adobe.com/air/kb/archived-air-sdk-version.html)

Now, you can launch the air file to install. You may need administrator rights.

Once installed, you must specify the URL of the xml (same as `cctray`). For instance, `http://hudson.jboss.org/hudson/view/JBoss%20Portal/cc.xml`

## Build
You need

1. ant 1.7+
2. [Flex SDK 4.5.1](http://sourceforge.net/adobe/flexsdk/wiki/Download%20Flex%204.5/)
2. Define some properties in a file `$HOME/.ant-global.properties`

        flex_sdk_4.5=${user.home}/work/tools/sdk/flex_sdk_4.5
        air.keystore=${user.home}/work/air-cert.p12
        air.keystore.password=mysecret

Now you can launch `ant air` to build the application.

