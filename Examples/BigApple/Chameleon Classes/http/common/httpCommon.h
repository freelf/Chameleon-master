

//#define http_test_url @"http://s1.server.app.laipao8.com" //@"http://192.168.1.188:8001"  //@"http://t2.app.test.xiaoguo822.com"


//http://s1.server.app.laipao8.com


#define http_test_url  @"http://t2.app.test.laipao8.cn"


//分享
#define http_share_url @"http://s1.share.app.laipao8.com"


#define PACKAGE_HEAD  24

//#############################  登录模块  ##################################################
static short T_SYSTEM                          = 0;//type大指令号
//                       ~~~~~~~~~~~~~~~~~~
// 上行
static short C_USER_CREATE                     = 0x0001; // 创建帐号
static short C_USER_LOGIN                      = 0x0002; // 帐号登录
static short C_SEND_MSG                        = 0x0003; // 发送短息
static short C_USER_MOBILEREG                  = 0x0004; // 用户手机注册
static short C_USER_FORGET                     = 0x0005; // 忘记密码
static short C_USER_BINDMOBILE                 = 0x0006; // 微信绑定手机号
static short C_USER_WEIXINLOGIN                = 0x0007; // 微信登陆
static short C_USER_UPDATE                     = 0x0008; // 完善资料
static short C_USER_UPDATEPWD                  = 0x0009; // 修改密码
static short C_USER_CHANGEMOBILE               = 0x0010; // 更换手机号

static short C_SYSTEM_ADLIST                   = 0x001a; // 获取系统广告
static short C_USER_MAKENICKNAME               = 0x001b; // 昵称
static short C_SYSTEM_GETNOTICE                = 0x001c; // 获取公告

// 下行
static short S_USER_LOGIN                      = 0x0092; //创建和登录都此反馈
static short S_SEND_MSG                        = 0x0093;
static short S_USER_MOBILEREG                  = 0x0094;
static short S_USER_FORGET                     = 0x0095;
static short S_USER_BINDMOBILE                 = 0x0096;
static short S_USER_WEIXINLOGIN                = 0x0097;
static short S_USER_UPDATE                     = 0x0098;
static short S_USER_UPDATEPWD                  = 0x0099;  // 修改密码
static short S_USER_CHANGEMOBILE               = 0x0100; // 更换手机号

static short S_SYSTEM_ADLIST                   = 0x010a; //  获取系统广告
static short S_USER_MAKENICKNAME               = 0x091b; //  昵称
static short S_SYSTEM_GETNOTICE                = 0x091c; // 获取公告
//##########################################################################################

//#############################  run模块  ##################################################
static short MESSAGE_TYPE_RUNNER 				= 1;//type大指令号
//                       ~~~~~~~~~~~~~~~~~~
//		小指令号
// 上行
static short C_RUNNER_HEART                     = 0x0001;// 跑步心跳
static short C_CREATE_RUN                       = 0x0002;// 创建
static short C_END_RUN                          = 0x0004;// 结束
static short C_RUNNER_REPORT                    = 0x0003;// 结算
static short C_RUNNER_AREA                      = 0x0005;// 周围的跑者
static short C_RUNNER_SHOWRP                    = 0x0006;// 查看数据
static short C_REPORT_SHOE                      = 0x0007;// 上传结算跑鞋名称
static short C_GET_SHOESDATA                    = 0x0008;// 获取跑鞋数据
static short C_UPDATE_SHOSEDATA                 = 0x0009; // 上传跑鞋数据
static short C_CREATE_ROOM                      = 0x000a;// 创建队伍
static short C_GET_ROOM                         = 0x000b;// 进入队伍界面请求
static short C_SHOW_ROOM                        = 0x000c;// 查看队伍
static short C_INVITE_RUNNER                    = 0x000d;// 邀请跑者
static short C_INVITE_LIST                      = 0x000e;// 邀请列表
static short C_INVITE_COMMIT                    = 0x000f;// 邀请反馈
static short C_ROOM_EXIT                        = 0x0010;// 退出队伍
static short C_ROOM_KICK                        = 0x0011;// 踢人
static short C_ROOM_RUNNERLIST                  = 0x0012;// 跑者列表
static short C_ROOM_JOIN                        = 0x0013;// 加入队伍
static short C_ROOM_CONFIG                      = 0x0014;// 队伍设置
static short C_ROOM_RUN                         = 0x0015;// 组队跑
static short C_ROOM_RUNHEART                    = 0x0016;// 队伍心跳

