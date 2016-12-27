#import "AnsynHttpRequest.h"

#import "DecodeData.h"
//#import "SystemUtils.h"
//#import "WCAlertView.h"
//#import "AppDelegate.h"
//#import "PlayerData.h"
#define neterror @"服务器或者网络异常，请稍后重试！"
//static NSString *const acchieveServerAddress = @"http://s1.dispath.app.laipao8.com/route/url/";

@interface AnsynHttpRequest()
{
    //回调block
    void (^_completionHandler)(BOOL isSuc, NSData *data, NSError *connectionError);
    
}


- (void)startAsynchRequestWithUrlString:( NSString *)URL Postdata:( NSData *)postdata completionHandler:( void (^)( BOOL , NSData* ,NSError*))completion;

@property ( copy , nonatomic ) void (^completionHandler)(BOOL isSuc, NSData *data, NSError *connectionError);

@end



@implementation AnsynHttpRequest

- (id)init
{
    self = [super init];
    if (self)
    {
        self.responseData = [[NSMutableData alloc] init];
		_REQUEST_TIMEOUT = 5;		// 设置请求超时10秒钟
		_SO_TIMEOUT = 5;			// 设置等待数据超时时间10秒钟
    }
    
    return self;
}



- (void)dealloc
{
	self.responseData = nil;
//	[super dealloc];
}

- (void)settimeout:(int) _timeout
{
	_REQUEST_TIMEOUT = _timeout;		// 设置请求超时10秒钟
	_SO_TIMEOUT = _timeout;			// 设置等待数据超时时间10秒钟
}

- (void)startAsynchRequestWithUrlString:( NSString *)URL Postdata:( NSData *)postdata completionHandler:( void (^)( BOOL, NSData*, NSError* ))completion

{
    NSURL * _url = [NSURL URLWithString:URL];

    self.completionHandler = completion;
    
    //创建请求对象
    //默认就是GET请求
    NSMutableURLRequest *request = [ NSMutableURLRequest requestWithURL :_url
cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:_REQUEST_TIMEOUT];
	if (postdata != nil) {
		//设置请求方法
		[request setHTTPMethod:@"POST"];
        LPMessage *m = [DecodeData DecodeHttpData:postdata];
        [request setValue:[NSString stringWithFormat:@"%d + %d +%ld",m.getType,m.getCommand,random()%100000] forHTTPHeaderField:@"lpApp-COMMAND"];
	}
    //设置请求超时秒数
    [request setTimeoutInterval:_REQUEST_TIMEOUT];
    
    //解析请求参数，用NSDictionary来存参数，通过自定义的函数parseParams把它解析成一个post格式的字符串
//    NSString *parseParamsResult = [self parseParams:params];
//    NSData *postData = [parseParamsResult dataUsingEncoding:NSUTF8StringEncoding];
//    NSMutableString *postString = [ NSMutableString stringWithFormat : @ " g = ApiGGC " ];
//    for ( NSString *key in params)
//    {
//        
//        [postString appendFormat : @ "& %@ = %@ " ,key,[params objectForKey :key]];
//        
//    }
    //设置请求体
    [request setHTTPBody:postdata];

    
//    //创建一个新的队列（开启新线程）
//    NSOperationQueue *queue = [NSOperationQueue new];
//    //发送异步请求，请求完以后返回的数据，通过completionHandler参数来调用
//    [NSURLConnection sendAsynchronousRequest:request
//                                       queue:queue
//                           completionHandler:completion];
    
//    发送请求
    //使用代理发送异步请求（通常应用于文件下载）
    NSURLConnection *conn = [NSURLConnection connectionWithRequest:request delegate:self];
    [conn start];
    NSLog(@"已经发出请求---");
//    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
}

//这个函数是判断网络是否可用的函数（wifi或者蜂窝数据可用，都返回YES）
+ (BOOL)NetWorkIsOK
{
//    return YES;
    if(
       ([[Reachability reachabilityForInternetConnection] currentReachabilityStatus]
        != NotReachable)
       ||
       ([[Reachability reachabilityForLocalWiFi] currentReachabilityStatus]
        != NotReachable)
       ){
        return YES;
    }else{
        return NO;
    }
}


//这个函数是判断wifi是否可用的函数（wifi或者蜂窝数据可用，都返回YES）
+ (BOOL)wifiIsOK
{
//    return YES;
	if([[Reachability reachabilityForLocalWiFi] currentReachabilityStatus]
		!= NotReachable)
	{
		return YES;
	}else{
		return NO;
	}
}
#pragma mark--//微信分享的异步请求
+(void)requestWXShareByPost:(id<LPHttpResponseDelegate>)ui Url:(NSString *)URL Postdata:(NSData *)postdata completionHandler:(void (^)(BOOL isSuc, NSData *data, NSError *connectionError)) completion
{

    NSLog(@"发送了post");
    // 加入到UI-http通讯管理器里
    [[UIHttpBridge getInstance] add:ui];
    
    AnsynHttpRequest *ash = [[ AnsynHttpRequest alloc ] init];

    [ash startAsynchWXShareRequestWithUrlString :URL Postdata :postdata completionHandler :( void (^)( BOOL, NSData*, NSError*))completion];

}
- (void)startAsynchWXShareRequestWithUrlString:( NSString *)URL Postdata:( NSData *)postdata completionHandler:( void (^)( BOOL, NSData*, NSError* ))completion {
    
    self.completionHandler = completion;
    
    NSURL * _url = [NSURL URLWithString :URL];
    //创建请求对象
    //默认就是GET请求
    NSMutableURLRequest *request = [ NSMutableURLRequest requestWithURL :_url
                                                             cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:_REQUEST_TIMEOUT];
    NSLog(@"=======================%@",postdata);
    if (postdata != nil) {
        //设置请求方法
        [request setHTTPMethod:@"POST"];
    }
    LPMessage *m = [DecodeData DecodeHttpData:postdata];
    
    [request setValue:[NSString stringWithFormat:@"%d + %d +%ld",m.getType,m.getCommand,random()%100000] forHTTPHeaderField:@"lpApp-COMMAND"];
    //设置请求超时秒数
    [request setTimeoutInterval:_REQUEST_TIMEOUT];
    
        //设置请求体
    [request setHTTPBody:postdata];
    
    
        //    发送请求
    //使用代理发送异步请求（通常应用于文件下载）
    NSURLConnection *conn = [NSURLConnection connectionWithRequest:request delegate:self];
    [conn start];
    NSLog(@"已经发出请求---");
    
}




