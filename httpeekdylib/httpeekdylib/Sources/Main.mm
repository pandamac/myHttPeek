
//
#import <vector>
#import <algorithm>

/*
 接口地址：http://pcap.0kee.com/ios.php
 请求方式：POST
 请求参数：
 app_name：应用名称
 app_version：应用版本
 app_package_id：应用package_id
 device_tag：测试设备自定义名称，便于后台查看时区别上传设备
 token：生成算法$token=md5(md5($app_name.$ app_version.$ app_package_id.$device_tag)."SeC0riTy")
 urls: 抓取到的http数据，json格式，具体格式及示例如下:
 [
 {
 "method":"GET",
 "url":"http://android.api.360kan.com/group/?method=group.assistv2&n=ME5IY2xKM2J3R",
 "host":"android.api.360kan.com",
 "cookie":""
 "mime":"application/json",
 "data":"id=1&type=3"
 },
 ]
 返回值：errno如果不为0，则提交失败，失败原因见message
 {
 “error”:0,
 “message”:“提交成功”
 }
 */
//
/*
#if __cplusplus
extern "C"
#endif
void ConstructPacket(NSString * method,NSArray *URLsArrary)
{
    NSString * app_name;
    NSString * app_version;
    NSString * app_package_id;
    NSString * device_tag;
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    
    //token：生成算法$token=md5(md5($app_name.$ app_version.$ app_package_id.$device_tag)."SeC0riTy")
    
    NSString * Params = [NSString stringWithFormat:@"%@%@%@%@",app_name,app_version,app_package_id,device_tag];
    NSString *token = [[[Params md5] stringByAppendingString:@"SeC0riTy"] md5];
    
    NSError * error = [[NSError alloc] init];
    
//    NSArray * array1 = [NSArray arrayWithObjects:method,[url stringByReplacingOccurrencesOfString:@"&" withString:@"%26" ] ,host,cookie,@"application/json",@"id=1%26type=3",nil];
//    NSArray * array2 = [NSArray arrayWithObjects:@"method",@"url",@"host",@"cookie",@"mime",@"data",nil];
//    NSDictionary *param = [NSDictionary dictionaryWithObjects:array1 forKeys:array2];
//    
//    NSArray * array3 = [NSArray arrayWithObjects:method,[url stringByReplacingOccurrencesOfString:@"&" withString:@"%26" ] ,host,cookie,@"application/json",@"id=2%26type=4",nil];
//    NSArray * array4 = [NSArray arrayWithObjects:@"method",@"url",@"host",@"cookie",@"mime",@"data",nil];
//    NSDictionary *param2 = [NSDictionary dictionaryWithObjects:array1 forKeys:array2];
//    
//    NSArray * array5 = [NSArray arrayWithObjects:method,[url stringByReplacingOccurrencesOfString:@"&" withString:@"%26" ] ,host,cookie,@"application/json",@"id=6%26type=5",nil];
//    NSArray * array6 = [NSArray arrayWithObjects:@"method",@"url",@"host",@"cookie",@"mime",@"data",nil];
//    NSDictionary *param3 = [NSDictionary dictionaryWithObjects:array1 forKeys:array2];
//    
//    NSArray * paramSum = [NSArray arrayWithObjects:param,param2,param3,nil];
    
    //NSString * adust = [NSString stringWithFormat:@"{\"method\":\"%@\",\"url\":\"%@\",\"host\":\"%@\",\"cookie\":\"%@\",\"mime\":\"%@\",\"data\":\"%@\"}",method,url,host,cookie,@"application/json",@"id=1&type=3"];
    //NSData * param = adust.JSONValue;
    
    NSData *urls =[ NSJSONSerialization dataWithJSONObject:URLsArrary
                                                   options:NSJSONWritingPrettyPrinted
                                                     error:&error];
    
    NSString *jsonString = [[NSString alloc] initWithData:urls encoding:NSUTF8StringEncoding];
    
    NSString *post = [NSString stringWithFormat:@"app_name=%@&app_version=%@&app_package_id=%@&device_tag=%@&token=%@&urls=%@",\
                      app_name,app_version,app_package_id,device_tag,token,[jsonString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    //[[urls description] dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES]
    
    NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    NSString *postLength = [NSString stringWithFormat:@"%d",[postData length]];
    
    [request setURL:[NSURL URLWithString:@"http://pcap.0kee.com/ios.php"]];
    [request setHTTPMethod:@"POST"];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:postData];
    NSURLConnection *conn = [[NSURLConnection alloc] initWithRequest:request delegate:nil];///
    if(conn) {
        //NSLog(@"Connection Successful");
        [conn start];
    } else {
        //NSLog(@"Connection could not be made");
    }
}
*/

