//
//  ViewController.m
//  testhttpconnect
//
//  Created by panda on 27/4/15.
//  Copyright (c) 2015 360. All rights reserved.
//

#import "ViewController.h"
#import "MyAdditions.h"
#import <Foundation/NSJSONSerialization.h>

@interface ViewController ()

@end

@implementation ViewController

-(void)ConstructPacket:(NSString *) app_name :(NSString *) app_version :(NSString * )app_package_id: (NSString *) device_tag :(NSString *) method: (NSString *)url : (NSString * )host : (NSString *)cookie :(NSString *)mime :(NSString *)data
{
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    
    //token：生成算法$token=md5(md5($app_name.$ app_version.$ app_package_id.$device_tag)."SeC0riTy")
    
    NSString * Params = [NSString stringWithFormat:@"%@%@%@%@",app_name,app_version,app_package_id,device_tag];
    NSString *token = [[[Params md5] stringByAppendingString:@"SeC0riTy"] md5];
    
    NSError * error = [[NSError alloc] init];
    // stringByReplacingOccurrencesOfString:@"&" withString:@"%26" ]
    NSArray * array1 = [NSArray arrayWithObjects:method,url,host,cookie,mime,data,nil];
    NSArray * array2 = [NSArray arrayWithObjects:@"method",@"url",@"host",@"cookie",@"mime",@"data",nil];
    NSDictionary *param = [NSDictionary dictionaryWithObjects:array1 forKeys:array2];
    
    NSArray * array3 = [NSArray arrayWithObjects:method,url,host,cookie,mime,data,nil];
    NSArray * array4 = [NSArray arrayWithObjects:@"method",@"url",@"host",@"cookie",@"mime",@"data",nil];
    NSDictionary *param2 = [NSDictionary dictionaryWithObjects:array1 forKeys:array2];
    
    NSArray * array5 = [NSArray arrayWithObjects:method,url,host,cookie,mime,data,nil];
    NSArray * array6 = [NSArray arrayWithObjects:@"method",@"url",@"host",@"cookie",@"mime",@"data",nil];
    NSDictionary *param3 = [NSDictionary dictionaryWithObjects:array1 forKeys:array2];
    
    NSArray * paramSum = [NSArray arrayWithObjects:param,param2,param3,nil];
    
    //NSString * adust = [NSString stringWithFormat:@"{\"method\":\"%@\",\"url\":\"%@\",\"host\":\"%@\",\"cookie\":\"%@\",\"mime\":\"%@\",\"data\":\"%@\"}",method,url,host,cookie,@"application/json",@"id=1&type=3"];
    //NSData * param = adust.JSONValue;
    
    NSData *urls =[ NSJSONSerialization dataWithJSONObject:paramSum
                                                   options:NSJSONWritingPrettyPrinted
                                                     error:&error];
    
    NSString *jsonString = [[NSString alloc] initWithData:urls encoding:NSUTF8StringEncoding];
    
    jsonString = [jsonString stringByDecodingHTMLEntities];
    jsonString = [jsonString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    jsonString = [jsonString stringByReplacingOccurrencesOfString:@"&" withString:@"%26"];

    
    NSString *post = [NSString stringWithFormat:@"app_name=%@&app_version=%@&app_package_id=%@&device_tag=%@&token=%@&urls=%@",\
                      app_name,app_version,app_package_id,device_tag,token,jsonString];//[[urls description] dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES]
    
    NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    NSString *postLength = [NSString stringWithFormat:@"%d",[postData length]];
    
    [request setURL:[NSURL URLWithString:@"http://pcap.0kee.com/ios.php"]];
    [request setHTTPMethod:@"POST"];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:postData];
    NSURLConnection *conn = [[NSURLConnection alloc] initWithRequest:request delegate:self];///
    if(conn) {
        NSLog(@"Connection Successful");
        [conn start];
    } else {
        NSLog(@"Connection could not be made");
    }
}


- (IBAction)SendPacket:(UIButton *)sender {
    [self ConstructPacket :@"test"
                          :@"0.1"
                          :@"25FDD7C5-6257-4C33-92C7-C6528B51AE80"
                          :@"panda"
                          :@"POST"
                          :@"https://q.jia.360.cn/app/cmd?id=1&amp;id2=3"
                          :@"q.jia.360.cn"
                          :@"q=u%253Dtrtrqn2015%2526n%253Dtrtrqn2015%2526le%253D%2526m%253DZGt1WGWOWGWOWGWOWGWOWGWOAmxl%2526qid%253D1425799110%2526im%253D1_t00df551a583a87f4e9%2526src%253Dmpc_ipcam_ios%2526t%253D1; t=s%253De1a1be8d84920d7107b20154a7a6b86d%2526t%253D1430214955%2526lm%253D%2526lf%253D4%2526sk%253Da13146e61794e635fb6206ce228d792f%2526mt%253D1430214955%2526rc%253D%2526v%253D2.0%2526a%253D1;qid=1425799110;sid=gkdWIpaR7dEBGu4BNdhwY9tPv0JjO02XThxplmBdiO8%3D"
                          :@"application/json"
                          :@"{\"parad\":\"{\"command\":\"getInfo\",\"sn\":\"36020021193\",\"taskid\":\"7FA4A947-7EAF-4206-A481-529C0ADB3DF2\"}\"}"];//
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
// This method is used to receive the data which we get using post method.
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData*)data
{
    //NSString * message = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    id message = [data toArrayOrNSDictionary];
    int tmp = [[[message valueForKey:@"errno"] description] intValue];
    if (tmp == 0) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:[NSString stringWithFormat:@"发送成功"] message:nil delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil];
        [alert show];
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:[NSString stringWithFormat:@"发送错误,%d,%@",tmp,[message valueForKey:@"message"]] message:nil delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil];
        [alert show];
    }
     NSLog(@"originalRequest = %@\nHTTPBody = %@\nmessage = %@",connection.originalRequest,connection.originalRequest.HTTPBody,message);
}

// This method receives the error report in case of connection is not made to server.


/*
- (void)connection:(NSURLConnection *)connection didWriteData:(long long)bytesWritten totalBytesWritten:(long long)totalBytesWritten
{
    NSLog(@"didwriteData push");
}
- (void)connectionDidResumeDownloading:(NSURLConnection *)connection totalBytesWritten:(long long)totalBytesWritten expectedTotalBytes:(long long)expectedTotalBytes
{
    NSLog(@"connectionDidResumeDownloading push");
}

- (void)connectionDidFinishDownloading:(NSURLConnection *)connection destinationURL:(NSURL *)destinationURL
{
    NSLog(@"originalRequest = %@\nHTTPBody = %@\destinationURL = %@",connection.originalRequest,connection.originalRequest.HTTPBody,destinationURL);
}

- (void)connection:(NSURLConnection *)connection didSendBodyData:(NSInteger)bytesWritten totalBytesWritten:(NSInteger)totalBytesWritten totalBytesExpectedToWrite:(NSInteger)totalBytesExpectedToWrite
{
    NSLog(@"did send body");
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    NSHTTPURLResponse *resp= (NSHTTPURLResponse *) response;
    NSLog(@"got responce with status @push %d",[resp statusCode]);
}

// Handle basic authentication challenge if needed
- (void)connection:(NSURLConnection *)connection didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge
{
    NSLog(@"credentials requested");
    NSString *username = @"username";
    NSString *password = @"password";
    
    NSURLCredential *credential = [NSURLCredential credentialWithUser:username
                                                             password:password
                                                          persistence:NSURLCredentialPersistenceForSession];
    [[challenge sender] useCredential:credential forAuthenticationChallenge:challenge];
}
*/
@end
