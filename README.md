# UIAlertController-Function
Functional programming of UIAlertController

## 使用UIAlertController-Function带来的改变

之前

```mm
UIAlertController* c = [UIAlertController alertControllerWithTitle:NSLocalizedString(@"更多操作", nil) message:@"" preferredStyle:UIAlertControllerStyleActionSheet];

[c addAction:[UIAlertAction actionWithTitle:NSLocalizedString(@"删除", nil) style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
    [self.imageHandle deletePWImageAtIndex:path.item];
}]];

[c addAction:[UIAlertAction actionWithTitle:NSLocalizedString(@"保存到系统相册" , nil) style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
    
}]];

[c addAction:[UIAlertAction actionWithTitle:NSLocalizedString(@"取消", nil) style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
    
}]];

[self presentViewController:c animated:YES completion:nil];
```

之后

```mm
DDActionSheet()
.titled(@"更多操作")		//标题
//.descripted(@"描述")   //描述 
.cancell(@"取消")
.recommend(@"删除",^(UIAlertAction * _Nonnull action, UIAlertController * _Nonnull alert) {
	// 删除操作
})
.action(@"保存到系统相册", ^(UIAlertAction * _Nonnull action, UIAlertController * _Nonnull alert) {
	// 保存操作
})
.show(self);
```

相关项目 (NSArray-Functional)[https://github.com/zsy78191/NSArray-Functional]
