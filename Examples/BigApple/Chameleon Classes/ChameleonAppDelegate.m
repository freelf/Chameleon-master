/*
 * Copyright (c) 2011, The Iconfactory. All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions are met:
 *
 * 1. Redistributions of source code must retain the above copyright
 *    notice, this list of conditions and the following disclaimer.
 *
 * 2. Redistributions in binary form must reproduce the above copyright notice,
 *    this list of conditions and the following disclaimer in the documentation
 *    and/or other materials provided with the distribution.
 *
 * 3. Neither the name of The Iconfactory nor the names of its contributors may
 *    be used to endorse or promote products derived from this software without
 *    specific prior written permission.
 *
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
 * ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
 * WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
 * DISCLAIMED. IN NO EVENT SHALL THE ICONFACTORY BE LIABLE FOR ANY DIRECT,
 * INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING,
 * BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
 * DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
 * LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE
 * OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF
 * ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */

#import "ChameleonAppDelegate.h"
#import "XLSphereView.h"
#import "Header.h"
#import <QuartzCore/CAEmitterLayer.h>
#import <QuartzCore/CAEmitterCell.h>
#import "SvGifView.h"

@interface ChameleonAppDelegate ()

@property (nonatomic,strong) XLSphereView *sphereView;
@property (strong, nonatomic) NSTimer *timer;
@property (strong, nonatomic) UIImageView *gifView;
@property (strong, nonatomic) SvGifView *rightgGifView;
@property (strong, nonatomic) SvGifView *groupGifView;
@property (nonatomic, strong) NSMutableArray *leftArray;
@property (nonatomic, strong) NSMutableArray *rightArray;
@property (nonatomic, strong) CloudView *cloud;
@property (nonatomic, copy) NSString *lastGroupName;
@property (nonatomic, strong) UIImageView *leftImageView;
@property (nonatomic, strong) UIImageView *rightImageView;
@property (nonatomic, strong) UIImageView *leftVip;
@property (nonatomic, strong) UIImageView *rightVip;
@property (nonatomic, strong) NSMutableArray *defaultArray;
@property (nonatomic, strong) SvGifView *groupBG;
@property (nonatomic, strong) UIView *leftBgView;
@property (nonatomic, assign) int  lastPersonLeftCount;
@property (nonatomic, assign) int lastPersonRightCount;
@property (nonatomic, strong) NSArray *imagesArr;
@end

@implementation ChameleonAppDelegate
-(NSMutableArray *)leftArray
{
    if (!_leftArray) {
        _leftArray = [[NSMutableArray alloc] init];
    }
    return _leftArray;
}
-(NSMutableArray *)rightArray
{
    if (!_rightArray) {
        _rightArray = [[NSMutableArray alloc]init];
    }
    return _rightArray;
}
- (void)applicationDidFinishLaunching:(UIApplication *)application
{
//    NSRect screenRect = [UIScreen mainScreen].applicationFrame;
//   CGFloat deltaX  = (screenRect.size.height * 2 - screenRect.size.width) * 0.5;
//    screenRect.size.width = screenRect.size.height * 2;
//    screenRect.origin.x = -deltaX;
    [self createConsoleWindow];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(achiveString:) name:@"ConsoleWindowController" object:nil];
	//背景星空
	window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].applicationFrame];
    window.backgroundColor = [UIColor blackColor];
	window.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
	UIImageView *imageView = [[UIImageView alloc] initWithFrame:window.frame];
	imageView.image = [UIImage imageNamed:@"20160220041221759.jpg"];
	 imageView.contentMode = UIViewContentModeScaleAspectFill;
	[window addSubview:imageView];
	[imageView release];
    
    imageIndex = 1;
	int showFontsizeX = 240;
	int showFontsizeY = 120;
    
    //跑团背景gif
	NSURL *groupfileUrl = [[NSBundle mainBundle] URLForResource:GROUPGIFNAME withExtension:@"gif"];
    _groupBG = [[SvGifView alloc] initWithCenter:CGPointMake(window.frame.size.width * 0.5, window.frame.size.height * 0.5) fileURL:groupfileUrl size:window.frame.size];
    _groupBG.backgroundColor = [UIColor clearColor];
    _groupBG.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
    [window addSubview:_groupBG];
