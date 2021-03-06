//
//  MultipleLayoutButton.m
//  YunisDemo
//
//  Created by Yunis on 2020/8/10.
//  Copyright © 2020 Yunis. All rights reserved.
//

#import "SYMultipleLayoutButton.h"

@implementation SYElementConfig

+ (instancetype)defaultConfig
{
	SYElementConfig *config = [SYElementConfig new];
	config.titleFont = [UIFont systemFontOfSize:16.f];
	config.titleColor = [UIColor blackColor];
	config.imageViewSize = CGSizeMake(25, 25);
	config.distance = 8;
	config.margin = 8;
	config.buttonRadius = 8;
	config.layoutType = MultipleLayoutButtonTypeLeftTitle;
	return config;
}

@end

@interface SYMultipleLayoutButton()

@property(nonatomic,strong)UILabel *titleLabel;
@property(nonatomic,strong)UIImageView *iconImageView;
/**<点击事件回调*/
@property (nonatomic,copy  ) dispatch_block_t clickHandle;
@property (nonatomic,strong) UIView           *helpView;
@property (nonatomic,strong) UIControl        *touchControl;
@property (nonatomic,strong) SYElementConfig  *config;
@property (nonatomic,strong) UIFont           *titleFont;	/**<文字字体*/
@property (nonatomic,strong) UIColor          *titleColor;	/**<文字颜色*/
@property (nonatomic,assign) CGSize           imageViewSize;/**<图片大小*/
@property (nonatomic,assign) float            distance;		/**<图片与文字间的间隔*/
@property (nonatomic,assign) float            margin;		/**<文字、图片 与按钮的边距*/
@property (nonatomic,assign) float            buttonRadius;	/**<圆角*/


/**<布局类型*/
@property (nonatomic,assign) MultipleLayoutButtonType layoutType;
@end

@implementation SYMultipleLayoutButton

#define SYViewBorderRadius(View, Radius, Width, Color)\
\
[View.layer setCornerRadius:(Radius)];\
[View.layer setMasksToBounds:YES];\
[View.layer setBorderWidth:(Width)];\
[View.layer setBorderColor:[Color CGColor]]

#pragma mark - Public Method
//外部方法
+ (instancetype)butonWithConfig:(SYElementConfig *)config title:(NSString *)title iconImage:(UIImage *)iconImage
{
	SYMultipleLayoutButton *button = [[SYMultipleLayoutButton alloc] init];
	button.config = config;
	button.title = title;
	button.iconImage = iconImage;
	return button;
}


- (void)addTarget:(id)target select:(SEL)select
{
	[self.touchControl addTarget:target action:select forControlEvents:UIControlEventTouchUpInside];
}
- (void)addClickHandle:(dispatch_block_t)handle
{
	self.clickHandle = handle;
	[self.touchControl addTarget:self action:@selector(touchClick) forControlEvents:UIControlEventTouchUpInside];

}

