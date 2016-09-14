//
//  NSString.h
//  
//
//  Created by mac on 16/5/4.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

#ifndef NSString_h
#define NSString_h

#define SCREEN_WIDTH ([[UIScreen mainScreen] bounds].size.width)
#define SCREEN_HEIGHT ([[UIScreen mainScreen] bounds].size.height)

#define isiPhone5 (320==[[UIScreen mainScreen] bounds].size.width)
#define isiPhone6 (375==[[UIScreen mainScreen] bounds].size.width)
#define isiPhone6Plus (414==[[UIScreen mainScreen] bounds].size.width)


#pragma mark -- 布局
// 各栏高度
static CGFloat const layout_NB_height = 64;
static CGFloat const layout_TB_height = 40;
static CGFloat const layout_Status_Height = 20;

// width和height
#define s_v_width CGRectGetWidth(self.view.frame)
#define s_v_height CGRectGetHeight(self.view.frame)
#define s_cv_width CGRectGetWidth(self.contentView.frame)
#define s_cv_height CGRectGetHeight(self.contentView.frame)
#define s_width CGRectGetWidth(self.frame)
#define s_height CGRectGetHeight(self.frame)
#define bt_height CGRectGetWidth(self.frame)*6/47-5
#define bt_v_height CGRectGetWidth(self.view.frame)*6/47-5


#endif /* NSString_h */
