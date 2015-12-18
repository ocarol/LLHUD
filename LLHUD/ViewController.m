//
//  ViewController.m
//  LLHUD
//
//  Created by ocarol on 15/12/15.
//  Copyright © 2015年 ocarol. All rights reserved.
//

#import "ViewController.h"
#import "LLHUD.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)Btn16:(id)sender {
    LLHUD *hub = [LLHUD HUDWithStyle:HUDStyleMesseage cancel:@"确定" other:nil];
    hub.message = @"兑换成功!";
    hub.iconImg = [UIImage imageNamed:@"HUD_sucess"];
    [hub show];
}

- (IBAction)Btn17:(id)sender {
    LLHUD *hub = [LLHUD HUDWithStyle:HUDStyleMesseage | HUDStyleTelphone cancel:@"取消" other:@"呼叫"];
    hub.message = @"兑换失败!请联系客服!";
    hub.telphoneNum = @"4008-000-000";
    hub.iconImg = [UIImage imageNamed:@"HUD_failure"];
    [hub show];
}

- (IBAction)Btn21:(id)sender {
    LLHUD *hub = [LLHUD HUDWithStyle:HUDStyleMesseage cancel:@"知道了" other:nil];
    hub.message = @"支付失败!\n\n请到个人用户中心支付";
    hub.iconImg = [UIImage imageNamed:@"HUD_failure"];
    [hub show];
    
}

- (IBAction)Btn20:(id)sender {
    LLHUD *hub = [LLHUD HUDWithStyle:HUDStyleMesseage cancel:@"确定" other:nil];
    hub.message = @"支付成功!";
    hub.iconImg = [UIImage imageNamed:@"HUD_sucess"];
    [hub show];
}

- (IBAction)Btn22:(id)sender {
    
    LLHUD *hub = [LLHUD HUDWithStyle:HUDStyleMesseage cancel:nil other:nil];
    hub.message = @"兑换成功!";
    hub.iconImg = [UIImage imageNamed:@"HUD_sucess"];
    [hub show];
    [hub hiden];

}


@end
