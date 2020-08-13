//
//  SYChooseImageView.h
//  YXHeFei
//
//  Created by Yunis on 2020/1/8.
//  Copyright © 2020 天源迪科. All rights reserved.
//

#import <UIKit/UIKit.h>

//typedef NS_ENUM(NSInteger,SYChooseImageType) {
//    SYChooseImageType_choosePhoto, /**<选择照片*/
//    SYChooseImageType_takePic /**<拍照*/
//};
/*
    使用者应该只关心返回的图片数据，其他的不应该关心。
    也可以传入图片进行展示 编辑
 */



typedef void(^infoChangeFeedback)(NSArray <UIImage *>* images,float viewHeight);

@interface SYChooseImageView : UIView
@property(nonatomic,assign)BOOL canEditing; /**<是否可以编辑。 默认可以编辑*/

+ (instancetype)showImageWithImages:(NSArray <UIImage *>*)images infoChangeFeedback:(infoChangeFeedback)handle;
+ (instancetype)showImageWithImageURLs:(NSArray <NSString *>*)imageURLs infoChangeFeedback:(infoChangeFeedback)handle;


@end