static short C_ROOM_SEARCH                      = 0x0019;// 搜索队伍

static short C_ROOM_SHOWOVER                    = 0x0017;// 查看结算
static short C_ROOM_RUNNERSET                   = 0x0018;// 设置其他玩家
static short C_ROOM_RUNNER_HIDESHOW             = 0x001a;// 玩家设置gps状态
static short C_ROOM_INVITELIST                  = 0x001b;// 队伍的邀请人员列表
static short C_RUNNER_REPORT_DATA				= 0x001c;// 用户查看单条详细跑步数据
static short C_RUNNER_DEL_REPORT				= 0x001d;// 删除记录
static short C_USER_MARATHON				    = 0x001f;// 查看绑定马拉松信息

// 下行
static short S_RUNNER_HEART                     = 0x0091;
static short S_CREATE_RUN                       = 0x0092;
static short S_RUNNER_REPORT                    = 0x0093;
static short S_END_RUN                          = 0x0094;
static short S_RUNNER_AREA                      = 0x0095;
static short S_RUNNER_SHOWRP                    = 0x0096;
static short S_REPORT_SHOE                      = 0x0097;
static short S_GET_SHOESDATA                    = 0x0098;
static short S_UPDATE_SHOSEDATA                 = 0x0099;
static short S_SHOW_ROOM                        = 0x009a;
static short S_GET_ROOM                         = 0x009b;
static short S_ROOM_NO                          = 0x009c;
static short S_INVITE_RUNNER                    = 0x009d;
static short S_INVITE_LIST                      = 0x009e;
static short S_INVITE_COMMIT                    = 0x009f;
static short S_ROOM_EXIT                        = 0x0910;
static short S_ROOM_KICK                        = 0x0911;
static short S_ROOM_RUNNERLIST                  = 0x0912;
static short S_ROOM_JOIN                        = 0x0913;
static short S_ROOM_CONFIG                      = 0x0914;
static short S_ROOM_RUN							= 0x0915;
static short S_ROOM_RUNHEART					= 0x0916;

static short S_ROOM_SEARCH					    = 0x0919;

static short S_ROOM_SHOWOVER                    = 0x0917;
static short S_ROOM_RUNNERSET                   = 0x0918;
static short S_ROOM_RUNNER_HIDESHOW             = 0x091a;
static short S_ROOM_INVITELIST                  = 0x091b;
static short S_RUNNER_REPORT_DATA				= 0x091c;
static short S_RUNNER_DEL_REPORT				= 0x091d;
static short S_USER_MARATHON				    = 0x091f; //查看绑定马拉松信息
static short S_ROOM_TIP_KICK					= 0x099f;// 不在队伍的提示


//##########################################################################################

//#############################  bbs模块  ##################################################
static short T_SYSTEM1                         = 2;//type大指令号
//                       ~~~~~~~~~~~~~~~~~~
/////// 上行
static short C_BBS_LIST                        = 0x0001;// 列出所有置顶信息
static short C_BBS_SEND                        = 0x0002;// 发送新信息
static short C_BBS_SHOW                        = 0x0003;// 查看信息（ 显示评论 转发 赞）
static short C_BBS_SENDCOMMENT                 = 0x0004;// 发送评论
static short C_BBS_SENDRELAY                   = 0x0005;// 转发
static short C_BBS_ZAN                         = 0x0006;// 点赞
static short C_BBS_MORE_COMMENT                = 0x0007;
static short C_BBS_MORE_RELAY                  = 0x0008;
static short C_BBS_LIST_ZAN                    = 0x0009;
static short C_BBS_SHOWSHARP                   = 0x000b;// 查看讨论
static short C_BBS_USER_ATTENTION              = 0x000c;// 添加关注
static short C_BBS_USER_CANCEL_ATTENTION       = 0x000d;// 取消关注
static short C_BBS_USER_BLACK                  = 0x000e;// 添加黑名单
static short C_BBS_USER_CANCEL_BLACK           = 0x000f;// 取消黑名单
static short C_BBS_COLLECTIONS                 = 0x0010;// 收藏处理
static short C_BBS_SEARCH                      = 0x0011;// 搜索
static short C_BBS_SENDCHAT                    = 0x0012;// 发送私信
static short C_BBS_CHATCONTENT                 = 0x0014;// 看私信
static short C_BBS_CHATLIST 					= 0x0015;// 私信名单
static short C_BBS_SHARPLIST 					= 0x0018;//请求#列表
static short C_BBS_DEL							= 0x0019;// 删除微博
static short C_BBS_DEL_COMMENT					= 0x001a;// 删除评论