//NSArray * array5 = [NSArray arrayWithObjects:method,   [url stringByReplacingOccurrencesOfString:@"&" withString:@"%26" ] ,host,cookie,@"application/json",@"id=6%26type=5",nil];
//NSArray * array6 = [NSArray arrayWithObjects:@"method", @"url",                                                           @"host",@"cookie",@"mime",@"data",nil];
//NSDictionary *param3 = [NSDictionary dictionaryWithObjects:array1 forKeys:array2];


#if __cplusplus
extern "C"
#endif
void LogData(const void *data, size_t dataLength, void *returnAddress)//ssl
{
	if (data == nil || dataLength == 0) return;

	static int s_index = 0;
	static NSString *_logDir = nil;
	static std::vector<NSURLRequest *> _requests;

	if (_logDir == nil)
	{
		_logDir = [[NSString alloc] initWithFormat:@"/var/root/tmp/%@.req", NSProcessInfo.processInfo.processName];
		[[NSFileManager defaultManager] createDirectoryAtPath:_logDir withIntermediateDirectories:YES attributes:nil error:nil];
	}

	Dl_info info = {0};
	dladdr(returnAddress, &info);

	BOOL txt = !memcmp(data, "GET ", 4) || !memcmp(data, "POST ", 5);
	NSString *str = [NSString stringWithFormat:@"FROM %s(%p)-%s(%p=>%#08lx)\n<%@>\n\n", info.dli_fname, info.dli_fbase, info.dli_sname, info.dli_saddr, (long)info.dli_saddr-(long)info.dli_fbase-0x1000, [NSThread callStackSymbols]];
	////NSLog(@"HTTPEEK DATA: %@", str);
    
//    NSArray * array1 = [NSArray arrayWithObjects:txt?data:@"",   [url stringByReplacingOccurrencesOfString:@"&" withString:@"%26" ] ,host,cookie,@"application/json",@"id=6%26type=5",nil];
//    NSArray * array2 = [NSArray arrayWithObjects:@"method",      @"url",                                                            @"host",@"cookie",@"mime",@"data",nil];
//    NSDictionary *param = [NSDictionary dictionaryWithObjects:array1 forKeys:array2];
    
    //NSLog(@"str0 = %@",str);
	NSMutableData *dat = [NSMutableData dataWithData:[str dataUsingEncoding:NSUTF8StringEncoding]];
	[dat appendBytes:data length:dataLength];
	if (txt)
    {
        //NSLog(@"data = %@", [[NSString alloc] initWithBytesNoCopy:(void *)data length:dataLength encoding:NSUTF8StringEncoding freeWhenDone:NO]);
        //NSString *data = [[NSString alloc] initWithBytesNoCopy:(void *)data length:dataLength encoding:NSUTF8StringEncoding freeWhenDone:NO];
        
    }
    
	//NSString *file = [NSString stringWithFormat:@"%@/DATA.%03d.%@", _logDir, s_index++, txt ? @"txt" : @"dat"];
	//[dat writeToFile:file atomically:NO];
}

