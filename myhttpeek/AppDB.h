@interface AppDB : NSObject
{

}
@property (nonatomic, retain) NSString * appPath;
@property (nonatomic, retain) NSString * appName;
@property (nonatomic, retain) NSString * appBundle;
@property (nonatomic, retain) NSString * appDisplayName;
@property (nonatomic, retain) NSString * appShortVersionString;
@property (nonatomic, retain) NSString * appPackageID;
//-(void) setPath:(NSString *)n;
//-(NSString *) getPath;
//
//-(void) setName:(NSString *)n;
//-(NSString *) getName;
//
//-(void) setBundle:(NSString *)n;
//-(NSString *) getBundle;
//
//-(void) setDisplayName:(NSString *)n;
//-(NSString *) getDisplayName;
@end
