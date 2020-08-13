//
//  MultipleLayoutButton.h
//  YunisDemo
//
//  Created by Yunis on 2020/8/10.
//  Copyright © 2020 Yunis. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Masonry/Masonry.h>

typedef NS_ENUM(NSInteger,MultipleLayoutButtonType) {
	MultipleLayoutButtonTypeLeftTitle = 1,
	MultipleLayoutButtonTypeRightTitle,
	MultipleLayoutButtonTypeTopTitle,
	MultipleLayoutButtonTypeBottomTitle
};
@interface SYElementConfig : NSObject
@property (nonatomic,strong) UIFont   *titleFont;	/**<文字字体*/
@property (nonatomic,strong) UIColor  *titleColor;	/**<文字颜色*/
@property (nonatomic,assign) CGSize   imageViewSize;/**<图片大小*/
@property (nonatomic,assign) float    distance;		/**<图片与文字间的间隔*/
@property (nonatomic,assign) float    margin;		/**<文字、图片 与按钮的边距*/
@property (nonatomic,assign) float    buttonRadius;	/**<圆角*/

@property (nonatomic,assign) MultipleLayoutButtonType layoutType; /**<布局类型*/

+ (instancetype)defaultConfig;
@end
@interface SYMultipleLayoutButton : UIView
/*
	设置文本颜色。字体大小
	图片大小、与title 的边距
	图片设置圆角、边框
	按钮设置边框、圆角
 */

@property(nonatomic,assign)MultipleLayoutButtonType titleLayoutType;

@property (nonatomic,copy  ) NSString *title;		/**<标题*/
@property (nonatomic,strong) UIImage  *iconImage;	/**<图片*/

+ (instancetype)butonWithConfig:(SYElementConfig *)config title:(NSString *)title iconImage:(UIImage *)iconImage;

- (void)addTarget:(id)target select:(SEL)select;
- (void)addClickHandle:(dispatch_block_t)handle;

@end


