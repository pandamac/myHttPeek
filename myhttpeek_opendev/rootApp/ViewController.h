//
//  ViewController.h
//  rootApp
//
//  Created by kivlara on 11/3/14.
//  Copyright (c) 2014 kivlara. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UITableViewDataSource,UITableViewDelegate,NSURLConnectionDelegate>{
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

