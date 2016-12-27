//
//  UIPool.m
//  laipaoApp
//
//  Created by laipao on 16/3/15.
//  Copyright © 2016年 laipao. All rights reserved.
//

#import "UIHttpBridge.h"


static UIHttpBridge *instance = nil;

@implementation UIHttpBridge
@synthesize data = m_data;

+ (UIHttpBridge*)getInstance
{
	@synchronized(instance) {
		if (!instance) {
			[[UIHttpBridge alloc] init];
		}
	}
	return instance;
}

+ (id)allocWithZone:(struct _NSZone *)zone
{
	@synchronized(instance) {
		if (!instance) {
			instance = [super allocWithZone:zone];
		}
	}
	return instance;
}

- (UIHttpBridge*)init
{
	self.data = [[[NSMutableArray alloc] init] autorelease];
	return [super init];
}

- (void)dealloc
{
	self.data = nil;
	[super dealloc];
}

- (void)add:(id<LPHttpResponseDelegate>)item
{
	NSAssert([item respondsToSelector:@selector(LPHttpSucceed:)], @"item没有实现<refresh>方法！！！");
	NSAssert([item respondsToSelector:@selector(getModeId)], @"item没有实现<getModeId>方法！！！");
	// 判断超时清理
	long nowTimestemp = (long)[[NSDate date] timeIntervalSince1970];
	NSNumber* temp = nil;
	NSDictionary* dic = nil;
	for (long i = 0; i < [m_data count]; ++i) {
		dic = [m_data objectAtIndex:i];
		temp = [dic objectForKey:@"flag"];
		if (temp != nil && nowTimestemp - [temp longValue] > 40) {
			[m_data removeObjectAtIndex:i];
		}
	}
	// 添加新的存储
	[m_data insertObject:@{@"item":item, @"flag":[NSNumber numberWithLong:(long)[[NSDate date] timeIntervalSince1970]]} atIndex:[m_data count]];
}

- (void)remove:(id<LPHttpResponseDelegate>)item
{
	id<LPHttpResponseDelegate> temp = nil;
	NSDictionary* dic = nil;
	// 必须每次只删除一个对象，删除多了会出现问题
	for (long i = [m_data count] - 1; i >= 0; --i) {
		dic = [m_data objectAtIndex:i];
		temp = [dic objectForKey:@"item"];
		if (dic != nil && [temp isEqual:item]) {
			[m_data removeObjectAtIndex:i];
			return;
		}
	}

//	NSAssert(false, @"错误！没找到传过来的这个对象！！！");
}

- (void)clean
{
	[m_data removeAllObjects];
}

- (id<LPHttpResponseDelegate>)getItemWithModeId:(long)modeId
{
	id<LPHttpResponseDelegate> item;
	NSDictionary* dic = nil;
	for (long i = ([m_data count] - 1); i >= 0; --i) {
		dic = [m_data objectAtIndex:i];
		item = [dic objectForKey:@"item"];
		if ([item getModeId] == modeId) {
			return item;
		}
	}
	return nil;
}
	
@end
