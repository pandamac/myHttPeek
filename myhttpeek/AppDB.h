@interface AppDB : NSObject
{
    NSString * appName;
    NSString * appPath;
    NSString * appBundle;
    NSString * appDisplayName;
}

-(void) setPath:(NSString *)n;
-(NSString *) getPath;
-(void) setName:(NSString *)n;
-(NSString *) getName;
-(void) setBundle:(NSString *)n;
-(NSString *) getBundle;
-(void) setDisplayName:(NSString *)n;
-(NSString *) getDisplayName;
@end