//    [_groupBG startGif];
    [_groupBG release];
    
    //个人姓名墙左侧gif
	NSURL *fileUrl = [[NSBundle mainBundle] URLForResource:PERSONGIFNAME withExtension:@"gif"];
    _gifView = [[UIImageView alloc]initWithFrame:CGRectMake(LEFTBASEX - 200, window.frame.size.height * 0.17f + 120 - 60,400,200)];
    _gifView.contentMode = UIViewContentModeCenter;
	_gifView.backgroundColor = [UIColor clearColor];
    self.imagesArr = [self createImageArr];
//    [self performSelector:@selector(changeImages:)withObject:_gifView afterDelay:0.15  ];
	[window addSubview:_gifView];
	[_gifView release];
    _gifView.hidden = YES;
    //左侧个人姓名墙展示
	LeftB = [[CloudButton alloc] initWithFrame:CGRectMake(LEFTBASEX - 300 + 60, window.frame.size.height * 0.17f,600,120)];
	[LeftB setBackgroundColor:[UIColor clearColor]];
    LeftB.textAlignment = NSTextAlignmentLeft;
	LeftB.userInteractionEnabled = NO;
	LeftB.font = [UIFont fontWithName:@"华文黑体" size:PERSONFONTSIZE];
	[LeftB setTextColor:[UIColor whiteColor]];
//	LeftB.hidden = YES;
	[window addSubview:LeftB];
    
    //左侧宣言
    self.leftImageView = [[UIImageView alloc] initWithFrame:CGRectMake(LeftB.frame.origin.x - 112.5, window.frame.size.height * 0.17f + 130, 225, 100)];
    self.leftImageView.contentMode = UIViewContentModeScaleToFill;
    self.leftImageView.image = [UIImage imageNamed:@"厦马.png"];
    self.leftImageView.hidden = YES;
    [window addSubview:self.leftImageView];
    [self.leftImageView release];
    
//    self.leftBgView = [[UIView alloc]init];
//    self.leftBgView.center = self.leftImageView.center;
//    self.leftBgView.frame = CGRectMake(self.leftBgView.center.x - 315 * 0.5, self.leftBgView.center.y - 140 * 0.5, 315, 140);
    
    //左侧VIP
    self.leftVip = [[UIImageView alloc] initWithFrame:CGRectMake(LEFTBASEX, window.frame.size.height * 0.35f - showFontsizeY * 0.5 - 50 - 58, 85, 48)];
    self.leftVip.contentMode = UIViewContentModeScaleAspectFill;
    [window addSubview:self.leftVip];
    [self.leftVip release];
//	//设置发射器
//	CAEmitterLayer* _fireEmitter=[[CAEmitterLayer alloc]init];
//	_fireEmitter.emitterPosition=CGPointMake(window.frame.size.width * 0.25f - showFontsizeX * 0.5, window.frame.size.height * 0.35f - showFontsizeY * 0.5);
//	_fireEmitter.emitterSize=CGSizeMake(60, 20);
//	// 发射模式
//	_fireEmitter.emitterMode = kCAEmitterLayerOutline;
//	// 发射源的形状
//	_fireEmitter.emitterShape = kCAEmitterLayerLine;
//	// 发射源的渲染模式
//	_fireEmitter.renderMode = kCAEmitterLayerAdditive;
//	// 发射源初始化随机数产生的种子
//	_fireEmitter.seed = (arc4random()%100)+1;
//	
//	
//	
//	/**
//	 * 添加爆炸的效果，突然之间变大一下的感觉
//	 */
//	CAEmitterCell* burst = [CAEmitterCell emitterCell];
//	burst.birthRate = 1.0;
//	burst.velocity = 0;
//	burst.scale = 2.5;
//	burst.redSpeed =-1.5;
//	burst.blueSpeed =+1.5;
//	burst.greenSpeed =+1.0;
//	burst.lifetime = 0.35;
//	
//	/**
//	 *  添加星星扩散的粒子
//	 */
//	CAEmitterCell* spark = [CAEmitterCell emitterCell];
//	spark.birthRate = 400;
//	spark.velocity = 125;
//	spark.emissionRange = 2* M_PI;
//	spark.yAcceleration = 75; //粒子y方向的加速度分量
//	spark.lifetime = 3;
//	
//	spark.contents = (id) [[UIImage imageNamed:@"star"] CGImage];
//	spark.scaleSpeed =-0.2;
//	spark.greenSpeed =-0.1;
//	spark.redSpeed = 0.4;
//	spark.blueSpeed =-0.1;
//	spark.alphaSpeed =-0.25; // 例子透明度的改变速度
//	spark.spin = 2* M_PI; // 子旋转角度
//	spark.spinRange = 2* M_PI;
//	
//	_fireEmitter.emitterCells=[NSArray arrayWithObjects:spark,nil];
//	[window.layer addSublayer:_fireEmitter];
//	
	
	//个人姓名墙右侧gif
    _rightgGifView = [[SvGifView alloc] initWithCenter:CGPointMake(RIGHTBASEX + 200 , window.frame.size.height * 0.35f - showFontsizeY * 0.5 - 50 + 140 + 60 ) fileURL:fileUrl size:CGSizeMake(900, 400)];
    _rightgGifView.backgroundColor = [UIColor clearColor];
    _rightgGifView.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
    [window addSubview:_rightgGifView];
