//
//  DecodeData.h
//  laipaoba
//
//  Created by 沧浪之水 on 16/3/15.
//  Copyright © 2016年 沧浪之水. All rights reserved.
//


#import <Foundation/Foundation.h>
#import "LPMessage.h"
@interface DecodeData : NSObject

+ (LPMessage*) DecodeHttpData: (NSData*) basedata;
@end