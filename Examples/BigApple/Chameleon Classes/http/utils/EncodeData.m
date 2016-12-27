//
//  EncodeData.m
//  laipaoba
//
//  Created by 沧浪之水 on 16/3/14.
//  Copyright © 2016年 沧浪之水. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "EncodeData.h"
#import "DataOutputStream.h"
#import "httpCommon.h"


@implementation EncodeData

+ (NSData*) EncodeHttpData: (LPMessage*) _mes
{
    NSData* rdata = NULL;
	DataOutputStream *tempstr = [[[DataOutputStream alloc] init] autorelease];
	[tempstr writeChar:76];
	[tempstr writeChar:80];
	
	NSData* _data = [_mes getData];
	
	[tempstr writeInt:(PACKAGE_HEAD + (int32_t)[_data length]) + 32];
	[tempstr writeShort:[_mes getType]];
	[tempstr writeShort:[_mes getCommand]];
	[tempstr writeLong:0];
	[tempstr writeLong:[_mes getModeid]];
	int  _id = 0;
	[tempstr writeInt:_id];
	[tempstr writeUTF:0];
	[tempstr writeBytes:_data];
	rdata = [tempstr toByteArray];
    return rdata;
}

@end
