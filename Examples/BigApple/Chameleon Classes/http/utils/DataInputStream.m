//
//  DataInputStream.m
//  laipaoba
//
//  Created by 沧浪之水 on 16/3/14.
//  Copyright © 2016年 沧浪之水. All rights reserved.
//

#import "DataInputStream.h"

@interface DataInputStream (PrivateMethods)
- (int32_t)read;
@end

@implementation DataInputStream

- (id)initWithData:(NSData *)aData {
	self = [self init];
	if(self != nil){
		data = [[NSData alloc] initWithData:aData];
	}
	return self;
}

- (id)init{
	self = [super init];
	if(self != nil){
		length = 0;
	}
	return self;
}

+ (id)dataInputStreamWithData:(NSData *)aData {
	DataInputStream *dataInputStream = [[self alloc] initWithData:aData];
	return [dataInputStream autorelease];
}

- (int32_t)read{
	int8_t v;
	[data getBytes:&v range:NSMakeRange(length,1)];
	length++;
	return ((int32_t)v & 0x0ff);
}

- (int8_t)readChar {
	int8_t v;
	[data getBytes:&v range:NSMakeRange(length,1)];
	length++;
	return (v & 0x0ff);
}

- (BOOL)readBool {
	return [self readChar];
}

- (int16_t)readShort {
	int32_t ch1 = [self read];
	int32_t ch2 = [self read];
	if ((ch1 | ch2) < 0){
		@throw [NSException exceptionWithName:@"Exception" reason:@"EOFException" userInfo:nil];
	}
	return (int16_t)((ch1 << 8) + (ch2 << 0));
	
}

- (int32_t)readInt {
	int32_t ch1 = [self read];
	int32_t ch2 = [self read];
	int32_t ch3 = [self read];
	int32_t ch4 = [self read];
	if ((ch1 | ch2 | ch3 | ch4) < 0){
		@throw [NSException exceptionWithName:@"Exception" reason:@"EOFException" userInfo:nil];
	}
	return ((ch1 << 24) + (ch2 << 16) + (ch3 << 8) + (ch4 << 0));
}

- (int64_t)readLong {
	int8_t ch[8];
	[data getBytes:&ch range:NSMakeRange(length, 8)];
	length = length + 8;
	
	return (((int64_t)ch[0] << 56) +
			((int64_t)(ch[1] & 255) << 48) +
			((int64_t)(ch[2] & 255) << 40) +
			((int64_t)(ch[3] & 255) << 32) +
			((int64_t)(ch[4] & 255) << 24) +
			((ch[5] & 255) << 16) +
			((ch[6] & 255) <<  8) +
			((ch[7] & 255) <<  0));
}

- (double)readDouble {
	double* d = 0;
	long long dbl = [self readLong];
	d = (double*)&dbl;
	
	return *d;
}

- (float)readFloat {
	float* ret = 0;
	unsigned int flt = [self readInt];
	ret = (float*)&flt;
	return *ret;
}

- (NSString *)readUTF {
	short utfLength = [self readShort];
	NSData *d = [data subdataWithRange:NSMakeRange(length,utfLength)];
	NSString *str = [[[NSString alloc] initWithData:d encoding:NSUTF8StringEncoding] autorelease];
	length += utfLength;
	return str;
}

- (NSData *)readBytes:(long)datalength {
	NSData *d = [[[NSData alloc] initWithData:[data subdataWithRange:NSMakeRange(length, datalength)]] autorelease];
	length += datalength;
	return d;
}

- (void)dealloc
{
	[data release];
	[super dealloc];
}

@end