static short C_BBS_SHARP_RELATION				= 0x001b;// 关注/取消话题
static short C_BBS_HOT							= 0x001c;//请求#列表
static short C_BBS_MAIN							= 0x001d;// 首页
static short C_BBS_MESSAGES						= 0x001e;// 资讯列表
static short C_BBS_MESSAGE_CONTENT				= 0x001f;// 资讯显示
static short C_BBS_HOTSHARP				        = 0x0020;// 热门话题

static short C_BBS_NEWMAIN                     = 0x0021;// 新首页
static short C_BBS_FEEDBACK                    = 0x0022;// 用户反馈
static short C_BBS_TIPOFFS                    = 0x0023;// 圈子、评论举报
//static short C_BBS_ADLIST                    = 0x0024;// 获取所有广告
static short C_BBS_ACTIVITYLIST                    = 0x0025;//  获取活动列表


/////// 下行
static short S_BBS_LIST                        = 0x0091;
static short S_BBS_SEND                        = 0x0092;
static short S_BBS_SHOW                        = 0x0093;
static short S_BBS_SENDCOMMENT                 = 0x0094;
static short S_BBS_SENDRELAY                   = 0x0095;
static short S_BBS_ZAN                         = 0x0096;
static short S_BBS_MORE_COMMENT                = 0x0097;
static short S_BBS_MORE_RELAY                  = 0x0098;
static short S_BBS_LIST_ZAN                    = 0x0099;
static short S_BBS_SHOWSHARP                   = 0x009b;
static short S_BBS_USER_ATTENTION              = 0x009c;
static short S_BBS_USER_CANCEL_ATTENTION       = 0x009d;
static short S_BBS_USER_BLACK                  = 0x009e; // 添加黑名单
static short S_BBS_USER_CANCEL_BLACK           = 0x009f; // 取消黑名单
static short S_BBS_COLLECTIONS                 = 0x0910;// 收藏处理
static short S_BBS_SEARCH                      = 0x0911;// 搜索
static short S_BBS_SENDCHAT                    = 0x0912;
static short S_BBS_CHATCONTENT                 = 0x0914;
static short S_BBS_CHATLIST 					= 0x0915;// 私信名单
static short S_BBS_SHARPLIST 					= 0x0918;
static short S_BBS_DEL							= 0x0919;
static short S_BBS_DEL_COMMENT					= 0x091a;

static short S_BBS_SHARP_RELATION				= 0x091b;
static short S_BBS_HOT							= 0x091c;
static short S_BBS_MAIN							= 0x091d;
static short S_BBS_MESSAGES						= 0x091e;
static short S_BBS_MESSAGE_CONTENT				= 0x091f;
static short S_BBS_HOTSHARP				        = 0x0920;

static short S_BBS_NEWMAIN				        = 0x0921;//新首页
static short S_BBS_FEEDBACK				        = 0x0922;
static short S_BBS_TIPOFFS				        = 0x0923;
//static short S_BBS_ADLIST				        = 0x0924;
static short S_BBS_ACTIVITYLIST				        = 0x0925;


//##########################################################################################

//#############################  MY模块  ##################################################
static short MESSAGE_TYPE_MY                    = 3;//type大指令号
//                       ~~~~~~~~~~~~~~~~~~
//		小指令号
// 上行
// 上行
static short C_BBS_COLLECTIONSLIST = 0x0001;// 收藏列表
static short C_BBS_OWNMAIN = 0x0002;// 我的发表
static short C_BBS_SHOWUSER = 0x0003;// 查看帐号
static short C_BBS_ATTENTION_LIST = 0x0004; // 所有关注者
static short C_BBS_FANS_LIST = 0x0005;// 粉丝列表
static short C_BBS_CHANGE_MARKNAME = 0x0006;// 修改备注名
static short C_USER_MAKENICK = 0x0007;// 昵称
static short C_USER_IMGUPDATE = 0x0008;// 更新头像图片
static short C_USER_ATME = 0x0009; // @我的
static short C_USER_CONTENTME = 0x000a; // 评论我的
static short C_USER_ZANME = 0x000b; // 赞我的
static short C_USER_CHANGE_SEX = 0x000d; // 改变性别
static short C_USER_CHANGE_HEIGHT = 0x000e; // 改变身高
static short C_USER_CHANGE_WEIGH = 0x000f;// 改变体重
static short C_USER_BESTSHOW = 0x000c;// 最佳记录显示

