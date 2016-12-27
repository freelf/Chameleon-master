//
//  LPHttpDelegate.h
//  laipaoApp
//
//  Created by laipao on 16/3/15.
//  Copyright © 2016年 laipao. All rights reserved.
//

#import "LPMessage.h"

#ifndef LPHttpDelegate_h
#define LPHttpDelegate_h

@protocol LPHttpResponseDelegate <NSObject>

@required
- (void)LPHttpSucceed:(LPMessage*) msg;

- (long)getModeId;

@end

#endif /* LPHttpDelegate_h */