//    [_rightgGifView startGif];
    [_rightgGifView release];
    
    //右侧个人姓名墙展示
	RightB = [[CloudButton alloc] initWithFrame:CGRectMake(RIGHTBASEX, window.frame.size.height * 0.35f - showFontsizeY * 0.5 - 50,600,120)];
	[RightB setBackgroundColor:[UIColor clearColor]];
	RightB.userInteractionEnabled = NO;
	RightB.font = [UIFont fontWithName:@"华文黑体" size:PERSONFONTSIZE];
	[RightB setTextColor:[UIColor whiteColor]];
	RightB.hidden = YES;
	[window addSubview:RightB];
	
    //右侧宣言
    self.rightImageView = [[UIImageView alloc] initWithFrame:CGRectMake(RIGHTBASEX, window.frame.size.height * 0.35f - showFontsizeY * 0.5 - 50 + 150, 275, 100)];
    
    self.rightImageView.contentMode = UIViewContentModeScaleAspectFill;
    [window addSubview:self.rightImageView];
    [self.rightImageView release];
    
    
    //右侧VIP
    self.rightVip = [[UIImageView alloc] initWithFrame:CGRectMake(RIGHTBASEX, window.frame.size.height * 0.35f - showFontsizeY * 0.5 - 50 - 58, 85, 48)];
    self.rightVip.contentMode = UIViewContentModeScaleAspectFill;
    [window addSubview:self.rightVip];
    [self.rightVip release];
  //  sillyButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
  //  [sillyButton setTitle:@"Click Me!" forState:UIControlStateNormal];
  //  [sillyButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
   // [sillyButton addTarget:self action:@selector(moveTheApple:) forControlEvents:UIControlEventTouchUpInside];
  //  sillyButton.frame = CGRectMake(22,300,200,50);
  //  [window addSubview:sillyButton];
	
	
	[self requestDefaultArray];
    [window makeKeyAndVisible];
	
//	self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(requestCurrentUser) userInfo:nil repeats:YES];
    
}
-(void)changeImages:(UIImageView *)imageView
{
    if (imageIndex == 30) {
        imageIndex = 1;
    }
    imageView.image = self.imagesArr[imageIndex];
    imageIndex++;
    [self performSelector:@selector(changeImages:)withObject:imageView afterDelay:0.15 ];
    
}
-(NSArray *)createImageArr
{
    NSMutableArray *arr = [[NSMutableArray alloc]init];
    for (int i = 1; i <= 30; i++) {
        [arr addObject:[UIImage imageNamed:[NSString stringWithFormat:@"a%d.png",i]]];
    }
    return arr;
}
-(void)achiveString:(NSNotification *)note
{
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(disappear) object:nil];
    NSString *achiveStr = note.userInfo[@"text"];
    [self initRunerNameWithText:achiveStr];
    [self performSelector:@selector(disappear) withObject:nil afterDelay:30];
    if (![self.defaultArray containsObject:achiveStr]) {
        [self.defaultArray removeObject:self.defaultArray[0]];
        [self.defaultArray addObject:achiveStr];
        [self initStarEffect:self.defaultArray];
    }
}

