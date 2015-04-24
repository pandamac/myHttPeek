#import "AppDB.h"

@implementation AppDB

-(void) setPath:(NSString *)n;
{
    appPath = n;
}

-(NSString *) getPath;
{
    return appPath;
}

-(void) setName:(NSString *)n;
{
    appName = n;
}

-(NSString *) getName;
{
    return appName;
}


-(void) setBundle:(NSString *)n;
{
    appBundle = n;
}

-(NSString *) getBundle;
{
    return appBundle;
}

-(void) setDisplayName:(NSString *)n;
{
    appDisplayName = n;
}

-(NSString *) getDisplayName;
{
    return appDisplayName;
}

@end
