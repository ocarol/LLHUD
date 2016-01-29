//
//  LLHUD.h
//  LLHUD
//
//  Created by ocarol on 15/12/15.
//  Copyright © 2015年 ocarol. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, HUDStyle) {
      HUDStyleTelphone = 1 << 0,
      HUDStyleMesseage = 1 << 1,
};


@interface LLHUD : UIView

@property (nonatomic, strong) NSString *message;
@property (nonatomic, strong) NSString *telphoneNum;
@property (nonatomic, strong) UIImage  *iconImg;

+ (instancetype)HUDWithStyle:(HUDStyle)hudStyle cancel:(NSString*)cancel other:(NSString*)other;

- (void)show;
- (void)hiden;
- (void)hiden_afterSeconds:(int)delayInseconds;

@end
