# LWShareView

## 简介

一个简单的APP分享菜单,通过传递两个(或者一个)数组 就可以展示一个分享菜单，继承非常简单。

## 依赖

* 依赖于Masonry实现布局。
* 依赖ReactiveCocoa(只是按钮的点击事件,如果不需要可以去掉)

## 使用

### 1、在对应的控制器中直接调用即可

```Objective-C
- (IBAction)shareDidClick:(UIButton *)sender {
    [LWShareService shared].shareBtnClickBlock = ^(NSIndexPath *index) {
        NSLog(@"%@",index);
    };
    [[LWShareService shared] showInViewController:self];
}
```

### 2、数组要求

kShareIcon 按钮的图片
kShareTitle 按钮的标题

```Objective-C
+ (NSArray *)topMenus
{
    return @[@{kShareIcon:@"share_artbox",kShareTitle:@"转发"},@{kShareIcon:@"share_artchat",kShareTitle:@"艺信好友"}];
}
```


## 效果

### 单行

![单行](http://og0h689k8.bkt.clouddn.com/18-1-10/12375090.jpg)

### 多行
![多行](http://og0h689k8.bkt.clouddn.com/18-1-10/70174883.jpg)

### GIF
![效果](http://og0h689k8.bkt.clouddn.com/18-1-10/82516235.jpg)


