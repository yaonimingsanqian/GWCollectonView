//
//  CollectionView.h
//  QCPhone
//
//  Created by shawn on 7/29/16.
//  Copyright © 2016 shawn. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ShowBigClick)();
typedef void(^AppClick)(int idex);
@interface CollectionView : UIView<UIScrollViewDelegate>
-(instancetype)initWithFrame:(CGRect)frame apps:(NSArray*)urls names:(NSArray*)names;
-(void)showBig;
-(void)showSmall;
-(void)setShowBigClick:(ShowBigClick)showBigClick;
-(void)setAppClick:(AppClick)appClick;
@end
