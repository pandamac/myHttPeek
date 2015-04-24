#import "RootViewController.h"
#import "AppDB.h"

@implementation RootViewController
@synthesize dataList;
@synthesize myTableView;

+(void) cleanPlist
{
    setuid(0);
    NSLog(@"cleanPlist");
    NSError *error;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    [fileManager removeItemAtPath:@"/Library/MobileSubstrate/DynamicLibraries/HttPeek.plist" error:&error];
    
    NSMutableDictionary *iadbPlist = [NSMutableDictionary dictionary];
    NSMutableDictionary *filter = [NSMutableDictionary dictionary];
    [iadbPlist setObject:filter forKey:@"Filter"];
    [iadbPlist writeToFile:@"/Library/MobileSubstrate/DynamicLibraries/HttPeek.plist" atomically:TRUE];
    setuid(0);
}

+(void)addordelAppToPlist:(NSString *)bundle
{
    setuid(0);
    NSMutableDictionary *currentPList = [NSMutableDictionary dictionaryWithContentsOfFile:@"/Library/MobileSubstrate/DynamicLibraries/HttPeek.plist"];
    
    NSError *error;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    [fileManager removeItemAtPath:@"/Library/MobileSubstrate/DynamicLibraries/HttPeek.plist" error:&error];
    
    NSMutableDictionary *filter = [currentPList objectForKey:@"Filter"];
    
    // if we don't have an existing bundles key in our dictionary
    if([filter objectForKey:@"Bundles"] == nil)
    {
        NSMutableArray *bundles = [[NSMutableArray alloc] init];
        [bundles addObject:bundle];
        [filter setObject:bundles forKey:@"Bundles"];
    }
    else {
        // otherwise use the existing bundle key
        NSMutableArray *bundles = [filter objectForKey:@"Bundles"];
        // check if the bundle already exists and add if not
        if(![bundles containsObject:bundle])
            [bundles addObject:bundle];
    }
  
    [currentPList writeToFile:@"/Library/MobileSubstrate/DynamicLibraries/HttPeek.plist" atomically:TRUE];
    
    //NSLog(@"now currentPList = %@",[currentPList objectForKey:@"Filter"]);
    setuid(0);
}


+(NSMutableArray *)iOS7GetApplist{
    static NSString *const cacheFileName = @"com.apple.mobile.installation.plist";
    NSString *relativeCachePath = [[@"Library" stringByAppendingPathComponent: @"Caches"] stringByAppendingPathComponent: cacheFileName];
    NSDictionary *cacheDict = nil;
    NSString *path = nil;
    
    for (short i = 0; 1; i++)
    {
        
        switch (i) {
            case 0:
                path = [NSHomeDirectory() stringByAppendingPathComponent: relativeCachePath];
                break;
            case 1:
                path = [[NSHomeDirectory() stringByAppendingPathComponent: @"../.."] stringByAppendingPathComponent: relativeCachePath];
                break;
            case 2:
                path = [@"/var/mobile" stringByAppendingPathComponent: relativeCachePath];
                break;
            default:
                break;
        }
        
        BOOL isDir = NO;
        if ([[NSFileManager defaultManager] fileExistsAtPath: path isDirectory: &isDir] && !isDir)
            cacheDict = [NSDictionary dictionaryWithContentsOfFile: path];
        
        if (cacheDict)
            break;
    }
    
    NSMutableArray *appList = [[NSMutableArray alloc] init];
    NSDictionary *user = [cacheDict objectForKey: @"User"];
    for(NSDictionary *key in user)
    {
        AppDB *appDB = [[AppDB alloc] init];
        [appDB setPath:[[user objectForKey:key] valueForKey:@"Path"]];
        [appDB setName:[[user objectForKey:key] valueForKey:@"CFBundleExecutable"]];
        [appDB setBundle:[[user objectForKey:key] valueForKey:@"CFBundleIdentifier"]];
        [appDB setDisplayName:[[user objectForKey:key] valueForKey:@"CFBundleDisplayName"]];
        [appList addObject:appDB];
    }
    
    return appList;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    // 初始化tableView的数据
    //NSMutableArray *list = [NSArray arrayWithObjects:@"武汉",@"上海",@"北京",@"深圳",@"广州",@"重庆",@"香港",@"台海",@"天津", nil];
    
    float SysVer = [[[UIDevice currentDevice] systemVersion] floatValue];
    if(SysVer < 8.0)
    {
        self.dataList = [RootViewController iOS7GetApplist];
    }
    else
    {
        
    }
    
    UITableView *tableView = [[[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain] autorelease];
    // 设置tableView的数据源
    tableView.dataSource = self;
    // 设置tableView的委托
    tableView.delegate = self;
    // 设置tableView的背景图
//    tableView.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Background.png"]];
    self.myTableView = tableView;
    [self.view addSubview:myTableView];
}

#pragma mark -
#pragma mark Table Data Source Methods
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.dataList count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellWithIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellWithIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellWithIdentifier];
    }
    
    NSUInteger row = [indexPath row];
    cell.textLabel.text = [[self.dataList objectAtIndex:row] getDisplayName];
    cell.imageView.image = [UIImage imageNamed:@"green.png"];
    cell.detailTextLabel.text = @"详细信息";
    cell.accessoryType = UITableViewCellSelectionStyleGray;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // NSString *msg = [[NSString alloc] initWithFormat:@"你选择的是:%@",[[self.dataList objectAtIndex:[indexPath row]] getDisplayName]];
    // UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:msg delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];   
    // [msg release];
    // [alert show];
    
    NSAutoreleasePool *p = [[NSAutoreleasePool alloc] init];
    
    NSMutableDictionary *currentPList = [NSMutableDictionary dictionaryWithContentsOfFile:@"/Library/MobileSubstrate/DynamicLibraries/HttPeek.plist"];

    NSString *bundle = [[NSString alloc] initWithString:[[self.dataList objectAtIndex:[indexPath row]] getBundle]];
    NSString *DisplayName = [[NSString alloc] initWithString:[[self.dataList objectAtIndex:[indexPath row]] getDisplayName]];
    
    [RootViewController addordelAppToPlist:bundle];

    NSMutableDictionary *currentPList2 = [NSMutableDictionary dictionaryWithContentsOfFile:@"/Library/MobileSubstrate/DynamicLibraries/HttPeek.plist"];
    
    NSString * command = [NSString stringWithFormat:@"open %@",[[self.dataList objectAtIndex:[indexPath row]] getBundle]];
   // NSLog(@"command = %@",command);
    
    setuid(0);
    system([command UTF8String]);
    setuid(0);

    // NSLog(@"sleepForTimeInterval 5");
    [NSThread sleepForTimeInterval:5];
     //NSLog(@"sleepForTimeInterval 5 over");
    
    [RootViewController cleanPlist];
    NSMutableDictionary *currentPList3 = [NSMutableDictionary dictionaryWithContentsOfFile:@"/Library/MobileSubstrate/DynamicLibraries/HttPeek.plist"];
   // NSLog(@"currentPList3 = %@",currentPList3);
    
   [p drain];
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70;
}
- (void)dealloc
{
    [self.myTableView release];
    [self.dataList release];
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
