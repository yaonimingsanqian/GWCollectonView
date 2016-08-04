//
//  AppIcon.m
//  QCPhone
//
//  Created by shawn on 7/29/16.
//  Copyright © 2016 shawn. All rights reserved.
//

#import "AppIcon.h"
#import "AsyncImageView.h"
@implementation AppIcon
{
    AsyncImageView *icon;
    UILabel *appName;
}
-(instancetype)initWithFrame:(CGRect)frame iconurl:(NSString*)url name:(NSString*)name isSmall:(BOOL)isSmall
{
    self = [super initWithFrame:frame];
    if(self){
        if(isSmall){
            icon = [[AsyncImageView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        }else{
            icon = [[AsyncImageView alloc]initWithFrame:CGRectMake(5, 0, frame.size.width-10, frame.size.height-10)];
            appName = [[UILabel alloc]initWithFrame:CGRectMake(0, frame.size.height-4, frame.size.width, 10)];
            [appName setBackgroundColor:[UIColor clearColor]];
            appName.textAlignment = NSTextAlignmentCenter;
            [appName setTextColor:[UIColor whiteColor]];
            [appName setText:name];
            [appName setFont:[UIFont systemFontOfSize:10]];
            [self addSubview:appName];
        }
       // [icon setBackgroundColor:[UIColor redColor]];
        [self setBackgroundColor:[UIColor clearColor]];
        icon.showActivityIndicator = NO;
        icon.imageURL = [NSURL URLWithString:url];
        [self addSubview:icon];
        
        
    }
    return self;
}
-(void)setIconFrame:(CGRect)frame
{
    icon.frame = frame;
}
-(void)setAppNameColor:(UIColor*)color
{
    [appName setTextColor:color];
}
@end
