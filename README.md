# LLHUD
蒙版弹窗

![](LLHUDDemo.gif)

用法比较简单,当然功能也很简单(目前只有两种样式,HUDStyleMesseage和HUDStyleTelphone),按钮最多支持2个,以下给出几个事例:

#HUDStyleMesseage样式
也就是按钮16对应的蒙版
```objc
- (IBAction)Btn16:(id)sender {
    LLHUD *hub = [LLHUD HUDWithStyle:HUDStyleMesseage cancel:@"确定" other:nil];
    hub.message = @"兑换成功!";
    hub.iconImg = [UIImage imageNamed:@"HUD_sucess"];
    [hub show];
}
```


#HUDStyleMesseage|HUDStyleTelphone样式
也就是按钮17对应的蒙版
```objc
- (IBAction)Btn17:(id)sender {
    LLHUD *hub = [LLHUD HUDWithStyle:HUDStyleMesseage | HUDStyleTelphone cancel:@"取消" other:@"呼叫"];
    hub.message = @"兑换失败!请联系客服!";
    hub.telphoneNum = @"4008-000-000";
    hub.iconImg = [UIImage imageNamed:@"HUD_failure"];
    [hub show];
}
```
#蒙版自动消失
- (void)hiden;
```objc
- (IBAction)Btn22:(id)sender {

LLHUD *hub = [LLHUD HUDWithStyle:HUDStyleMesseage cancel:nil other:nil];
hub.message = @"兑换成功!";
hub.iconImg = [UIImage imageNamed:@"HUD_sucess"];
[hub show];
[hub hiden];

}
```

#自定义蒙版消失延迟时间
- (void)hiden_afterSeconds:(int)delayInseconds;
```objc
- (IBAction)Btn23:(id)sender {

LLHUD *hub = [LLHUD HUDWithStyle:HUDStyleMesseage cancel:nil other:nil];
hub.message = @"兑换失败!";
hub.iconImg = [UIImage imageNamed:@"HUD_failure"];
[hub show];
[hub hiden_afterSeconds:0.1];
}
```