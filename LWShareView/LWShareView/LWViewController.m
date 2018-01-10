//
//  LWViewController.m
//  LWShareView
//
//  Created by LeeWong on 2018/1/9.
//  Copyright © 2018年 LeeWong. All rights reserved.
//

#import "LWViewController.h"
#import "LWShareService.h"

@interface LWViewController ()

@end

@implementation LWViewController

- (IBAction)shareDidClick:(UIButton *)sender {
    [LWShareService shared].shareBtnClickBlock = ^(NSIndexPath *index) {
        NSLog(@"%@",index);
    };
    [[LWShareService shared] showInViewController:self];
}



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor blueColor];
    
  
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Lazy Load


@end