-(void)disappear
{
    LeftB.hidden = YES;
    _gifView.hidden = YES;
    self.leftImageView.hidden = YES;
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(changeImages:) object:_gifView];
//    CGRect frame = LeftB.frame;
//    frame.origin.x = LEFTBASEX - 300 + 60;
//    LeftB.frame = frame;
}
-(void)initRunerNameWithText:(NSString *)text
{
    LeftB.hidden = NO;
    [LeftB setText:text];
    LeftB.transform = CGAffineTransformMakeScale(0.08, 0.1);
    [UIView animateWithDuration:0.3 animations:^{
        LeftB.transform = CGAffineTransformMakeScale(1.6, 2.);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.1 animations:^{
            LeftB.transform = CGAffineTransformMakeScale(0.8, 1.);
        } completion:^(BOOL finished) {
            //                            NSDictionary *attribute = @{NSFontAttributeName:[UIFont systemFontOfSize:120]};
            CGSize leftBSize = [LeftB.text sizeWithFont:[UIFont systemFontOfSize:120] constrainedToSize:CGSizeMake(INT64_MAX, 120) lineBreakMode:UILineBreakModeWordWrap];
            if (leftBSize.width > window.frame.size.width - LeftB.frame.origin.x) {
                LeftB.font = [UIFont fontWithName:@"华文黑体" size:120 * (window.frame.size.width  - LeftB.frame.origin.x) / leftBSize.width];
                leftBSize.width = window.frame.size.width  - LeftB.frame.origin.x;
            }else{
                LeftB.font = [UIFont fontWithName:@"华文黑体" size:120];
            }
            if (_gifView.hidden == YES) {
                _gifView.hidden = NO;
                imageIndex = 1;
                [self changeImages:_gifView];
            }
            [LeftB setTextColor:[UIColor whiteColor]];
            LeftB.shadowColor = [UIColor redColor];
            LeftB.shadowOffset = CGSizeMake(4,4);
            CGRect frame = LeftB.frame;
            frame.size = CGSizeMake((int)ceil(leftBSize.width), leftBSize.height);
            [LeftB setFrame:frame];
            self.leftImageView.frame = CGRectMake(LeftB.frame.origin.x, CGRectGetMaxY(LeftB.frame) + 10, 225, 100);
            self.leftImageView.hidden = NO;
            
        }];
    }];

}
-(void)createConsoleWindow
{
    if (!_consoleController)
    {
        _consoleController = [[ConsoleWindowController alloc] initWithWindowNibName:@"ConsoleWindow"];
    }
    [_consoleController.window orderFrontRegardless];
    _pipe = [NSPipe pipe] ;
    _pipeReadHandle = [_pipe fileHandleForReading] ;
    int outfd = [[_pipe fileHandleForWriting] fileDescriptor];
    if (dup2(outfd, fileno(stderr)) != fileno(stderr) || dup2(outfd, fileno(stdout)) != fileno(stdout))
    {
        perror("Unable to redirect output");
        //        [self showAlert:@"Unable to redirect output to console!" withTitle:@"player error"];
    }
    else
    {
        [[NSNotificationCenter defaultCenter] addObserver: self selector: @selector(handleNotification:) name: NSFileHandleReadCompletionNotification object: _pipeReadHandle] ;
        [_pipeReadHandle readInBackgroundAndNotify] ;
    }
}
- (void)applicationWillTerminate:(NSNotification *)aNotification {
	// Insert code here to tear down your application
}

- (void)didSelectedNodeButton:(CloudButton *)button
{
	NSLog(@"---%ld",(long)button.tag);
}

#pragma 初始化星空云
-(void) initStarEffect:(NSArray*) dataarray
{
    if (self.cloud) {
        [self.cloud removeFromSuperview];
    }
	self.cloud = [[CloudView alloc] initWithArray:window.frame
										   andNodeCount:dataarray];
	
	self.cloud.delegate = self;
	[window addSubview:self.cloud];
}

