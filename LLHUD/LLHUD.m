//
//  LLHUD.m
//  LLHUD
//
//  Created by ocarol on 15/12/15.
//  Copyright © 2015年 ocarol. All rights reserved.
//

#import "LLHUD.h"
#import "UIView+Frame.h"

#define KScreenHeight   [UIScreen mainScreen].bounds.size.height
#define KScreenWidth    [UIScreen mainScreen].bounds.size.width
#define AutoSizeScaleX  (KScreenHeight > 480 ? KScreenWidth/320 : 1.0)
#define AutoSizeScaleY  (KScreenHeight > 480 ? KScreenHeight/568 : 1.0)

//#define CGRectMakeCustom(x, y, width, height)  CGRectMake(x * AutoSizeScaleX, y * AutoSizeScaleY, width * AutoSizeScaleX, height * AutoSizeScaleY)

#define IOS9         ([[[UIDevice currentDevice] systemVersion] floatValue] >= 9.0)
#define Font(s)     (IOS9 ? [UIFont systemFontOfSize:s] : [UIFont fontWithName:@"STHeitiSC-Light" size:s])

#define Color(r,g,b) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1.0]

#define StrValid(f)  (f!=nil && [f isKindOfClass:[NSString class]] && ![f isEqualToString:@""])

@interface LLHUD()

@property (nonatomic, strong) UIView         *alerView;
@property (nonatomic, strong) UIImageView    *iconIMGView;
@property (nonatomic, strong) UILabel        *messageLabel;
@property (nonatomic, strong) UILabel        *telphoneLabel;
@property (nonatomic, strong) UIView         *line;
@property (nonatomic, strong) NSMutableArray *btnArray;
@property (nonatomic, assign) HUDStyle       hudStyle;

@end

@implementation LLHUD

+ (instancetype)HUDWithStyle:(HUDStyle)hudStyle cancel:(NSString*)cancel other:(NSString*)other{
    
    // 蒙版
    LLHUD *cover = [self new];
    cover.backgroundColor =  [UIColor colorWithWhite:0 alpha:0.7];
    
    return [cover HUDWithStyle:hudStyle cancel:cancel other:other];
    
}

