
#include "IFHOOK.h"

#ifdef NSURLConnection_IF_HOOK

//
HOOK_MESSAGE(id, NSURLConnection, initWithRequest_delegate_, NSURLRequest *request, id delegate)
{
	id ret = _NSURLConnection_initWithRequest_delegate_(self, sel, request, delegate);
	_LogRequest(request,@"_NSURLConnection_initWithRequest_delegate_");
	return ret;
}

//
HOOK_MESSAGE(id, NSURLConnection, initWithRequest_delegate_startImmediately_, NSURLRequest *request, id delegate, BOOL  startImmediately)//开始时没有Hook这个程序
{
    //_Log(@"~_~21%s: %@ <%@>", __FUNCTION__, self, request);
    id *ret = _NSURLConnection_initWithRequest_delegate_startImmediately_(self, sel, request, delegate, startImmediately);
        _LogRequest(request,@"_NSURLConnection_initWithRequest_delegate_startImmediately_");
    return ret;
}


//
HOOK_META(NSURLConnection *, NSURLConnection, connectionWithRequest_delegate_, NSURLRequest *request, id delegate)
{
	//_Log(@"~_~9%s: %@ <%@>", __FUNCTION__, self, request);
	_LogRequest(request,@"_NSURLConnection_connectionWithRequest_delegate_");
	//_LogLine();
	NSURLConnection *ret = _NSURLConnection_connectionWithRequest_delegate_(nil, sel, request, delegate);
	//if (outRequest) _LogRequest(*outRequest);
	//_LogLine();
	return ret;
}

//
HOOK_META(NSData *, NSURLConnection, sendSynchronousRequest_returningResponse_error_, NSURLRequest *request, NSURLResponse **reponse, NSError **error)
{
    //_Log(@"~_~10%s: %@ <%@>", __FUNCTION__, self, request);
    _LogRequest(request,@"_NSURLConnection_sendSynchronousRequest_returningResponse_error_");
    NSData *ret = _NSURLConnection_sendSynchronousRequest_returningResponse_error_(nil, sel, request, reponse, error);
    return ret;
}


/*
 + (void)sendAsynchronousRequest:(NSURLRequest *)request
 queue:(NSOperationQueue *)queue
 completionHandler:(void (^)(NSURLResponse *response,NSData *data,NSError *connectionError))handler
*/
//
//void (*xFunc)(sqlite3_context* context,int,sqlite3_value** value)
typedef void (^completionhandler)(NSURLResponse *response,NSData *data,NSError *connectionError);

HOOK_META(void, NSURLConnection, sendAsynchronousRequest_queue_completionHandler_, NSURLRequest *request, NSOperationQueue *queue,
          completionhandler handler)
{
    //_Log(@"~_~10%s: %@ <%@>", __FUNCTION__, self, request);
    _LogRequest(request,@"sendAsynchronousRequest_queue_completionHandler_");
    _NSURLConnection_sendAsynchronousRequest_queue_completionHandler_(nil, sel, request, queue, handler);
}

HOOK_MESSAGE(void *, NSURLConnection, start)
{
	//_Log(@"~_~11%s: %@", __FUNCTION__, self);

	void *ret = _NSURLConnection_start(self, sel);
	_LogRequest([self currentRequest],@"_NSURLConnection_start");
	return ret;
}
#endif