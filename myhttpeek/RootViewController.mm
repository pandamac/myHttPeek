#import "RootViewController.h"
#import "AppDB.h"

@implementation RootViewController
@synthesize dataList;
@synthesize myTableView;

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
    NSString *msg = [[NSString alloc] initWithFormat:@"你选择的是:%@",[[self.dataList objectAtIndex:[indexPath row]] getDisplayName]];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:msg delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [msg release];
    [alert show];
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
