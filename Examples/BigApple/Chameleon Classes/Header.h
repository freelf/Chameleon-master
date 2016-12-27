//
//  Header.h
//  BigApple
//
//  Created by 沧浪之水 on 16/9/21.
//
//

#ifndef Header_h
#define Header_h

#define servURL "http://192.168.1.44:8080/marathon"


/*

user参数说明:
userName 姓名
number 赛号
teamName 比赛名
cardCode 证件号码
sex 性别
sz 服装尺码
rqCode 二维码号

resp参数说明:
code 标识码
result 说明

接口说明:取默认100条数据
接口路径:/default/100
参数:无
返回值：user集合

接口说明:扫码接口
接口路径:/scan
参数:比赛号
返回值：resp (0 成功 1 队列已满 2 没有查询到数据)

接口说明:获取队列中的人员信息
接口路径:/currentUser
参数:无
返回值：user 如果没有 则返回空
 
 */
#endif /* Header_h */

