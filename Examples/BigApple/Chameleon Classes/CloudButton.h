//
//  CloudButton.h
//  Test
//
//  Created by zhangmh on 12-7-9.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface CloudButton : UILabel
{

}

@property (nonatomic,strong) NSString* number;
@property (nonatomic) CGFloat distanceX;
@property (nonatomic) CGFloat distanceY;

@property (nonatomic) CGFloat acceleration;
@property (nonatomic) CGFloat accelerationReadonly;
@end
