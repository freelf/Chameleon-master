//
//  CloudButton.m
//  Test
//
//  Created by zhangmh on 12-7-9.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "CloudButton.h"

@implementation CloudButton

@synthesize accelerationReadonly;
@synthesize acceleration;
@synthesize distanceX;
@synthesize distanceY;

//@synthesize bili;
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {

        // Initialization code
		//UILabel * showlb = [[UILabel alloc] initWithFrame:frame];
		//[showlb setText:@"SB郭健"];
		//[showlb setBackgroundColor:[UIColor whiteColor]];
		//[self addSubview:showlb];
    }
    return self;
}


@end