#pragma 初始化球形云
-(void) initSphereEffect:(NSDictionary*) dataarray
{
    if (dataarray.count == 0) {
        return;
    }
    if ([self.lastGroupName isEqualToString:dataarray[@"groupName"]]) {
        _sphereView.hidden = NO;
        return;
    }
    if ([self.lastGroupName isEqualToString:@""] || !self.lastGroupName) {
         [_groupBG startGif];
    }
   
//    NSURL *fileUrl = [[NSBundle mainBundle] URLForResource:@"1111" withExtension:@"gif"];
//    _groupGifView = [[SvGifView alloc] initWithCenter:CGPointMake(window.frame.size.width * 0.5f, window.frame.size.height * 0.5f - sphereViewH * 0.5 + 50 - 120 + 50) fileURL:nil];
//    _groupGifView.backgroundColor = [UIColor clearColor];
//    _groupGifView.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
//    [window addSubview:_groupGifView];
//    
//    [_groupGifView startGif];
//    [_groupGifView release];
//    [GroupName removeFromSuperview];
    if (GroupName) {
        
        [GroupName removeFromSuperview];
    }
    
    //跑团名
    GroupName = [[CloudButton alloc] initWithFrame:CGRectMake(window.frame.size.width * 0.5f - 750, 50 ,1500,100)];
     GroupName.transform = CGAffineTransformMakeScale(0.8, 1.);
    [GroupName setBackgroundColor:[UIColor clearColor]];
    GroupName.userInteractionEnabled = NO;
    GroupName.textAlignment = UITextAlignmentCenter;
    [GroupName setText:dataarray[@"groupName"]];
    GroupName.font = [UIFont fontWithName:@"华文黑体" size:GROUPNAMEFONTSIZE];
    [GroupName setTextColor:[UIColor whiteColor]];
    //	LeftB.hidden = YES;
    [window addSubview:GroupName];
    
    CGFloat sphereViewW = window.frame.size.height * 0.66 - 50;
    CGFloat sphereViewH = sphereViewW;
    CGFloat widthScale = 0.7;
    
    self.lastGroupName = dataarray[@"groupName"];
    if (_sphereView) {
        [_sphereView timerStop];
        [_sphereView removeFromSuperview];
    }
	_sphereView = [[XLSphereView alloc] initWithFrame:CGRectMake(window.frame.size.width * 0.5f - sphereViewW * 0.5 * widthScale , window.frame.size.height * 0.3f  + 50  , sphereViewW, sphereViewH)];
    
    _sphereView.transform = CGAffineTransformMakeScale(widthScale, 1);
	NSArray *array = dataarray[@"groupUsers"];
    NSMutableArray *nameArray = [[NSMutableArray alloc]init];
    
	for (NSInteger i = 0; i < GROUPNUM; i ++) {
        int indexNum = i % array.count;
        NSDictionary *tempDic = array[indexNum];
		CloudButton *cloudButton = [[CloudButton alloc] initWithFrame:CGRectMake(0,
																				 0,
																				 120,
																				 30)];
		[cloudButton setBackgroundColor:[UIColor clearColor]];
		
		cloudButton.userInteractionEnabled = NO;
		
		[cloudButton setText:tempDic[@"name"]];
       
		
//		float fontSize = 25;
		
		cloudButton.font = [UIFont fontWithName:@"华文黑体" size:GROUPPERSONFONTSIZE];
		
		
//		[cloudButton setTextColor:[UIColor colorWithRed:arc4random_uniform(255)/255. green:arc4random_uniform(255)/255. blue:arc4random_uniform(255)/255. alpha:1.]];
		
		[cloudButton setTextColor:[UIColor colorWithRed:1 green:1 blue:1 alpha:1.]];
		
		
		[_sphereView addSubview:cloudButton];
		 [nameArray addObject:cloudButton];
		/*
		 // 创建path
		 UIBezierPath *path = [UIBezierPath bezierPath];
		 // 添加路径[1条点(100,100)到点(200,100)的线段]到path
		 [path moveToPoint:CGPointMake(100 , 100)];
		 [path addLineToPoint:CGPointMake(200, 100)];
		 // 将path绘制出来
		 [path stroke];
		 */
	}
	[_sphereView setItems:nameArray];
	[window addSubview:_sphereView];
	
//	[self PerformAutoPOP];
}