//post异步请求封装函数 设置timeout
+ (void)requestByPost:(id<LPHttpResponseDelegate>)ui Url:(NSString *)URL Postdata:(NSData *)postdata completionHandler:(void (^)(BOOL isSuc, NSData *data, NSError *connectionError)) completion timeout:(int) timeout
{
	
	NSLog(@"发送了post");
	// 加入到UI-http通讯管理器里
	[[UIHttpBridge getInstance] add:ui];
	
	AnsynHttpRequest *ash = [[ AnsynHttpRequest alloc ] init];
	
	[ash settimeout:2];
	
	[ash startAsynchRequestWithUrlString :URL Postdata :postdata completionHandler :( void (^)( BOOL, NSData*, NSError*))completion];
	
	[ash settimeout:5];
}
//post异步请求封装函数
+ (void)requestByPost:(id<LPHttpResponseDelegate>)ui Url:(NSString *)URL Postdata:(NSData *)postdata completionHandler:(void (^)(BOOL isSuc, NSData *data, NSError *connectionError)) completion
{
    
    NSLog(@"发送了post");
	// 加入到UI-http通讯管理器里
	[[UIHttpBridge getInstance] add:ui];
	
    AnsynHttpRequest *ash = [[ AnsynHttpRequest alloc ] init];
	
    [ash startAsynchRequestWithUrlString :URL Postdata :postdata completionHandler :( void (^)( BOOL, NSData*, NSError*))completion];
}

//get异步请求封装函数
+ (void)requestByGet:(id<LPHttpResponseDelegate>)ui Url:(NSString *)URL completionHandler:(void (^)(BOOL isSuc, NSData *data, NSError *connectionError)) completion
{
	
	AnsynHttpRequest *ash = [[ AnsynHttpRequest alloc ] init];
	
	[ash startAsynchRequestWithUrlString :URL Postdata :nil completionHandler :( void (^)( BOOL, NSData*, NSError*))completion];
}

#pragma mark - < NSURLConnectionDataDelegate,NSURLConnectionDelegate >

/*
 *当接收到服务器的数据时会调用（可能会被调用多次，每次只传递部分数据）
 */
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    NSLog(@"接收到服务器的数据");
    //拼接数据
    [_responseData appendData :data];

    
}

/*
 *当服务器的数据加载完毕时就会调用
 */
- (void)connectionDidFinishLoading:( NSURLConnection *)connection
{   
    NSLog(@"服务器的数据加载完毕");
    //处理服务器返回的所有数据
 

//    _responseData.length = 0 ;
    if (_completionHandler != NULL)
    {
        _completionHandler(YES, _responseData, NULL);
		return;
    }
	

	
//	Byte *printByte = (Byte *)[_responseData bytes];
//	printf("\n_responseData =   \n");
//	for(int i=0;i<[_responseData length];i++)
//		printf("%d ",printByte[i]);
//	printf("\n\n");
	
	LPMessage *m = [DecodeData DecodeHttpData:_responseData];
    NSLog(@"返回数据长度：%d---%@--",(int)_responseData.length,[NSThread currentThread]);
	[UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
	// 回调
	id<LPHttpResponseDelegate> item = [[UIHttpBridge getInstance] getItemWithModeId:m.getModeid];
	if (item) {
		// 先拦截一下返回数据
		if ([m getCommand] == 512) {

        }else if ([m getCommand] == 513) {

        }
		if ([m getCommand] == 0) {

			return;
		}
		NSLog(@"回调给UI：%d", [m getCommand]);
		[item LPHttpSucceed:m];
		// 用完之后千万要删除
		[[UIHttpBridge getInstance] remove:item];
	}
}


/*
 *请求错误（失败）的时候调用（请求超时\断网\没有网\，一般指客户端错误）
 */

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
	NSLog(@"请求错误");
    LPMessage *m = [DecodeData DecodeHttpData: connection.currentRequest.HTTPBody];
    
    NSLog(@"--------%d %d",m.getType,m.getCommand);

	[[NSNotificationCenter defaultCenter] postNotificationName:@"kRequestErrorNotification" object:nil];
    if (_completionHandler != NULL)
    {
        _completionHandler(YES, NULL, error);
    }

    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}

//把NSDictionary解析成post格式的NSString字符串
+ (NSString *)parseParams:(NSDictionary *)params
{
    NSString *keyValueFormat;
    NSMutableString *result = [[NSMutableString alloc] init];
    //实例化一个key枚举器用来存放dictionary的key
    NSEnumerator *keyEnum = [params keyEnumerator];
    id key;
    while (key = [keyEnum nextObject]) {
        keyValueFormat = [NSString stringWithFormat:@"%@=%@&",key,[params valueForKey:key]];
        [result appendString:keyValueFormat];
        NSLog(@"post()方法参数解析结果：%@",result);
    }
    return result;
}


@end
