

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
HOOK_MESSAGE(NSURLConnection *, NSURLConnection, connectionWithRequest_delegate_, NSURLRequest *request, id delegate)
{
	//_Log(@"~_~9%s: %@ <%@>", __FUNCTION__, self, request);
	_LogRequest(request,@"_NSURLConnection_connectionWithRequest_delegate_");
	//_LogLine();
	NSURLConnection *ret = _NSURLConnection_connectionWithRequest_delegate_(self, sel, request, delegate);
	//if (outRequest) _LogRequest(*outRequest);
	//_LogLine();
	return ret;
}

//
HOOK_MESSAGE(NSData *, NSURLConnection, sendSynchronousRequest_returningResponse_error_, NSURLRequest *request, NSURLResponse **reponse, NSError **error)
{
    //_Log(@"~_~10%s: %@ <%@>", __FUNCTION__, self, request);
    _LogRequest(request,@"_NSURLConnection_sendSynchronousRequest_returningResponse_error_");
    NSData *ret = _NSURLConnection_sendSynchronousRequest_returningResponse_error_(self, sel, request, reponse, error);
    return ret;
}


//
HOOK_MESSAGE(void *, NSURLConnection, start)
{
	//_Log(@"~_~11%s: %@", __FUNCTION__, self);

	void *ret = _NSURLConnection_start(self, sel);
	_LogRequest([self currentRequest],@"_NSURLConnection_start");
	return ret;
}