#pragma 初始化参赛者效果
-(void) initUserEffect:(NSArray*) datadic
{
    
	if (datadic)
	{
    
            [self.leftArray removeAllObjects];
    
        
       
            [self.rightArray removeAllObjects];
      
        //分割左右显示数组
        for (NSDictionary *tempDic in datadic) {
            if ([tempDic[@"location"] isEqualToString:@"L"]) {
                
                [self.leftArray addObject:tempDic];
            }else if ([tempDic[@"location"] isEqualToString:@"R"]){
                
                [self.rightArray addObject:tempDic];
            }
        }
        
		int leftUsercount = [self.leftArray count];
		int rightUsercount = [self.rightArray count];
        if (leftUsercount == 0) {
//            _gifView.hidden = YES;
        }else{
//            _gifView.hidden = NO;
        }
        if (rightUsercount == 0) {
            _rightgGifView.hidden = YES;
        }else{
            _rightgGifView.hidden = NO;
        }
        if (_lastPersonRightCount == 0 && rightUsercount > 0) {
            [_rightgGifView startGif];
        }
        if (_lastPersonLeftCount == 0 && leftUsercount >0 ) {
//            [_gifView startGif];
        }
		_lastPersonLeftCount = [self.leftArray count];
        _lastPersonRightCount = [self.rightArray count];
		if (NO == LeftB.isHidden)
		{
			[self dealSBShow:leftUsercount dataarray:self.leftArray sbbutton:LeftB];
		}
		
		if(NO == RightB.isHidden)
		{
           
			[self dealSBShow:rightUsercount dataarray:self.rightArray sbbutton:RightB];
		}
		
		if (YES == LeftB.isHidden)
		{
			NSString *usernumberstr = nil;
			for (int i = 0; i < leftUsercount; i++)
			{
				NSDictionary* tempdic = [self.leftArray objectAtIndex:i];
				usernumberstr = [tempdic objectForKey:@"number"];
				if(YES == RightB.isHidden || ![RightB.number isEqualToString:usernumberstr])
				{
                    
					LeftB.hidden = NO;
                    NSString* name = [tempdic objectForKey:@"userName"];
					[LeftB setText:name];
					LeftB.transform = CGAffineTransformMakeScale(0.08, 0.1);
					LeftB.number = usernumberstr;
					[UIView animateWithDuration:0.3 animations:^{
						LeftB.transform = CGAffineTransformMakeScale(1.6, 2.);
					} completion:^(BOOL finished) {
						[UIView animateWithDuration:0.1 animations:^{
							LeftB.transform = CGAffineTransformMakeScale(0.8, 1.);
						} completion:^(BOOL finished) {
//                            NSDictionary *attribute = @{NSFontAttributeName:[UIFont systemFontOfSize:120]};
                            CGSize leftBSize = [LeftB.text sizeWithFont:[UIFont systemFontOfSize:120] constrainedToSize:CGSizeMake(INT64_MAX, 120) lineBreakMode:UILineBreakModeWordWrap];
                            if (leftBSize.width > window.frame.size.width * 0.5 - LeftB.frame.origin.x) {
                                LeftB.font = [UIFont fontWithName:@"华文黑体" size:120 * (window.frame.size.width * 0.5 - LeftB.frame.origin.x) / leftBSize.width];
                                leftBSize.width = window.frame.size.width * 0.5 - LeftB.frame.origin.x;
                            }else{
                                LeftB.font = [UIFont fontWithName:@"华文黑体" size:120];
                            }
                            [LeftB setTextColor:[UIColor whiteColor]];
                            LeftB.shadowColor = [UIColor redColor];
                            LeftB.shadowOffset = CGSizeMake(4,4);
                            CGRect frame = LeftB.frame;
                            frame.size = CGSizeMake((int)ceil(leftBSize.width), leftBSize.height);
                            [LeftB setFrame:frame];
                            
                            NSNumber *isVip = tempdic[@"vip"];
                            if ([isVip intValue] == 1) {
                                self.leftVip.hidden = YES;
                                self.leftVip.image = [UIImage imageNamed:@"VIP.png"];
                                self.leftVip.frame = CGRectMake(LeftB.frame.origin.x, LeftB.frame.origin.y - 58, 85, 48);
                            }else{
                                self.leftVip.hidden = YES;
                            }
                            
                            NSString *imageName = [NSString stringWithFormat:@"%@.%@",tempdic[@"slogan"],@"png"];
//                            self.leftImageView.hidden = NO;
                            
                            self.leftImageView.image = [UIImage imageNamed:imageName];
                            self.leftImageView.frame = CGRectMake(LeftB.frame.origin.x, CGRectGetMaxY(LeftB.frame) + 20, 275, 100);

						}];
					}];
					
					break;
				}
			}
		}
		
		if(YES == RightB.isHidden)
		{
			NSString *usernumberstr = nil;
			for (int i = 0; i < rightUsercount; i++)
			{
				NSDictionary* tempdic = [self.rightArray objectAtIndex:i];
				usernumberstr = [tempdic objectForKey:@"number"];
				if(YES == LeftB.isHidden || ![LeftB.number isEqualToString:usernumberstr])
				{
					RightB.hidden = NO;
                    NSNumber *isVip = tempdic[@"vip"];
                    if ([isVip intValue] == 1) {
                        self.rightVip.hidden = YES;
                        self.rightVip.image = [UIImage imageNamed:@"VIP.png"];
                    }else{
                        self.rightVip.hidden = YES;
                    }
					NSString* name = [tempdic objectForKey:@"userName"];
                    NSString *imageName = [NSString stringWithFormat:@"%@.%@",tempdic[@"slogan"],@"png"];
                    self.rightImageView.hidden = NO;
                    self.rightImageView.image = [UIImage imageNamed:imageName];
					[RightB setText:name];
					RightB.transform = CGAffineTransformMakeScale(0.08, 0.1);
					RightB.number = usernumberstr;
                    
					[UIView animateWithDuration:0.3 animations:^{
						RightB.transform = CGAffineTransformMakeScale(1.6, 2.);
					} completion:^(BOOL finished) {
						[UIView animateWithDuration:0.1 animations:^{
							RightB.transform = CGAffineTransformMakeScale(0.8, 1.);
						} completion:^(BOOL finished) {
                            CGSize rightBSize = [RightB.text sizeWithFont:[UIFont systemFontOfSize:120] constrainedToSize:CGSizeMake(INT64_MAX, 120) lineBreakMode:UILineBreakModeWordWrap];
                            if (rightBSize.width > window.frame.size.width  - RightB.frame.origin.x) {
                                RightB.font = [UIFont fontWithName:@"华文黑体" size:120 * (window.frame.size.width  - RightB.frame.origin.x) / rightBSize.width];
                                rightBSize.width = window.frame.size.width - RightB.frame.origin.x;
                            }else{
                                RightB.font = [UIFont fontWithName:@"华文黑体" size:120];
                            }
                            [RightB setTextColor:[UIColor whiteColor]];
                            CGRect frame = RightB.frame;
                            frame.size = CGSizeMake((int)ceil(rightBSize.width), rightBSize.height);
                            RightB.shadowColor = [UIColor redColor];
                            RightB.shadowOffset = CGSizeMake(4,4);
                            [RightB setFrame:frame];
                            NSNumber *isVip = tempdic[@"vip"];
                            if ([isVip intValue] == 1) {
                                self.rightVip.hidden = YES;
                                self.rightVip.image = [UIImage imageNamed:@"VIP.png"];
                                self.rightVip.frame = CGRectMake(RightB.frame.origin.x, RightB.frame.origin.y - 58, 85, 48);
                            }else{
                                self.rightVip.hidden = YES;
                            }
                            
                            NSString *imageName = [NSString stringWithFormat:@"%@.%@",tempdic[@"slogan"],@"png"];
                            self.rightImageView.hidden = NO;
                            self.rightImageView.image = [UIImage imageNamed:imageName];
                            self.rightImageView.frame = CGRectMake(RightB.frame.origin.x, CGRectGetMaxY(RightB.frame) + 20, 275, 100);
						}];
					}];
					
					
					break;
				}
			}
		}
		
		
	}

}

