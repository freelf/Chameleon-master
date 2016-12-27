//
//  Utils.m
//  BigApple
//
//  Created by 沧浪之水 on 16/9/21.
//
//

#import "Utils.h"

@implementation Utils


//随机返回某个区间范围内的值
+ (float) randomBetween:(float)smallerNumber And:(float)largerNumber
{
	//设置精确的位数
	int precision = 100;
	//先取得他们之间的差值
	float subtraction = largerNumber - smallerNumber;
	//取绝对值
	subtraction = ABS(subtraction);
	//乘以精度的位数
	subtraction *= precision;
	//在差值间随机
	float randomNumber = arc4random() % ((int)subtraction+1);
	//随机的结果除以精度的位数
	randomNumber /= precision;
	//将随机的值加到较小的值上
	float result = MIN(smallerNumber, largerNumber) + randomNumber;
	//返回结果
	return result;
}


@end
