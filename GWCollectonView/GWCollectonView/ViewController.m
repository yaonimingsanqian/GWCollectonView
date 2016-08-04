//
//  ViewController.m
//  GWCollectonView
//
//  Created by shawn on 8/4/16.
//  Copyright © 2016 shawn. All rights reserved.
//

#import "ViewController.h"
#import "CollectionView.h"
@interface ViewController ()

@end

@implementation ViewController
{
    CollectionView *collection;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self.view setBackgroundColor:[UIColor yellowColor]];
    NSArray *urls = [NSArray arrayWithObjects:@"http://pp.myapp.com/ma_icon/0/icon_10910_1468916742/96",@"http://pp.myapp.com/ma_icon/0/icon_93301_1469780396/96",@"http://pp.myapp.com/ma_icon/0/icon_10555_1469186507/96",@"http://pp.myapp.com/ma_icon/0/icon_12146495_1469586035/96",@"http://pp.myapp.com/ma_icon/0/icon_6633_1468340230/96",@"http://pp.myapp.com/ma_icon/0/icon_5832_1465992040/256",@"http://pp.myapp.com/ma_icon/0/icon_10297682_1469759844/256",@"http://pp.myapp.com/ma_icon/0/icon_242690_1468391652/256",@"http://pp.myapp.com/ma_icon/0/icon_1194437_1469587698/256", @"http://pp.myapp.com/ma_icon/0/icon_5080_1469686941/96",@"http://pp.myapp.com/ma_icon/0/icon_207027_1470101645/256",@"http://pp.myapp.com/ma_icon/0/icon_208247_1469706102/256",@"http://pp.myapp.com/ma_icon/0/icon_1119040_1468483409/256",nil];
    NSArray *appName = [NSArray arrayWithObjects:@"微信",@"万能钥匙",@"QQ读书",@"大闹天宫",@"QQ",@"大姨妈",@"baby",@"保卫萝卜",@"美装",@"淘宝",@"xx", @"eee",@"mmm",nil];
    collection = [[CollectionView alloc] initWithFrame:CGRectMake(20, 220, 55, 55) apps:urls names:appName];
    __weak __typeof(collection) weakSelf = collection;
    [collection setShowBigClick:^{
        [weakSelf showBig];
    }];
    [collection setAppClick:^(int idex) {
        NSLog(@"%d",idex);
    }];
    UIView *v = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 10, 10)];
    //[self.view addSubview:v];
    [self.view addSubview:collection];
      [self.view addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap:)]];
}
-(void)tap:(UIGestureRecognizer*)tap
{
    [collection showSmall];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
