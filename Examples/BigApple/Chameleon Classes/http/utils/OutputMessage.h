//
//  OutputMessage.h
//  laipaoba
//
//  Created by 沧浪之水 on 16/3/14.
//  Copyright © 2016年 沧浪之水. All rights reserved.
//

#ifndef OutputMessage_h
#define OutputMessage_h
#import "LPMessage.h"
#import "DataOutputStream.h"

@interface OutputMessage : DataOutputStream {
	short type;
	short command;
	long linkid;
	long modeid;
}

// 将一个 char 值以 1-byte 值形式写入基础输出流中，先写入高字节。
- (void)setType:(short)_type;
- (void)setCommand:(short)_command;
- (void)setLinkid:(long)_linkid;
- (void)setModeid:(long)_modeid;
- (void)setCmd:(short)_type :(short)_command;
- (void)setCmd:(short)_type :(short)_command :(long)_linkid;

- (NSData*) getMsgBytes;

- (LPMessage*) getPackData;
@end
#endif /* OutputMessage_h */
