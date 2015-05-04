//
//  MyAdditions.h
//  testhttpconnect
//
//  Created by panda on 27/4/15.
//  Copyright (c) 2015 360. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString(MyAdditions)
-(NSString *)md5;
-(id)JSONValue;
@end

@interface NSData (MyAdditions)
-(NSString *)md5;
- (id)toArrayOrNSDictionary;
@end