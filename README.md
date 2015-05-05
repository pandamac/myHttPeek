myhttpeek
-------------

> **myhttpeek_opendev:**

> - root app,use opendev&xcode to open.
> - combile step:  
> 1) choose the version of iOS --  iOS7 or iOS8 
> 2) xcode combile  
> 3) ./make  --make deb file
> 4) Before each build you should Clean the project 
> - And ssh the iOS device ,dpkg -i Package.deb , su mobile -c uicache 


> **myhttpeek:**

> - root app,use theos to create.
> - combile step:   make package install  uicache
> - bugs:   iOS8 is not the suitable screen size , so use the myhttpeek
> - httpeek_xcode  ,Easy to write project


> **testhttpconnect:**

> - normal app, Check my contract and receive package is normal
> - construct  the package of App

> **httpeekdylib:**

> - dylib of xcode, Global injection or plist specified App bundleid
> - construct  the package of App
> - copy the dylib to Package folder of myhttpeek_opendev or layout of myhttpeek