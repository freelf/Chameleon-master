//
//  OutputMessage.m
//  laipaoba
//
//  Created by 沧浪之水 on 16/3/14.
//  Copyright © 2016年 沧浪之水. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OutputMessage.h"

@implementation OutputMessage

- (id)init{
	self = [super init];
	if(self != nil){
		type = 0;
		command = 0;
		linkid = 0;
		modeid = 0;
	}
	return self;
}

- (void)setType:(short)_type
{
	type = _type;
}

- (void)setCommand:(short)_command
{
	command = _command;
}

- (void)setLinkid:(long)_linkid
{
	linkid = _linkid;
}

- (void)setModeid:(long)_modeid
{
	modeid = _modeid;
}

- (void)setCmd:(short)_type :(short)_command
{
	[self setCmd:_type :_command :0];
}

- (void)setCmd:(short)_type :(short)_command :(long)_linkid
{
	[self setType:_type];
	[self setCommand:_command];
	[self setLinkid:_linkid];
}

- (NSData*) getMsgBytes
{
	return [self toByteArray];
}

- (LPMessage*) getPackData
{
	LPMessage *m = [[[LPMessage alloc] init] autorelease];
	[m setType:type];
	[m setCommand:command];
	[m setLinkid:linkid];
	[m setModeid:modeid];
	[m setData:[self getMsgBytes]];
	return m;
}

@end