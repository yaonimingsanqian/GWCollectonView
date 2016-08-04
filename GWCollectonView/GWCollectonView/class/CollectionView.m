//
//  CollectionView.m
//  QCPhone
//
//  Created by shawn on 7/29/16.
//  Copyright © 2016 shawn. All rights reserved.
//

#import "CollectionView.h"
#import "AppIcon.h"
#import "GWTool.h"
@implementation CollectionView
{
    UIScrollView *_scroll;
    UIPageControl *_control;
    int _iconHeight;
    int _iconWidth;
    NSArray *apps;
    NSArray *appNames;
    CGRect originFrame;
    ShowBigClick showBigClick;
    AppClick appClick;
    BOOL isBig;
}
-(instancetype)initWithFrame:(CGRect)frame apps:(NSArray*)urls names:(NSArray*)names
{
    self = [super initWithFrame:frame];
    if(self){
      
        originFrame = frame;
        apps = urls;
        appNames = names;
        
        self.layer.cornerRadius = 8;
        [GWTool execAfter:0.1 cb:^{
            [self createScrollView:frame];
            [self small];
        }];
        
        isBig = NO;
        [self setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.5]];
    }
    return self;
}
-(void)setShowBigClick:(ShowBigClick)showBigC
{
    showBigClick = showBigC;
}
-(void)setAppClick:(AppClick)appc
{
    appClick = appc;
}
#pragma mark 还原小图标
-(void)small
{
    _iconHeight = 20;
    _iconWidth = 20;
    float xOff = (self.frame.size.width-2*_iconHeight)/3.f;
    float yOff = (self.frame.size.height-2*_iconHeight)/3.f;
    for (int i = 0; i != [apps count]; i++)
    {
        if(i ==4)
        {
            break;
        }
        AppIcon *icon = [[AppIcon alloc]initWithFrame:CGRectMake((i%2+1)*xOff+(i%2)*_iconWidth,(i/2+1)*yOff+(i/2)*_iconHeight,_iconWidth,_iconHeight) iconurl:[apps objectAtIndex:i] name:@"" isSmall:YES];
        [_scroll addSubview:icon];
        
    }

}
#pragma mark 创建_scroll
-(void)createScrollView:(CGRect)frame
{
    
    _scroll = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
    _scroll.pagingEnabled = YES;
    if([apps count] <= 9){
        _scroll.contentSize = CGSizeMake(frame.size.width, frame.size.height);
    }else{
        if(isBig){
            if([apps count]%9 == 0){
                _scroll.contentSize = CGSizeMake(frame.size.width*([apps count]/9), frame.size.height);
            }else{
                _scroll.contentSize = CGSizeMake(frame.size.width*([apps count]/9+1), frame.size.height);
            };
          
        }else{
            _scroll.contentSize = CGSizeMake(frame.size.width, frame.size.height);
            _scroll.pagingEnabled = NO;
        }
        
    
    }
    _scroll.delegate = self;
    [_scroll setShowsVerticalScrollIndicator:NO];
    [_scroll setShowsHorizontalScrollIndicator:NO];
    [_scroll setBackgroundColor:[UIColor clearColor]];
    [_scroll addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap:)]];
    [self addSubview:_scroll];
}
#pragma mark 变大
-(void)showBig
{
    if(isBig){
        return;
    }
    isBig = YES;
    [_scroll removeFromSuperview];
    [self createScrollView:CGRectMake(0, 0, [GWTool getScreenWidth]*0.8, [GWTool getScreenWidth]*0.8)];
    
    [UIView animateWithDuration:0.3 animations:^{
        if([apps count] >9){
            self.frame = CGRectMake([GWTool getScreenWidth]*0.1, [GWTool getScreenHeight]/2.f-([GWTool getScreenWidth]*0.8+20)/2.f, [GWTool getScreenWidth]*0.8, [GWTool getScreenWidth]*0.8+20);
        }else{
            self.frame = CGRectMake([GWTool getScreenWidth]*0.1, [GWTool getScreenHeight]/2.f-([GWTool getScreenWidth]*0.8)/2.f, [GWTool getScreenWidth]*0.8, [GWTool getScreenWidth]*0.8);
        }
    } completion:^(BOOL finished) {
        
        if([apps count] >9){
            self.frame = CGRectMake([GWTool getScreenWidth]*0.1, [GWTool getScreenHeight]/2.f-([GWTool getScreenWidth]*0.8+20)/2.f, [GWTool getScreenWidth]*0.8, [GWTool getScreenWidth]*0.8+20);
        }else{
            self.frame = CGRectMake([GWTool getScreenWidth]*0.1, [GWTool getScreenHeight]/2.f-([GWTool getScreenWidth]*0.8+20)/2.f, [GWTool getScreenWidth]*0.8, [GWTool getScreenWidth]*0.8);
        }
        
        
        float iconH = 70;
        float iconW = 70;
        if([apps count] <= 9){
            float xOff = ([GWTool getScreenWidth]*0.8-3*iconW)/4.f;
            float yOff = ([GWTool getScreenWidth]*0.8-3*iconH)/4.f;
            for (int i = 0; i != [apps count]; i++)
            {
                AppIcon *icon = [[AppIcon alloc]initWithFrame:CGRectMake((i%3+1)*xOff+(i%3)*iconW,(i/3+1)*yOff+(i/3)*iconH,iconW,iconH) iconurl:[apps objectAtIndex:i] name:[appNames objectAtIndex:i] isSmall:NO];
                [_scroll addSubview:icon];
                icon.tag = i+10010;
                [icon addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(appClick:)]];
            }
            
        }else{
            float xOff = ([GWTool getScreenWidth]*0.8-3*iconW)/4.f;
            float yOff = ([GWTool getScreenWidth]*0.8-3*iconH)/4.f;
            for (int i = 0; i != [apps count]; i++)
            {
                int tmp = i;
                if(tmp >= 9){
                    tmp = tmp%9;
                }
                
                AppIcon *icon = [[AppIcon alloc]initWithFrame:CGRectMake((tmp%3+1)*xOff+(tmp%3)*iconW+(i/9)*_scroll.frame.size.width,(tmp/3+1)*yOff+(tmp/3)*iconH,iconW,iconH) iconurl:[apps objectAtIndex:i] name:[appNames objectAtIndex:i]  isSmall:NO];
                icon.index = i;
                [_scroll addSubview:icon];
               
                [icon addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(appClick:)]];
            }
              [self createPageControl];
        }
        
        
    }];
}
-(void)showSmall
{
    if(!isBig){
        return;
    }
    [_control removeFromSuperview];
    isBig = NO;
    [_scroll removeFromSuperview];
    [self createScrollView:originFrame];
    
    [UIView animateWithDuration:0.3 animations:^{
        self.frame = originFrame;
    } completion:^(BOOL finished) {
        
        self.frame = originFrame;
       
        [self small];
    }];
}
#pragma mark _scroll 点击事件
-(void)tap:(UIGestureRecognizer*)tap
{
    NSLog(@"%@",@"点击事件");
    showBigClick();
    
}
#pragma mark app点击
-(void)appClick:(UIGestureRecognizer*)tap
{
    AppIcon *icon = (AppIcon*)tap.view;
    appClick(icon.index);
}
#pragma mark 创建分页控件
-(void)createPageControl
{
    UIPageControl *pageControl=[[UIPageControl alloc]init];
    [pageControl setBackgroundColor:[UIColor clearColor]];
    pageControl.frame=CGRectMake(0, self.frame.size.width-10, self.frame.size.width, 20);
    //pageControl.center=CGPointMake(0,[GWTool getScreenWidth]*0.8);
    if([apps count]%9 == 0){
        pageControl.numberOfPages = [apps count]/9;
    }else{
        pageControl.numberOfPages = [apps count]/9+1;
    };
    pageControl.currentPageIndicatorTintColor=[UIColor whiteColor];
    pageControl.pageIndicatorTintColor=[UIColor grayColor];
    [pageControl addTarget:self action:@selector(pageChange) forControlEvents:UIControlEventValueChanged];
    [self addSubview:pageControl];
    _control=pageControl;
    
}
-(void)pageChange{
    int page=(int)_control.currentPage;
    CGFloat offSetX=page*_scroll.frame.size.width;
    [UIView beginAnimations:nil context:nil];
    _scroll.contentOffset=CGPointMake(offSetX, 0);
    [UIView commitAnimations];
    
}
//滚动代理  scroll减速完毕调用
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    int pageNo= scrollView.contentOffset.x/scrollView.frame.size.width;
    _control.currentPage=pageNo;
}
@end
