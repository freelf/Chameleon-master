//
//  CloudView.m
//  Test
//
//  Created by zhangmh on 12-7-9.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "CloudView.h"
#import "Utils.h"

#define MAXDIS 2.0f
#define MINDIS -2.0f


@interface CloudView()

@property (nonatomic) CGFloat top;
@property (nonatomic) CGFloat bottom;
@property (nonatomic) CGFloat left;
@property (nonatomic) CGFloat right;

- (void)animationUpdate;


- (CGFloat)limitSpeedbettowinMINandMAX:(CGFloat)speedValue;
@end

@implementation CloudView

@synthesize delegate;

@synthesize top;
@synthesize bottom;
@synthesize left;
@synthesize right;



#pragma mark -
#pragma mark --初始化方法--
- (id)initWithFrame:(CGRect)frame andNodeCount:(NSInteger)nodeCount
{
    self = [super initWithFrame:frame];
    if (self) {
        
        CGSize nodeSize = CGSizeMake(120, 30);
        
        speedMAX      =  MAXDIS;//最大移动速度
        speedMIN      = MINDIS;//最小移动速度
        
        self.left     = frame.origin.x - nodeSize.width;
        self.right    = frame.origin.x + frame.size.width;
        self.top      = frame.origin.y - nodeSize.height;
        self.bottom   = frame.origin.y + frame.size.height;
        
        oldtouchPoint = CGPointMake(-1000, -1000);
        
        for (NSInteger i = 0;i < nodeCount; i ++) {
            
            CGFloat x = arc4random()%(int)(self.right  - nodeSize.width);
            CGFloat y = arc4random()%(int)(self.bottom - nodeSize.height);
            
            CloudButton *cloudButton = [[CloudButton alloc] initWithFrame:CGRectMake(x,
                                                                                     y,
                                                                                     nodeSize.width,
                                                                                     nodeSize.height)];
			[cloudButton setBackgroundColor:[UIColor clearColor]];
            cloudButton.tag = i;
            cloudButton.userInteractionEnabled = NO;
			
			[cloudButton setText:[NSString stringWithFormat:@"王%d",(int)i]];

			
			[cloudButton setTextColor:[UIColor whiteColor]];

            
            float fontSize = arc4random()%23+5;
            
            cloudButton.font = [UIFont systemFontOfSize:fontSize];
            cloudButton.alpha = fontSize/28;
            
            NSLog(@"%d.alpha==%f",(int)i,cloudButton.alpha);
            
            [self addSubview:cloudButton];
            [cloudButton release];
			
			
			/*
			UILabel * showlb = [[UILabel alloc] initWithFrame:CGRectMake(x,
																		 y,
																		 nodeSize.width,
																		 nodeSize.height)];
			[showlb setBackgroundColor:[UIColor clearColor]];
			showlb.tag = i;
			[showlb setText:[NSString stringWithFormat:@"%d",(int)i]];
			[showlb setTextColor:[UIColor whiteColor]];
			showlb.font = [UIFont systemFontOfSize:fontSize];
			showlb.alpha = fontSize/25;
			

			
			[self addSubview:showlb];
			[showlb release];
			 
			 */
			/*
			UIButton* sillyButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
			[sillyButton setTitle:@"Click Me!" forState:UIControlStateNormal];
			[sillyButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
			[sillyButton addTarget:self action:@selector(moveTheApple:) forControlEvents:UIControlEventTouchUpInside];
			sillyButton.frame = CGRectMake(22,300,200,50);
			[self addSubview:sillyButton];
			 */
        }
		
		for (int i=0; i<self.subviews.count; i++) {
			CloudButton *cloud = [self.subviews objectAtIndex:i];
			
			cloud.distanceX = [self limitSpeedbettowinMINandMAX:[Utils randomBetween:MINDIS And:MAXDIS]];
			
			cloud.distanceY = [self limitSpeedbettowinMINandMAX:[Utils randomBetween:MINDIS And:MAXDIS]];
			
			CGFloat distance = sqrt(cloud.distanceX*cloud.distanceX+
									cloud.distanceY*cloud.distanceY);
			if (distance!=0) {
				
				//if (0.001 <= cloud.acceleration)
				{
					cloud.accelerationReadonly = (arc4random()%100)/200.0f;
				}
				
			}
			
		}
		
        animationTimer = [NSTimer scheduledTimerWithTimeInterval:1.0/60.0
                                                          target:self 
                                                        selector:@selector(animationUpdate) 
                                                        userInfo:nil 
                                                         repeats:YES];
        [animationTimer setFireDate:[NSDate distantPast]];
		
		
		
		
		
    }
	
	
    return self;
}


