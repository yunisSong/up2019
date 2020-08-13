//
//  SYTestViewController.m
//  YXHeFei
//
//  Created by Yunis on 2020/1/8.
//  Copyright © 2020 天源迪科. All rights reserved.
//

#import "SYTestViewController.h"
#import "SYChooseImageView.h"
@interface SYTestViewController ()
@property (weak, nonatomic) IBOutlet UIView *viewA;
@property (weak, nonatomic) IBOutlet UIView *viewB;

@end

@implementation SYTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self.viewA mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self.view);
        make.height.mas_equalTo(100);
    }];
//
//    SYChooseImageView *choso = [SYChooseImageView
//                                showImageWithImages:
//                                    @[[UIImage imageNamed:@"addImage"],[UIImage imageNamed:@"addImage"]]
//                                infoChangeFeedback:
//                                    ^(NSArray<UIImage *> *images, float viewHeight) {
//                                        NSLog(@"images == %@",images);
//                                        NSLog(@"viewHeight == %f",viewHeight);
//                                }];
//
    
    WS(weakSelf);
    SYChooseImageView *choso = [SYChooseImageView
                                showImageWithImageURLs:
                                    @[@"http://img1.imgtn.bdimg.com/it/u=2980646688,2456398145&fm=26&gp=0.jpg",@"http://a3.att.hudong.com/34/24/01300000864537127442247099447_s.jpg",@"http://img.pconline.com.cn/images/upload/upc/tx/photoblog/1411/23/c1/41203873_1416716663935.jpg"]
                                infoChangeFeedback:
                                    ^(NSArray<UIImage *> *images, float viewHeight) {
                                        NSLog(@"images == %@",images);
                                        NSLog(@"viewHeight == %f",viewHeight);
        
                                    weakSelf.viewB.frame = CGRectMake(0, 100 + viewHeight, 100, 200);

                                }];

    [self.view addSubview:choso];
                                            NSLog(@"pouasodpfusaopdfuo == ");

    [choso mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.viewA.mas_bottom);
    }];
    
//    [self.viewB mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.right.equalTo(self.view);
//        make.top.equalTo(choso.mas_bottom);
//        make.height.mas_equalTo(100);
//    }];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (void)dealloc
{
    NSLog(@"-------------");
}
@end
