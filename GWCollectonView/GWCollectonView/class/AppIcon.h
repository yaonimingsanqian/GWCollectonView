//
//  AppIcon.h
//  QCPhone
//
//  Created by shawn on 7/29/16.
//  Copyright © 2016 shawn. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppIcon : UIView
-(instancetype)initWithFrame:(CGRect)frame iconurl:(NSString*)url name:(NSString*)name isSmall:(BOOL)isSmall;
//-(void)setIconFrame:(CGRect)frame;
-(void)setAppNameColor:(UIColor*)color;
@property(nonatomic,assign) int index;
@end