- (id)initWithArray:(CGRect)frame andNodeCount:(NSArray*)nodeArray
{
	self = [super initWithFrame:frame];
	if (self) {
        if (self.subviews.count > 0) {
            
        }
		CGSize nodeSize = CGSizeMake(120, 30);
		
		speedMAX      =  MAXDIS;//最大移动速度
		speedMIN      = MINDIS;//最小移动速度
		
		self.left     = frame.origin.x - nodeSize.width;
		self.right    = frame.origin.x + frame.size.width;
		self.top      = frame.origin.y - nodeSize.height;
		self.bottom   = frame.origin.y + frame.size.height;
		
		oldtouchPoint = CGPointMake(-1000, -1000);
		
		int arrcount = [nodeArray count];
		
		for (NSInteger i = 0;i < arrcount; i ++)
		{
			NSString *usernamestr = [nodeArray objectAtIndex:i];
			
//			NSString *usernamestr = [tempdic objectForKey:@"userName"];
			
			CGFloat x = arc4random()%(int)(self.right  - nodeSize.width);
			CGFloat y = arc4random()%(int)(self.bottom - nodeSize.height);
			
			CloudButton *cloudButton = [[CloudButton alloc] initWithFrame:CGRectMake(x,
																					 y,
																					 nodeSize.width,
																					 nodeSize.height)];
			[cloudButton setBackgroundColor:[UIColor clearColor]];
			cloudButton.tag = i;
			cloudButton.userInteractionEnabled = NO;
			
			[cloudButton setText:[NSString stringWithFormat:@"%@",usernamestr]];
			
			
			[cloudButton setTextColor:[UIColor whiteColor]];
			
			
			float fontSize = arc4random()%23+5;
			
			cloudButton.font = [UIFont fontWithName:@"华文黑体" size:STARWORDFONTSIZE];
			cloudButton.alpha = fontSize/32;
			
			NSLog(@"%d.alpha==%f",(int)i,cloudButton.alpha);
			
			[self addSubview:cloudButton];
			[cloudButton release];
			

		}
		
		for (int i=0; i<self.subviews.count; i++) {
			CloudButton *cloud = [self.subviews objectAtIndex:i];
			
			cloud.distanceX = [self limitSpeedbettowinMINandMAX:[Utils randomBetween:MINDIS And:MAXDIS]];
			
			cloud.distanceY = [self limitSpeedbettowinMINandMAX:[Utils randomBetween:MINDIS And:MAXDIS]];
			
			CGFloat distance = sqrt(cloud.distanceX*cloud.distanceX+
									cloud.distanceY*cloud.distanceY);
			if (distance!=0) {
				
				//if (0.001 <= cloud.acceleration)
				{
					cloud.accelerationReadonly = (arc4random()%100)/200.0f;
				}
				
			}
			
		}
		
		animationTimer = [NSTimer scheduledTimerWithTimeInterval:1.0/60.0
														  target:self
														selector:@selector(animationUpdate)
														userInfo:nil
														 repeats:YES];
		[animationTimer setFireDate:[NSDate distantPast]];
		
		
		
		
		
	}
	
	
	return self;
}



#pragma mark -
#pragma mark --触摸事件--
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *theTouch = [touches anyObject];
    CGPoint currentPoint = [theTouch  locationInView:self];
    oldtouchPoint = CGPointMake(currentPoint.x, currentPoint.y);
	
    for (int i=0; i<self.subviews.count; i++) {
        CloudButton *cloud = [self.subviews objectAtIndex:i];
        cloud.userInteractionEnabled = NO;
    }
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *theTouch = [touches anyObject];
    CGPoint currentPoint = [theTouch  locationInView:self];
    if (oldtouchPoint.x != -1000 && oldtouchPoint.y != -1000) {
        
        for (int i=0; i<self.subviews.count; i++) {
            CloudButton *cloud = [self.subviews objectAtIndex:i];
            
            cloud.distanceX = [self limitSpeedbettowinMINandMAX:(currentPoint.x - oldtouchPoint.x)];
            
            cloud.distanceY = [self limitSpeedbettowinMINandMAX:(currentPoint.y - oldtouchPoint.y)];
            
            CGFloat distance = sqrt(cloud.distanceX*cloud.distanceX+
                                    cloud.distanceY*cloud.distanceY);
            if (distance!=0) {

                if (0.001 <= cloud.acceleration) {
                    cloud.acceleration = (arc4random()%100)/200.0f;
                }
                
            }
            
        }
    } 
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    for (int i=0; i<self.subviews.count; i++) {
        CloudButton *cloud = [self.subviews objectAtIndex:i];
        cloud.userInteractionEnabled = YES;
    }
}
#pragma mark -

#pragma mark -
#pragma mark --动画事件--
- (void)animationUpdate
{
    for (int i=0; i<self.subviews.count; i++) {
        
		CloudButton *cloud = [self.subviews objectAtIndex:i];
        
        cloud.center = CGPointMake(cloud.center.x + cloud.distanceX*cloud.acceleration,
                                   cloud.center.y + cloud.distanceY*cloud.acceleration);
        if (cloud.center.x < self.left) {
            cloud.center = CGPointMake(self.right,self.bottom - cloud.center.y);
        }

        if (cloud.center.x > self.right) {
            cloud.center = CGPointMake(self.left, self.bottom - cloud.center.y);
        }
        
        if (cloud.center.y < self.top){
            cloud.center = CGPointMake(self.right - cloud.center.x, self.bottom);
        }
        
        if (cloud.center.y > self.bottom) {

            cloud.center = CGPointMake(self.right - cloud.center.x, self.top);
        }
        
        cloud.acceleration -= 0.001;

        if (cloud.acceleration < 0.001) {
            //cloud.acceleration = 0.001;
			cloud.acceleration = cloud.accelerationReadonly;
        }
            
    }
}



- (CGFloat)limitSpeedbettowinMINandMAX:(CGFloat)speedValue
{
    if (speedValue > speedMAX) {
        speedValue = speedMAX;
    }
    
    if (speedValue < speedMIN) {
        speedValue = speedMIN;
    }
    
    return speedValue;
}
#pragma mark -
#pragma mark -
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
