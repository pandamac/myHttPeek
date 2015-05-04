//
//  main.m
//  rootApp
//
//  Created by kivlara on 11/3/14.
//  Copyright (c) 2014 kivlara. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

int main(int argc, char * argv[])
{
    setuid(0); setgid(0);
    
    @autoreleasepool
    {
        return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
    }
}