//判断大名子是否显示
-(void) dealSBShow:(int)usercount dataarray:(NSArray*)datadic sbbutton:(CloudButton*)btn
{
	BOOL hasshow = NO;
	NSString *usernumberstr = nil;
	for (int i = 0; i < usercount; i++)
	{
		NSDictionary* tempdic = [datadic objectAtIndex:i];
		usernumberstr = [tempdic objectForKey:@"number"];
		if([btn.number isEqualToString:usernumberstr])
		{
            if (btn == LeftB) {
                NSDictionary *dic = self.leftArray[0];
                NSString *imageName = [NSString stringWithFormat:@"%@.%@",dic[@"slogan"],@"png"];
                self.leftImageView.image = [UIImage imageNamed:imageName];
            }else if(btn == RightB){
                NSDictionary *dic = self.rightArray[0];
                NSString *imageName = [NSString stringWithFormat:@"%@.%@",dic[@"slogan"],@"png"];
                self.rightImageView.image = [UIImage imageNamed:imageName];

            }
			hasshow = YES;
			break;
		}
	}
	if (NO == hasshow)
	{
		btn.hidden = YES;
		btn.number = @"";
        if (btn == LeftB) {
//            self.leftImageView.hidden = YES;
            self.leftVip.hidden = YES;
//            [self.gifView stopGif];
        }else if(btn == RightB){
            self.rightImageView.hidden = YES;
            self.rightVip.hidden = YES;
//            [self.rightgGifView stopGif];
        }
	}
}

#pragma 球形云一涨一涨效果
- (void)buttonPressed:(UIButton *)btn
{
	[self POPFuc:btn];
}

-(void) AutoPOPFuc
{
	int randid = arc4random()%40;
	UIView *view = [_sphereView.tags objectAtIndex:randid];
	
	[self POPFuc:view];
}

-(void) POPFuc:(UIView*) view
{
	[_sphereView timerStop];
	
	[UIView animateWithDuration:0.3 animations:^{
		view.transform = CGAffineTransformMakeScale(2., 2.);
	} completion:^(BOOL finished) {
		[UIView animateWithDuration:0.3 animations:^{
			view.transform = CGAffineTransformMakeScale(1., 1.);
		} completion:^(BOOL finished) {
			[_sphereView timerStart];
			[self PerformAutoPOP];
		}];
	}];
}


