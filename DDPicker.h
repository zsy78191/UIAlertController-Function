//
//  DDPicker.h
//  Follow-Up
//
//  Created by 张超 on 2017/11/14.
//  Copyright © 2017年 orzer. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface DDPicker : UIPickerView
DDPicker* DDPickeIt();
@property (nonatomic, strong, readonly)  void (^show)(__kindof UIViewController* vc);
@property (nonatomic, strong, readonly)  DDPicker* (^titled)(NSString* title);
@property (nonatomic, strong, readonly)  DDPicker* (^commit)(NSString* title,void (^ __nullable)(NSString* selectedStr));
@property (nonatomic, strong, readonly)  DDPicker* (^cancel)(NSString* title);
@property (nonatomic, strong, readonly)  DDPicker* (^arrayed)(NSArray* titles);

@end

NS_ASSUME_NONNULL_END
