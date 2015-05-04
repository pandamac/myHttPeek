@interface RootViewController: UIViewController <UITableViewDataSource,UITableViewDelegate,NSURLConnectionDelegate>{
    int global_flag;
    int CountOfParams;
    NSData *postData;
}
@property (nonatomic, retain) NSMutableArray *dataList;
@property (nonatomic, retain) UITableView *myTableView;
@property (nonatomic, retain) UIView *viewtmp;

@property (nonatomic, retain) UIButton *but;
@property (nonatomic, retain) UIButton *but2;
@property (nonatomic, retain) NSIndexPath * global_index;
@end
