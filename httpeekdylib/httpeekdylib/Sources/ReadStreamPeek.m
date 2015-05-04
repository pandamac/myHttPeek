
//_HOOK_FUNCTION_(always_inline, RET, LIB, FUN, ##__VA_ARGS__)

//#define _HOOK_FUNCTION_(MOD, RET, LIB, FUN, ...)
//RET $##FUN(__VA_ARGS__);\
//RET (*_##FUN)(__VA_ARGS__);\
//__attribute__((MOD)) void _Init_##FUN() {_HookFunction(#LIB, #FUN, (void *)$##FUN, (void **)&_##FUN);}\
//RET $##FUN(__VA_ARGS__)

HOOK_FUNCTION(CFReadStreamRef, /System/Library/Frameworks/CoreFoundation.framework/CoreFoundation, CFReadStreamCreateForHTTPRequest, CFAllocatorRef alloc, CFHTTPMessageRef request)
{
	//NSLog(@"~_~1%s: %p", __FUNCTION__, request);
	return _CFReadStreamCreateForHTTPRequest(alloc, request);
}

//
HOOK_FUNCTION(CFDictionaryRef, /System/Library/Frameworks/CoreFoundation.framework/CoreFoundation, CFURLRequestCopyAllHTTPHeaderFields, id request)
{
	//NSLog(@"~_~2%s: %p", __FUNCTION__, request);
	return _CFURLRequestCopyAllHTTPHeaderFields(request);
}
