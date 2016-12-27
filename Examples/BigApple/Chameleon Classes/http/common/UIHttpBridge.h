//
//  UIPool.h
//  laipaoApp
//
//  Created by laipao on 16/3/15.
//  Copyright © 2016年 laipao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LPHttpDelegate.h"

@interface UIHttpBridge : NSObject
{
	NSMutableArray* m_data;
}

@property (nonatomic, retain) NSMutableArray* data;

+ (UIHttpBridge*)getInstance;

-(void)add:(id<LPHttpResponseDelegate>)item;
-(void)remove:(id<LPHttpResponseDelegate>)item;
-(void)clean;
-(id<LPHttpResponseDelegate>)getItemWithModeId:(long)modeId;

@end
