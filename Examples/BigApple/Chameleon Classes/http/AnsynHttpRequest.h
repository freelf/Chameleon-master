#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import "UIHttpBridge.h"
#import "Reachability.h"

#import "httpCommon.h"
#import "OutputMessage.h"
#import "LPMessage.h"
#import "EncodeData.h"
#import "DataInputStream.h"

@interface AnsynHttpRequest : NSObject < NSURLConnectionDataDelegate , NSURLConnectionDelegate >
{
	
}

//结果数据
@property (nonatomic, retain) NSMutableData* responseData;
@property (nonatomic) int REQUEST_TIMEOUT; //= 30;//设置请求超时10秒钟
@property (nonatomic) int SO_TIMEOUT ;//= 30;  //设置等待数据超时时间10秒钟

+ (BOOL)NetWorkIsOK;//检查网络是否可用
//这个函数是判断wifi是否可用的函数（wifi或者蜂窝数据可用，都返回YES）
+ (BOOL)wifiIsOK;
+ (void)requestByPost:(id<LPHttpResponseDelegate>)ui Url:(NSString *)URL Postdata:(NSData *)postdata completionHandler:(void (^)(BOOL isSuc, NSData *data, NSError *connectionError)) completion timeout:(int) timeout;
+ (void)requestByPost:(id<LPHttpResponseDelegate>)ui Url:(NSString *)Url Postdata:(NSData *)postdata completionHandler:(void (^)(BOOL isSuc, NSData *data, NSError *connectionError)) completion;//post请求封装

//get异步请求封装函数
+ (void)requestByGet:(id<LPHttpResponseDelegate>)ui Url:(NSString *)URL completionHandler:(void (^)(BOOL isSuc, NSData *data, NSError *connectionError)) completion;

#pragma mark--//微信分享的异步请求
+(void)requestWXShareByPost:(id<LPHttpResponseDelegate>)ui Url:(NSString *)URL Postdata:(NSData *)postdata completionHandler:(void (^)(BOOL isSuc, NSData *data, NSError *connectionError)) completion
; //post请求封装

- (void)settimeout:(int) _timeout;



@end