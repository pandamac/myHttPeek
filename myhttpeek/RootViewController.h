@interface RootViewController: UIViewController <UITableViewDataSource,UITableViewDelegate>{
}
@property (nonatomic, retain) NSMutableArray *dataList;
@property (nonatomic, retain) UITableView *myTableView;
@end