//
#if __cplusplus
extern "C"
#endif
void LogRequest(NSURLRequest *request, void *returnAddress)
{
    static int s_index = 0;
    static NSString *_logDir = nil;
    static std::vector<NSURLRequest *> _requests;
    
    if (_logDir == nil)
    {
        _logDir = [[NSString alloc] initWithFormat:@"/var/root/tmp/%@.req", NSProcessInfo.processInfo.processName];
        [[NSFileManager defaultManager] createDirectoryAtPath:_logDir withIntermediateDirectories:YES attributes:nil error:nil];
    }
    
    if ([request respondsToSelector:@selector(HTTPMethod)])
    {
        if (std::find(_requests.begin(), _requests.end(), request) == _requests.end())
        {
            _requests.push_back(request);
            if (_requests.size() > 1024)
            {
                _requests.erase(_requests.begin(), _requests.begin() + 512);
            }
            
            Dl_info info = {0};
            dladdr(returnAddress, &info);
            
            //NSString *str = [NSString stringWithFormat:@"FROM %s(%p)-%s(%p=>%#08lx)\n<%@>\n%@: %@\n%@\n\n", \
            info.dli_fname, info.dli_fbase, info.dli_sname, info.dli_saddr, (long)info.dli_saddr-(long)info.dli_fbase-0x1000, [NSThread callStackSymbols], request.HTTPMethod, request.URL.absoluteString, request.allHTTPHeaderFields ? request.allHTTPHeaderFields : @""];
            //NSLog(@"HTTPEEK REQUEST: %@", str);
            
            NSString *httpbody = [[NSString alloc] initWithData:request.HTTPBody encoding:NSUTF8StringEncoding];
            
            //            NSString *url = [request.URL.absoluteString stringByReplacingOccurrencesOfString:@"&" withString:@"%26"];
            //            url = [url stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
 
            //NSLog(@"request.HTTPMethod = %@\nurl = %@\nhost = %@\nCookie = %@\nmime = %@\ndata = %@\nrequest.allHTTPHeaderFields = %@",\
            request.HTTPMethod,   url, request.URL.host, [request valueForHTTPHeaderField:@"Cookie"] , [request valueForHTTPHeaderField:@"Content-Type"],httpbody?[httpbody stringByReplacingOccurrencesOfString:@"&" withString:@"%26" ] :@"",request.allHTTPHeaderFields );
            
            if ([request.HTTPMethod length] == 0 || [request.URL.absoluteString length] == 0 || [request.URL.host length] ==0) {
                return;
            }
            NSArray * array1 = [NSArray arrayWithObjects:request.HTTPMethod,
                                request.URL.absoluteString,
                                request.URL.host,
                                [request valueForHTTPHeaderField:@"Cookie"]?[request valueForHTTPHeaderField:@"Cookie"]:@"",
                                [request valueForHTTPHeaderField:@"Content-Type"]?[request valueForHTTPHeaderField:@"Content-Type"]:@"",
                                httpbody?httpbody:@"",nil];
            //[httpbody stringByReplacingOccurrencesOfString:@"&" withString:@"%26" ] :@"",nil];
            NSArray * array2 = [NSArray arrayWithObjects:@"method", @"url", @"host",@"cookie", @"mime",@"data",nil];
            NSLog(@"LogRequestarray1 = %@",array1);
            NSLog(@"LogRequestarray2 = %@",array2);
            NSDictionary *param = [NSDictionary dictionaryWithObjects:array1 forKeys:array2];
            
            NSString *file = [NSString stringWithFormat:@"%@/%03d=%@.plist", _logDir, s_index++, NSUrlPath([request.URL.host stringByAppendingString:request.URL.path])];
            NSLog(@"param = %@\nfile = %@",param,file);
            [param writeToFile:file  atomically:YES];
            
            
            if (request.HTTPBody.length && request.HTTPBody.length < 10240)
            {
                NSString *str2 = [[NSString alloc] initWithData:request.HTTPBody encoding:NSUTF8StringEncoding];
                if (str2)
                {
                    //[[str stringByAppendingString:str2] writeToFile:file atomically:NO encoding:NSUTF8StringEncoding error:nil];
                    //NSLog(@"str1 = %@",[str stringByAppendingString:str2]);
                    return;
                }
            }
            //NSLog(@"str2 = %@",str);
            //[str writeToFile:file atomically:NO encoding:NSUTF8StringEncoding error:nil];
            //[request.HTTPBody writeToFile:[file stringByAppendingString:@".dat"] atomically:NO];
        }
    }
}