-(void) CancelPerformAutoPOP
{
	[NSObject cancelPreviousPerformRequestsWithTarget:self];
}

-(void) PerformAutoPOP
{
	[self performSelector:@selector(AutoPOPFuc) withObject:nil afterDelay:1.0f];
}


- (void)dealloc
{
    self.cloud = nil;
    [window release];
    [super dealloc];
}



#pragma 请求服务器

- (void)requestDefaultArray
{
//	NSString* APIser = [NSString stringWithFormat:@"%@%@", @servURL,@"/default/100"];
//	
//	dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//		NSURL *url = [NSURL URLWithString:APIser];
//		NSString *zoneStr = [NSString stringWithContentsOfURL:url encoding:NSUTF8StringEncoding error:nil];
//		NSData *data = [zoneStr dataUsingEncoding:NSUTF8StringEncoding];
//		dispatch_async(dispatch_get_main_queue(), ^{
//			if (data) {
//				NSArray *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
//                self.defaultArray = [NSMutableArray arrayWithArray:dic];
//				//[[NSNotificationCenter defaultCenter]postNotificationName:@"WechatDidOAuthSucess" object:nil userInfo:dic];
//				[self initStarEffect:self.defaultArray];
////				[self initSphereEffect:dic];
//			}
//		});
//	});
//    ;
    self.defaultArray = [NSMutableArray arrayWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"User.plist" ofType:nil]];
    [self initStarEffect:self.defaultArray];
}



- (void)requestCurrentUser
{
	NSString* APIser = [NSString stringWithFormat:@"%@%@", @servURL,@"/currentUser"];
	NSString* groupUrl = [NSString stringWithFormat:@"%@%@", @servURL,@"/currentGroup"];
	dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
		NSURL *url = [NSURL URLWithString:APIser];
		NSString *zoneStr = [NSString stringWithContentsOfURL:url encoding:NSUTF8StringEncoding error:nil];
		NSData *data = [zoneStr dataUsingEncoding:NSUTF8StringEncoding];
        NSURL *group = [NSURL URLWithString:groupUrl];
        NSString *groupStr = [NSString stringWithContentsOfURL:group encoding:NSUTF8StringEncoding error:nil];
        NSData *groupData = [groupStr dataUsingEncoding:NSUTF8StringEncoding];
		dispatch_async(dispatch_get_main_queue(), ^{
            
			if (data.length > 0) {
                //[[NSNotificationCenter defaultCenter]postNotificationName:@"WechatDidOAuthSucess" object:nil userInfo:dic];
				NSArray *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
                [self initUserEffect:dic];
                 self.cloud.hidden = NO;
                _sphereView.hidden = YES;
                GroupName.hidden = YES;
                [_groupGifView stopGif];
                self.lastGroupName = @"";
                [self insertIntoBg:dic];
            }else{
               [self initUserEffect:@[]];
            }
            if (groupData.length > 0) {
                 NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:groupData options:NSJSONReadingMutableContainers error:nil];
                [self initSphereEffect:dic];
                self.cloud.hidden = YES;
//                [_gifView stopGif];
                [_rightgGifView stopGif];
                LeftB.hidden = YES;
                RightB.hidden = YES;
//                [_gifView stopGif];
//                [_rightgGifView stopGif];
                GroupName.hidden = NO;
                self.leftVip.hidden = YES;
//                self.leftImageView.hidden = YES;
                self.rightVip.hidden = YES;
                self.rightImageView.hidden = YES;
            }else{
                if (_sphereView) {
                    [_sphereView timerStop];
                }
                 GroupName.hidden = YES;
               self.lastGroupName = @"";
                _sphereView.hidden = YES;
                self.cloud.hidden = NO;
                [_groupBG stopGif];
            }
            
		});
	});
  
}
-(void)insertIntoBg:(NSArray *)arr
{
    for (int i = 0; i < arr.count; i++) {
        NSDictionary *dic = arr[i];
        if (![self containDic:dic]) {
            [self.defaultArray addObject:dic];
            if (self.defaultArray.count > 200) {
                [self.defaultArray removeObject:self.defaultArray.firstObject];
            }
            [self initStarEffect:self.defaultArray];
        }
        
    }
}
-(BOOL)containDic:(NSDictionary *)dic
{
    for (int i = 0; i < self.defaultArray.count; i++) {
        NSDictionary *defaultDic = self.defaultArray[i];
        if ([defaultDic[@"number"] isEqualToString:dic[@"number"]]) {
            return YES;
        }
    }
    return NO;
}
@end
