//
//  DDPicker.m
//  Follow-Up
//
//  Created by 张超 on 2017/11/14.
//  Copyright © 2017年 orzer. All rights reserved.
//

#import "DDPicker.h"
@import ChameleonFramework;
@import ReactiveObjC;
@interface DDPicker () <UIPickerViewDelegate, UIPickerViewDataSource>

@property (nonatomic, strong) UIView* contentView;
@property (nonatomic, strong) NSArray* arrays;
@property (nonatomic, assign) NSInteger selectedIdx;
@end

@implementation DDPicker

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return self.arrays[row];
}

DDPicker* DDPickeIt(){
    @autoreleasepool{
        CGRect r = [UIScreen mainScreen].bounds;
        DDPicker* d = [[DDPicker alloc] initWithFrame:CGRectMake(0, 0, r.size.width, r.size.height)];
        d.delegate = d;
        d.dataSource = d;
        d.selectedIdx = 0;
        UIView* contentView = [[UIView alloc] initWithFrame:r];
        d.contentView = contentView;
        return d;
    }
}

- (NSInteger)numberOfComponentsInPickerView:(nonnull UIPickerView *)pickerView {
    return 1;
}

- (NSInteger)pickerView:(nonnull UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    if (!self.arrays) {
        return 0;
    }
    return self.arrays.count;
}

- (void (^)(__kindof UIViewController * _Nonnull))show
{
    return ^(__kindof UIViewController * _Nonnull vc){
        dispatch_async(dispatch_get_main_queue(), ^{
            UIVisualEffectView *visualEffectView = [[UIVisualEffectView alloc] initWithEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleLight]];
            visualEffectView.frame = self.bounds;
            visualEffectView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
            visualEffectView.tag = 90893;
            [self.contentView insertSubview:visualEffectView atIndex:0];
            [self.contentView insertSubview:self atIndex:1];
            [[UIApplication sharedApplication].keyWindow addSubview:self.contentView];
            
            [self setFrame:[UIApplication sharedApplication].keyWindow.screen.bounds];
            self.autoresizingMask = 0xff;
//            self.backgroundColor = [UIColor lightGrayColor];
            
            self.contentView.alpha = 0;
            self.contentView.transform = CGAffineTransformMakeScale(0.9, 0.9);
            [UIView animateWithDuration:0.24 animations:^{
                self.contentView.alpha = 1;
                self.contentView.transform = CGAffineTransformIdentity;
            }];
            self.contentView = nil;
        });
    };
}

- (DDPicker *(^)(NSString *))titled
{
    return ^(NSString* title) {
        UILabel* label = [[UILabel alloc] initWithFrame:CGRectMake(0, 80, self.frame.size.width, 70)];
        [self addSubview:label];
        label.text = title;
        label.font = [UIFont preferredFontForTextStyle:UIFontTextStyleTitle1];
        label.textAlignment = NSTextAlignmentCenter;
        return self;
    };
}

- (DDPicker * _Nonnull (^)(NSString * _Nonnull, void (^ _Nullable)(NSString * _Nonnull)))commit
{
    return  ^(NSString * _Nonnull str,void (^ block)(NSString * _Nonnull)){
        UIButton* b = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 200, 50)];
        NSDictionary* d = @{NSFontAttributeName:[UIFont preferredFontForTextStyle:UIFontTextStyleTitle2],NSForegroundColorAttributeName:[UIColor colorWithHexString:@"#1F8EFA"]};
        
        [b setAttributedTitle:[[NSAttributedString alloc] initWithString:str attributes:d] forState:UIControlStateNormal];
        [self.contentView addSubview:b];
        b.center = CGPointMake(self.frame.size.width/2, self.frame.size.height - 100);
        @weakify(self);
        b.rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            @strongify(self);
            return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
                
                if (block) {
                    block(self.arrays[self.selectedIdx]);
                }
                [self dismiss];
                [subscriber sendCompleted];
                return [RACDisposable disposableWithBlock:^{
                    
                }];
            }];
        }];
        return self;
    };
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
//    NSLog(@"select %@",@(row));
    self.selectedIdx = row;
}

- (DDPicker * _Nonnull (^)(NSString * _Nonnull))cancel
{
    return  ^(NSString * _Nonnull str){
        UIButton* b = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 200, 50)];
        NSDictionary* d = @{NSFontAttributeName:[UIFont preferredFontForTextStyle:UIFontTextStyleTitle2],NSForegroundColorAttributeName:[UIColor lightGrayColor]};
        
        [b setAttributedTitle:[[NSAttributedString alloc] initWithString:str attributes:d] forState:UIControlStateNormal];
        [self.contentView addSubview:b];
        b.center = CGPointMake(self.frame.size.width/2, self.frame.size.height - 50);
        @weakify(self);
        b.rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            @strongify(self);
            return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
                [self dismiss];
                [subscriber sendCompleted];
                return [RACDisposable disposableWithBlock:^{
                    
                }];
            }];
        }];
        return self;
    };
}

- (DDPicker * _Nonnull (^)(NSArray * _Nonnull))arrayed
{
    return ^(NSArray * _Nonnull array) {
       
        self.arrays = [array copy];
        [self reloadComponent:0];
        return self;
    };
}

- (void)dismiss
{
    [UIView animateWithDuration:0.24 animations:^{
        self.superview.alpha = 0;
        self.superview.transform = CGAffineTransformMakeScale(0.9, 0.9);
    } completion:^(BOOL finished) {
        [self.superview removeFromSuperview];
    }];
}


- (void)dealloc
{
//    NSLog(@"%@ %s",self,__func__);
}

@end