- (instancetype)HUDWithStyle:(HUDStyle)hudStyle cancel:(NSString*)cancel other:(NSString*)other{
    
    // alerView
    self.alerView = [UIView new];
    self.alerView.backgroundColor = [UIColor whiteColor];
    self.alerView.layer.cornerRadius = 8 * AutoSizeScaleX;
    self.alerView.layer.masksToBounds = YES;
    [self addSubview:self.alerView];
    
    // iconIMGView
    self.iconIMGView = [UIImageView new];
    [self addSubview:self.iconIMGView];
    
    self.btnArray = [NSMutableArray array];
    
    // messageLabel
    if((hudStyle & HUDStyleMesseage) == HUDStyleMesseage){
        
        self.messageLabel = [UILabel new];
        self.messageLabel.numberOfLines = 0;
        self.messageLabel.font = Font(18);
        self.messageLabel.textAlignment = NSTextAlignmentCenter;
        [self.alerView addSubview:self.messageLabel];
        
    }
    
    // telphoneLabel
    if((hudStyle & HUDStyleTelphone) == HUDStyleTelphone){
        
        self.telphoneLabel = [UILabel new];
        self.telphoneLabel.font = Font(18);
        self.telphoneLabel.textColor = [UIColor blueColor];
        self.telphoneLabel.textAlignment = NSTextAlignmentCenter;
        [self.alerView addSubview:self.telphoneLabel];
        
    }
    
    // line
    self.line = [UIView new];
    [self.alerView addSubview:self.line];
    
    if (StrValid(cancel)) {
        
        UIButton *cancelBtn = [UIButton new];
        [cancelBtn setTitle:cancel forState:UIControlStateNormal];
        [cancelBtn addTarget:self action:@selector(remove) forControlEvents:UIControlEventTouchUpInside];
        [self.btnArray addObject:cancelBtn];
        [self.alerView addSubview:cancelBtn];
        cancelBtn.selected = other ? NO:YES;
    }
    
    if (StrValid(other)) {
        
        UIButton *otherBtn = [UIButton new];
        [otherBtn setTitle:other forState:UIControlStateNormal];
        [otherBtn addTarget:self action:@selector(didClickOtherBtn) forControlEvents:UIControlEventTouchUpInside];
        [self.btnArray addObject:otherBtn];
        [self.alerView addSubview:otherBtn];
        otherBtn.selected = YES;
        
    }
    

    return self;


}
- (void)layoutSubviews{
    
    [super layoutSubviews];
    CGFloat Y;
    CGFloat margin = 20 * AutoSizeScaleY;
    self.frame = CGRectMake(0, 0, KScreenWidth, KScreenHeight);
    self.alerView.frame = CGRectMake(0, 0, 200, 200);
    self.alerView.width = self.width - 40 *AutoSizeScaleX * 2;
    
    self.iconIMGView.size = CGSizeMake(80*AutoSizeScaleX, 80*AutoSizeScaleY);
    
    
    
    Y = 50*AutoSizeScaleY + margin;
    
    self.messageLabel.frame = CGRectMake(10 * AutoSizeScaleX, Y, self.alerView.width - 20 *AutoSizeScaleX, CGFLOAT_MAX);
    [self.messageLabel sizeToFit];
    if (self.messageLabel.width < self.alerView.width - 20 *AutoSizeScaleX) {
        self.messageLabel.width = self.alerView.width - 20 *AutoSizeScaleX;
    }
    self.messageLabel.y = Y;
    if (StrValid(self.messageLabel.text)) {
         Y = CGRectGetMaxY(self.messageLabel.frame) + margin;
    }
   
    
    self.telphoneLabel.frame = CGRectMake(10 * AutoSizeScaleX, Y, self.alerView.width - 20 *AutoSizeScaleX, CGFLOAT_MAX);
    [self.telphoneLabel sizeToFit];
    if (self.telphoneLabel.width < self.alerView.width - 20 *AutoSizeScaleX) {
        self.telphoneLabel.width = self.alerView.width - 20 *AutoSizeScaleX;
    }
    self.telphoneLabel.y = Y;
    if (StrValid(self.telphoneLabel.text)) {
         Y = CGRectGetMaxY(self.telphoneLabel.frame) + margin;
    }
   
    
    
  
    NSInteger count = self.btnArray.count;
    if (count) {
        
        self.line.frame = CGRectMake(0, Y, self.alerView.width, 1);
        self.line.backgroundColor = Color(238, 42, 202);
        Y += 1;
        
        CGFloat btnW = self.alerView.width / count;
        CGFloat btnH = 44 * AutoSizeScaleY;
        
        for (int i = 0; i<count; i++) {
            UIButton*btn = self.btnArray[i];
            btn.frame = CGRectMake(btnW * i, Y, btnW, btnH);
            [btn.titleLabel setFont:Font(18)];
            [btn setTitleColor:Color(238, 42, 202) forState:UIControlStateNormal];
            [btn setBackgroundImage:[self imageWithColor:[UIColor whiteColor]] forState:UIControlStateNormal];
            [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
            [btn setBackgroundImage:[self imageWithColor:Color(238, 42, 202)] forState:UIControlStateSelected];
            
        }
        
        Y += btnH;
    }
    
    self.alerView.height = Y;
    self.alerView.y = (self.height - self.alerView.height)/2;
    self.alerView.x = 40 *AutoSizeScaleX;
    self.iconIMGView.centerX = self.alerView.centerX;
    self.iconIMGView.centerY = self.alerView.y + 10 * AutoSizeScaleY;

}

- (void)didClickOtherBtn{

     if((self.hudStyle & HUDStyleTelphone) == HUDStyleTelphone && StrValid(self.telphoneLabel.text)){

         NSString *callTel = [NSString stringWithFormat:@"tel://%@",self.telphoneLabel.text];
         [[UIApplication sharedApplication] openURL:[NSURL URLWithString:callTel]];

    }

}

- (void)remove{
    
    [self removeFromSuperview];

}

- (void)show{
    
     [self layoutIfNeeded];
    [[UIApplication sharedApplication].keyWindow addSubview:self];
   

}

- (void)setMessage:(NSString *)message{
    _message = message;
    self.messageLabel.text = message;

}

- (void)setTelphoneNum:(NSString *)telphoneNum{
    _telphoneNum = telphoneNum;
    self.telphoneLabel.text = telphoneNum;
    NSMutableAttributedString *attrString = [[NSMutableAttributedString alloc] initWithString:telphoneNum];
    [attrString addAttribute:NSUnderlineStyleAttributeName value:@(NSUnderlineStyleSingle) range:[telphoneNum rangeOfString:telphoneNum]];//下划线
    self.telphoneLabel.attributedText = attrString;
    
}

- (void)setIconImg:(UIImage *)iconImg{
    _iconImg = iconImg;
    self.iconIMGView.image = iconImg;

}

- (UIImage *)imageWithColor:(UIColor *)color {
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}
@end
