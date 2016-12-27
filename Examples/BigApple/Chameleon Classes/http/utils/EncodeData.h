//
//  EncodeData.m
//  laipaoba
//
//  Created by 沧浪之水 on 16/3/14.
//  Copyright © 2016年 沧浪之水. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LPMessage.h"
@interface EncodeData : NSObject

+ (NSData*) EncodeHttpData: (LPMessage*) _mes;
@end