#pragma mark - Life Cycle
//系统方法
- (instancetype)initWithFrame:(CGRect)frame
{
	self = [super initWithFrame:frame];
	if (self) {
		[self settingAppearance];
		[self loadSubViews];
	}
	return self;
}
- (void)layoutSubviews
{
	[super layoutSubviews];
	switch (self.layoutType) {
		case MultipleLayoutButtonTypeLeftTitle:
		{
			NSLog(@"1");
			[self.titleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
				make.left.equalTo(self.helpView);
				make.centerY.equalTo(self.helpView);
		
				make.top.greaterThanOrEqualTo(self.helpView);
			}];
			[self.iconImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
				make.right.equalTo(self.helpView);
				make.left.greaterThanOrEqualTo(self.titleLabel.mas_right).offset(self.distance).priority(776);
				make.centerY.equalTo(self.helpView);
				make.size.mas_equalTo(self.imageViewSize);
				make.top.greaterThanOrEqualTo(self.helpView);

			}];
			break;
		}
		case MultipleLayoutButtonTypeRightTitle:
		{
			NSLog(@"2");

			[self.titleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
				make.right.equalTo(self.helpView);
				make.centerY.equalTo(self.helpView);
				make.left.greaterThanOrEqualTo(self.iconImageView.mas_right).offset(self.distance).priority(776);
				make.top.greaterThanOrEqualTo(self.helpView);

			}];
			[self.iconImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
				make.left.equalTo(self.helpView);
				make.centerY.equalTo(self.helpView);
				make.size.mas_equalTo(self.imageViewSize);
				make.top.greaterThanOrEqualTo(self.helpView);

			}];
			break;
		}
		case MultipleLayoutButtonTypeTopTitle:
		{
			NSLog(@"3");

			[self.titleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
				make.top.equalTo(self.helpView);
				make.centerX.equalTo(self.helpView);
				make.left.greaterThanOrEqualTo(self.helpView);
				
			}];
			[self.iconImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
				make.bottom.equalTo(self.helpView);
				make.top.greaterThanOrEqualTo(self.titleLabel.mas_bottom).offset(self.distance).priority(776);
				make.centerX.equalTo(self.helpView);
				make.size.mas_equalTo(self.imageViewSize);
				make.left.greaterThanOrEqualTo(self.helpView);

			}];
			break;
		}
		case MultipleLayoutButtonTypeBottomTitle:
		{
			NSLog(@"4");

			[self.titleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
				make.bottom.equalTo(self.helpView);
				make.top.greaterThanOrEqualTo(self.iconImageView.mas_bottom).offset(self.distance).priority(776);
				make.centerX.equalTo(self.helpView);
				make.left.greaterThanOrEqualTo(self.helpView);

			}];
			[self.iconImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
				make.top.equalTo(self.helpView);
				make.centerX.equalTo(self.helpView);
				make.size.mas_equalTo(self.imageViewSize);
				make.left.greaterThanOrEqualTo(self.helpView);

			}];
			break;
		}
		default:
			break;
	}
	
	[self.helpView mas_makeConstraints:^(MASConstraintMaker *make) {
		make.center.equalTo(self);
		make.top.greaterThanOrEqualTo(self).offset(self.margin);
		make.left.greaterThanOrEqualTo(self).offset(self.margin);

	}];
	[self.touchControl mas_makeConstraints:^(MASConstraintMaker *make) {
		make.top.bottom.left.right.equalTo(self);
	}];
	if (self.buttonRadius) {
		SYViewBorderRadius(self, self.buttonRadius, 0.5, [UIColor clearColor]);
	}
}
#pragma mark - Intial Methods
//初始化数据

- (void)settingAppearance {
	self.backgroundColor = [UIColor whiteColor];
}

- (void)loadSubViews {
	[self addSubview:self.helpView];
	[self.helpView addSubview:self.titleLabel];
	[self.helpView addSubview:self.iconImageView];
	[self addSubview:self.touchControl];
}

#pragma mark - Network Methods && Target Methods
//网络请求 && 点击事件
- (void)touchClick {
	if (self.clickHandle) {
		self.clickHandle();
	}
}
#pragma mark - Private Method
//私有方法

#pragma mark - Delegate
//代理方法


#pragma mark - Lazy Loads
- (UILabel *)titleLabel {
	if (_titleLabel == nil) {
		_titleLabel = ({
			UILabel *label = [[UILabel alloc] init];
			label.textAlignment = NSTextAlignmentLeft;
			label;
		});
	}
	return _titleLabel;
}
- (UIImageView *)iconImageView {
	if (_iconImageView == nil) {
		_iconImageView = ({
			UIImageView *imageView = [[UIImageView alloc] init];
			imageView;
		});
	}
	return _iconImageView;
}
- (UIControl *)touchControl {
	if (_touchControl == nil) {
		_touchControl = ({
			UIControl *touch = [[UIControl alloc] init];
			touch;
		});
	}
	return _touchControl;
}
- (UIView *)helpView {
	if (_helpView == nil) {
		_helpView = ({
			UIView *view = [UIView new];
			view;
		});
	}
	return _helpView;
}

#pragma mark - Set
- (void)setConfig:(SYElementConfig *)config
{
	_config = config;
	self.titleFont = _config.titleFont;
	self.titleColor = _config.titleColor;
	self.imageViewSize = _config.imageViewSize;
	self.distance = _config.distance;
	self.margin = _config.margin;
	self.buttonRadius = _config.buttonRadius;
	self.layoutType = _config.layoutType;
	
}
- (void)setLayoutType:(MultipleLayoutButtonType)layoutType
{
	_layoutType = layoutType;
}
- (void)setTitle:(NSString *)title
{
	_title = title;
	self.titleLabel.text = _title;

}
- (void)setIconImage:(UIImage *)iconImage
{
	_iconImage = iconImage;
	self.iconImageView.image = _iconImage;
}
- (void)setTitleFont:(UIFont *)titleFont
{
	_titleFont = titleFont;
	self.titleLabel.font = _titleFont;
}
- (void)setImageViewSize:(CGSize)imageViewSize
{
	_imageViewSize = imageViewSize;
}
- (void)setTitleColor:(UIColor *)titleColor
{
	_titleColor = titleColor;
	self.titleLabel.textColor = _titleColor;
}
@end