//
#if __cplusplus
extern "C"
#endif
void LogRequestASIHTTPRequest(ASIHTTPRequest *request, void *returnAddress)
{
    static int s_index = 0;
    static NSString *_logDir = nil;
    
    if (_logDir == nil)
    {
        _logDir = [[NSString alloc] initWithFormat:@"/var/root/tmp/%@.req", NSProcessInfo.processInfo.processName];
        [[NSFileManager defaultManager] createDirectoryAtPath:_logDir withIntermediateDirectories:YES attributes:nil error:nil];
    }
    
    if ([request respondsToSelector:@selector(requestMethod)])
    {
        NSString *data = [[NSString alloc ] initWithData:request.postBody encoding:NSUTF8StringEncoding];
   
        //NSLog(@"request.requestMethod : %@\nrequest.url.absoluteString : %@\n request.url.host : %@\nrequest.requestCookies : %@\nrequest.requestHeaders : %@",\
              request.requestMethod, request.url.absoluteString,  request.url.host,             [request requestCookies],request.requestHeaders);
        
        //NSLog(@"request.HTTPMethod = %@\nurl = %@\nhost = %@\nCookie = %@\nmime = %@\ndata = %@\nrequest.allHTTPHeaderFields = %@",\
        request.HTTPMethod,   url, request.URL.host, [request valueForHTTPHeaderField:@"Cookie"] , [request valueForHTTPHeaderField:@"Content-Type"],httpbody?[httpbody stringByReplacingOccurrencesOfString:@"&" withString:@"%26" ] :@"",request.allHTTPHeaderFields );
        if ([request.requestMethod length] == 0 || [request.url.absoluteString length] == 0 || [request.url.host length] ==0) {
            return;
        }
NSArray * array1 = [NSArray arrayWithObjects:request.requestMethod,
                    request.url.absoluteString,
                    request.url.host,
                    [request.requestHeaders objectForKey:@"Cookie"]?[request.requestHeaders objectForKey:@"Cookie"]:@"",
                    [request.requestHeaders objectForKey:@"Content-Type"]?[request.requestHeaders objectForKey:@"Content-Type"]:@"",
                    data,
                    nil];
NSLog(@"ASIarray1 = %@",array1);
NSArray * array2 = [NSArray arrayWithObjects:@"method", @"url", @"host",         @"cookie", @"mime",@"data",nil];
NSLog(@"ASIarray2 = %@",array2);
        
        NSDictionary *param = [NSDictionary dictionaryWithObjects:array1 forKeys:array2];
        
        NSString *file = [NSString stringWithFormat:@"%@/%03d=ASI%@.plist", _logDir, s_index++, NSUrlPath([request.url.host stringByAppendingString:request.url.path])];
        NSLog(@"param = %@\nfile = %@",param,file);
        BOOL flag = [param writeToFile:file  atomically:NO];
        NSLog(@"flag = %d",flag);
        
//        NSData *myData = [NSKeyedArchiver archivedDataWithRootObject:param];
//        NSError *error = nil;
//        [myData writeToFile:file options:NSDataWritingWithoutOverwriting error:&error];
//        if (error) {
//            NSLog(@"error = %@",error);
//            _logDir = [[NSString alloc] initWithFormat:@"/var/root/tmp/%@.req", NSProcessInfo.processInfo.processName];
//            [[NSFileManager defaultManager] createDirectoryAtPath:_logDir withIntermediateDirectories:YES attributes:nil error:nil];
//            NSError *error = nil;
//            [myData writeToFile:file options:NSDataWritingWithoutOverwriting error:&error];
//            if(error) {
//                NSLog(@"error2 = %@",error);
//            }
//        }
    }
}

//
#if __cplusplus
extern "C"
#endif
int main()
{
	_LogLine();
	return 0;
}
