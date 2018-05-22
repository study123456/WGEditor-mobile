//
//  WGUploadPictureModel.h
//  WGRichTextEditor
//
//  Created by 胡文广 on 2018/5/11.
//  Copyright © 2018年 wenguang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
typedef enum : NSUInteger {
    WGUploadImageModelTypeNone,//上传中
    WGUploadImageModelTypeError,//上传失败
    WGUploadImageModelTypeSuccess,//上传成功
} WGUploadImageModelType;
@interface WGUploadPictureModel : NSObject
@property (nonatomic,copy) NSString *host;//图片域名
@property (nonatomic, strong) NSString *fileName; //命名
@property (nonatomic, strong) NSString *key;
@property (nonatomic, strong) NSString *token; //服务器返回的
@property (nonatomic, strong) NSString *filePath; //本地的地址
@property (nonatomic, strong) NSData *imageData;
@property (nonatomic,assign) WGUploadImageModelType type;
@property (nonatomic, strong) UIImage *image;
@end
