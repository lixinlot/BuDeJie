//
//  FrameHeader.h
//  BuDeJieDemo
//
//  Created by jimmy on 2018/4/18.
//  Copyright © 2018年 jimmy. All rights reserved.
//

#ifndef FrameHeader_h
#define FrameHeader_h


#define  screenWidth  [UIScreen mainScreen].bounds.size.width

#define LXLog(...) NSLog(__VA_ARGS__)

#define LXFunc  NSLog(@"%s",__func__)

#define LXColor(r,g,b)  [UIColor colorWithRed:(r)/256.0 green:(g)/256.0 blue:(b)/256.0 alpha:1]

/***********屏幕适配*************/
#define screenWidth [UIScreen mainScreen].bounds.size.width
#define screenHeight [UIScreen mainScreen].bounds.size.height
#define iphone6P (screenHeight == 736)
#define iphone6 (screenHeight == 667)
#define iphone5 (screenHeight == 568)
#define iphone4 (screenHeight == 480)
/***********屏幕适配*************/

#define  Ad_url  @"http://mobads.baidu.com/cpro/ui/mads.php"

#define code2  @"phcqnauGuHYkFMRquANhmgN_IauBThfqmgKsUARhIWdGULPxnz3vndtkQW08nau_I1Y1P1Rhmhwz5Hb8nBuL5HDknWRhTA_qmvqVQhGGUhI_py4MQhF1TvChmgKY5H6hmyPW5RFRHzuET1dGULnhuAN85HchUy7s5HDhIywGujY3P1n3mWb1PvDLnvF-Pyf4mHR4nyRvmWPBmhwBPjcLPyfsPHT3uWm4FMPLpHYkFh7sTA-b5yRzPj6sPvRdFhPdTWYsFMKzuykEmyfqnauGuAu95Rnsnbfknbm1QHnkwW6VPjujnBdKfWD1QHnsnbRsnHwKfYwAwiu9mLfqHbD_H70hTv6qnHn1PauVmynqnjclnj0lnj0lnj0lnj0lnj0hThYqniuVujYkFhkC5HRvnB3dFh7spyfqnW0srj64nBu9TjYsFMub5HDhTZFEujdzTLK_mgPCFMP85Rnsnbfknbm1QHnkwW6VPjujnBdKfWD1QHnsnbRsnHwKfYwAwiuBnHfdnjD4rjnvPWYkFh7sTZu-TWY1QW68nBuWUHYdnHchIAYqPHDzFhqsmyPGIZbqniuYThuYTjd1uAVxnz3vnzu9IjYzFh6qP1RsFMws5y-fpAq8uHT_nBuYmycqnau1IjYkPjRsnHb3n1mvnHDkQWD4niuVmybqniu1uy3qwD-HQDFKHakHHNn_HR7fQ7uDQ7PcHzkHiR3_RYqNQD7jfzkPiRn_wdKHQDP5HikPfRb_fNc_NbwPQDdRHzkDiNchTvwW5HnvPj0zQWndnHRvnBsdPWb4ri3kPW0kPHmhmLnqPH6LP1ndm1-WPyDvnHKBrAw9nju9PHIhmH9WmH6zrjRhTv7_5iu85HDhTvd15HDhTLTqP1RsFh4ETjYYPW0sPzuVuyYqn1mYnjc8nWbvrjTdQjRvrHb4QWDvnjDdPBuk5yRzPj6sPvRdgvPsTBu_my4bTvP9TARqnam"

#define Command_url @"http://api.budejie.com/api/api_open.php?a=tag_recommend&action=sub&c=topic"


//#define Essence_refreshUrl @"http://api.budejie.com/api/api_open.php?a=newlist&c=data"  // 刷新
#define Essence_refreshUrl(type) [NSString stringWithFormat:@"http://api.budejie.com/api/api_open.php?a=newlist&c=data&type=%@", type]  // 刷新

#define Essence_moreUrl(maxtime) [NSString stringWithFormat:@"http://api.budejie.com/api/api_open.php?a=newlist&c=data&maxtime=%@", maxtime]  // 加载更多









#endif /* FrameHeader_h */