static short C_USER_SHOWTASK     = 0x0010; //显示任务列表
static short C_USER_BROWSE       = 0x0011; //动态浏览次数
static short C_USER_SHOWBADGE    = 0x0012;//显示已获得的勋章列表
static short C_USER_SHOWMESSAGE  = 0x0013;//获取用户消息列表
static short C_USER_PBUPDATE     = 0x0014;//用户pb上传
static short C_USER_CHANGE_BIRTH = 0x0015;//改变生日
static short C_USER_CHANGE_ADDRESS = 0x0016;//改变生日
static short C_USER_ALERT                   = 0x0017; // 红点计数
// 下行
static short S_BBS_COLLECTIONSLIST = 0x0091;
static short S_BBS_OWNMAIN = 0x0092;
static short S_BBS_SHOWUSER = 0x0093;
static short S_BBS_ATTENTION_LIST = 0x0094;
static short S_BBS_FANS_LIST = 0x0095;
static short S_BBS_CHANGE_MARKNAME = 0x0096;
static short S_USER_MAKENICK = 0x0097;
static short S_USER_IMGUPDATE = 0x0098;
static short S_USER_ATME = 0x0099;
static short S_USER_CONTENTME = 0x009a;
static short S_USER_ZANME = 0x009b;
static short S_USER_CHANGE_SEX = 0x009d;
static short S_USER_CHANGE_HEIGHT = 0x009e;
static short S_USER_CHANGE_WEIGH = 0x009f;
static short S_USER_BESTSHOW = 0x009c;

static short S_USER_SHOWTASK         = 0x0910;
static short S_USER_BROWSE           = 0x0911;
static short S_USER_SHOWBADGE        = 0x0912;
static short S_USER_SHOWMESSAGE      = 0x0913;//获取用户消息列表
static short S_USER_PBUPDATE         = 0x0914;
static short S_USER_CHANGE_BIRTH     = 0x0915;
static short S_USER_CHANGE_ADDRESS     = 0x0916;
static short S_USER_ALERT                   = 0x0917; //

//#############################  share模块  ################################################
static short T_SHARE                         = 99;//type大指令号
//上行
static short C_DATA_REPORT = 0x0001;//上传数据

//下行
static short S_DATA_REPORT     = 0x0091; //上传数据



//##########################################################################################
// 表情的最大行数
#define SDEmotionMaxRows 3
// 表情的最大列数
#define SDEmotionMaxCols 7
// 每页最多显示多少个表情
#define SDEmotionMaxCountPerPage (SDEmotionMaxRows * SDEmotionMaxCols - 1)



/**
* UI的commonId声明, key 对应的是类，而不是协议，你一个类没必要写两个key。。。且如果两个人冲突了，这个值可以随时改
* 首先是通用显示处理类：MainTabBarController
*/
static long UI_CMDID_MAIN						= 0;
/**登录注册*/
// 登录/注册
static long UI_CMDID_LOGIN						= 900;
static long UI_CMDID_REGIST						= 901;
static long UI_CMDID_UPDATE						= 902;
static long UI_CMDID_BINDMOBILE					= 903;
static long UI_CMDID_FORGETPWD					= 904;
static long UI_CMDID_LOGINUPLODAIMAGE			= 905;
/**
* 微博相关界面
*/

// 微博相关
static long UI_CMDID_WEIBOLIST					= 1;

// 微博发送
static long UI_CMDID_WEIBOSEND					= 2;

// 微博详情
static long UI_CMDID_WEIBODETAIL				= 3;
// 关注者
static long UI_CMDID_ATTENTION					= 4;
// 话题
static long UI_CMDID_TREND						= 5;
// 热门推荐
static long UI_CMDID_HOT						= 6;
// 搜索
static long UI_CMDID_SEARCHSYTHESIZE			= 7;
// 别人名片页
static long UI_CMDID_OTHERCARDINFO				= 8;
// 微博点赞
static long UI_CMDID_WEIBOUTILS					= 9;
// 微博赞列表
static long UI_CMDID_WEIBOZANLIST				= 10;
// 搜索用户
static long UI_CMDID_SEARCHUSER				    = 11;
// 搜索话题
static long UI_CMDID_SEARCHSYTREND				= 12;

