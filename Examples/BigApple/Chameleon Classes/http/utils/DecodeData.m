//
//  DecodeData.m
//  laipaoba
//
//  Created by 沧浪之水 on 16/3/15.
//  Copyright © 2016年 沧浪之水. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DecodeData.h"
#import "DataInputStream.h"
#import "httpCommon.h"

@implementation DecodeData

+ (LPMessage*) DecodeHttpData: (NSData*) basedata;
{
	LPMessage* m = [[[LPMessage alloc] init] autorelease];
	DataInputStream *is = [DataInputStream dataInputStreamWithData : basedata];
	
	Byte a = [is readChar];// 标志位
	Byte b = [is readChar];// 标志位
	int dataLen = [is readInt];// 收包长度
	if(a == 76 && b == 80)
	{
		short type = [is readShort];// 命令类型
		short command = [is readShort];// 命令号
		long linkid = [is readLong];
		long modeid = [is readLong];
		int playerid = [is readInt];
//		NSString* adid = [is readUTF];

		NSData* data = [is readBytes:(dataLen - PACKAGE_HEAD)];
		
		[m setType:type];
		[m setCommand:command];
		[m setLinkid:linkid];
		[m setModeid:modeid];
		[m setPlayerid:playerid];
//		[m setAdid:adid];
		[m setData:data];
	}

	return m;
}

@end