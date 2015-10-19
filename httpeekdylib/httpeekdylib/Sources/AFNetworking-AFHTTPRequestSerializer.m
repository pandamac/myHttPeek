
//HOOK_MESSAGE(void, ASIHTTPRequest,requestFinished)
//{//[NSArray arrayWithObjects:@"method", @"url", @"host",@"cookie", @"mime",@"data",nil];
//    //_Log(@"~_~%s: %@", __FUNCTION__, self);
//    _LogRequestASIHTTPRequest(self);
//    _ASIHTTPRequest_requestFinished(self, sel);
//    //_LogRequest([self currentRequest]);
//}
/*
HOOK_MESSAGE(void, ASIHTTPRequest,startSynchronous)
{
    _Log(@"~_~22%s: %@", __FUNCTION__, self);
    
    _ASIHTTPRequest_requestStarted(self, sel);
    //_LogRequest([self currentRequest]);
}
 //
 HOOK_MESSAGE(void, UIWebView, loadData_MIMEType_textEncodingName_baseURL_, NSData * data, NSString *MIMEType, NSString *encodingName, NSURL *baseURL)
 {
	//NSLog(@"~_~17%s: %@", __FUNCTION__, baseURL);
	LogWebView(self);
	_UIWebView_loadData_MIMEType_textEncodingName_baseURL_(self, sel, data, MIMEType, encodingName, baseURL);
 }
 
*/

/*
 
 - (AFHTTPRequestOperation *)POST:(NSString *)URLString
 parameters:(id)parameters
 success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
 failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure
 
 - (AFHTTPRequestOperation *)POST:(NSString *)URLString
 parameters:(id)parameters
 constructingBodyWithBlock:(void (^)(id <AFMultipartFormData> formData))block
 success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
 failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure
 
 - (AFHTTPRequestOperation *)GET:(NSString *)URLString
 parameters:(id)parameters
 success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
 failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure
 
*/




//typedef NSComparisonResult (^NSComparator)(id obj1, id obj2);
typedef void (^Func_success)(AFHTTPRequestOperation *operation, id responseObject);
typedef void (^Func_failure)(AFHTTPRequestOperation *operation, NSError *error);
typedef void (^Func_block)(id <AFMultipartFormData> formData);

//- (AFHTTPRequestOperation *)HTTPRequestOperationWithHTTPMethod:(NSString *)method
//URLString:(NSString *)URLString
//parameters:(id)parameters
//success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
//failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure


//内部调用的
//HOOK_MESSAGE(AFHTTPRequestOperation *, AFHTTPRequestOperationManager,HTTPRequestOperationWithHTTPMethod_URLString_success_failure,\
//             NSString *method,
//             NSString *URLString,\
//             id parameters,\
//             Func_success success,\
//             Func_failure failure)
//{
//    
//    AFHTTPRequestOperation * opration = _AFHTTPRequestOperationManager_HTTPRequestOperationWithHTTPMethod_URLString_success_failure(self, sel,method,URLString,parameters,success,failure);
//    //@"method", @"url", @"host",         @"cookie", @"mime",@"data"
//    _LogAFHTTPRequestOperationManager(self,method,URLString,parameters);
//    return opration;
//}

HOOK_MESSAGE(AFHTTPRequestOperation *, AFHTTPRequestOperationManager,POST_parameters_success_failure_,NSString *URLString,\
             id parameters,\
             Func_success success,\
             Func_failure failure)
{
    
    AFHTTPRequestOperation * opration = _AFHTTPRequestOperationManager_POST_parameters_success_failure_(self, sel,URLString,parameters,success,failure);
    _LogAFHTTPRequestOperationManager(self,@"POST",URLString,parameters);
    return opration;
}

HOOK_MESSAGE(AFHTTPRequestOperation *, AFHTTPRequestOperationManager,POST_parameters_constructingBodyWithBlock_success_failure_,NSString *URLString,\
             id parameters,\
             Func_block block, \
             Func_success success,\
             Func_failure failure)
{
    AFHTTPRequestOperation * opration = _AFHTTPRequestOperationManager_POST_parameters_constructingBodyWithBlock_success_failure_(self, sel,URLString,parameters,block,success,failure);
    _LogAFHTTPRequestOperationManager(self,@"POST",URLString,parameters);
    return opration;
}

HOOK_MESSAGE(AFHTTPRequestOperation *, AFHTTPRequestOperationManager,GET_parameters_success_failure_,NSString *URLString,\
             id parameters,\
             Func_success success,\
             Func_failure failure)
{
    AFHTTPRequestOperation * opration = _AFHTTPRequestOperationManager_GET_parameters_success_failure_(self, sel,URLString,parameters,success,failure);
    _LogAFHTTPRequestOperationManager(self,@"GET",URLString,parameters);
    return opration;
}