/*
 * 然后是跑步相关界面
 */
// 跑步主界面
static long UI_CMDID_RUNMAIN					= 20;
// 互动跑界面的用户列表
static long UI_CMDID_RUNROLELIST				= 21;
// 跑步准备界面
static long UI_CMDID_RUNREADY                   = 22;
// 跑步进行中界面
static long UI_CMDID_RUNNING                    = 23;
// 跑步数据管理类
static long UI_CMDID_RUNDATAMANAGERE			= 24;
// 组队跑入口类
static long UI_CMDID_ROOMRUNMAIN				= 25;
// 组队跑队伍列表页
static long UI_CMDID_ROOMRUNMAINLIST			= 26;
// 组队跑创建页面
static long UI_CMDID_ROOMRUNCREATE				= 27;
// 组队跑队伍页面
static long UI_CMDID_ROOMRUNROOM				= 28;
// 组队跑邀请
static long UI_CMDID_ROOMINVITE				    = 29;
// 搜索队伍
static long UI_CMDID_SEARCHROOM				    = 30;
// 组队跑邀请列表
static long UI_CMDID_ROOMINVITELIST			    = 31;
// 组队跑设置页面
static long UI_CMDID_ROOMSETTING				= 32;
// 组队跑结算
static long UI_CMDID_SHOWOVER				    = 33;
// 组队跑用户列表
static long UI_CMDID_ROOMRUNROLELIST			= 34;

//跑步设置
static long UI_CMDID_RUNSETTING			        = 35;
//跑鞋上传
static long UI_CMDID_RUNSHOEUPDATE			    = 36;
//pb展示
static long UI_CMDID_RUNPBDISPLAY			    = 37;
//跑步结束自动分享
static long UI_CMDID_RUNENDSHARE			    = 38;

/*
 * 我的模块
 */
// 跑者圈
static long UI_CMDID_RUNROUND					= 40;
// 我的收藏
static long UI_CMDID_MYCOLLECTION				= 41;
// 我的界面
static long UI_CMDID_MYSELFDATA					= 42;
// 粉丝
static long UI_CMDID_FANSLIST					= 43;
// 关注
static long UI_CMDID_ATTENTIONLIST				= 44;
// @我的
static long UI_CMDID_ATMELIST					= 45;
// 评论我的
static long UI_CMDID_COMMENTMELIST				= 46;
// 赞我的
static long UI_CMDID_ZANMELIST					= 47;
// 跑步记录
static long UI_CMDID_RUNRECORD					= 48;
// 修改绑定手机号
static long UI_CMDID_CHANGEBINDPHONENUM			= 49;
// 修改密码
static long UI_CMDID_CHANGEPWD					= 50;

// 修改我的资料
static long UI_CMDID_EDITMEMYDETE				= 51;
// 最佳成绩
static long UI_CMDID_BESTSHOW					= 52;
//我得页面跑着圈
static long UI_CMDID_MERUNGROUP					= 53;
//其他人页面跑着圈
static long UI_CMDID_OTHERRUNGROUP				= 54;
// 我的界面
static long UI_CMDID_OTHERDATA					= 55;

//用户反馈
static long UI_CMDID_FEEDBACK                   = 56;
//微信分享
static long UI_CMDID_WXSHARE                   = 57;



/**
 *  发现模块
 */
// 资讯
static long UI_CMDID_IMFORMAITON					= 71;
//首页
static long UI_CMDID_DISCOVER						= 72;
//圈子话题
static long UI_CMDID_TOPIC							= 73;
//话题详情页
static long UI_CMDID_TOPICDETAIL					= 74;
//搜索所有关注者
static long UI_CMDID_SEARCHMENTION					= 75;

//新首页
static long UI_CMDID_NEWDISCOVER					= 110;
//首页活动
static long UI_CMDID_ACTIVITY					= 111;

/**
 *  生涯模块
 */



static long UI_CMDID_BADGE							= 90;
//消息列表
static long UI_CMDID_MESSAGELIST					= 91;
//任务列表
static long UI_CMDID_SHOWTASK						= 92;
//生涯首页
static long UI_CMDID_RUNLIFE					    = 93;


//启动广告
static long UI_CMDID_ADLIST					        = 200;




