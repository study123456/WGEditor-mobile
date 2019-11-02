//
//  WGUploadFileModel.h
//  WGRichTextEditor
//
//  Created by 胡文广 on 2019/11/2.
//  Copyright © 2019 wenguang. All rights reserved.
//
typedef enum : NSUInteger {
    WGUploadFileStateProgress,//上传中
    WGUploadFileStateError,//上传失败
    WGUploadFileStateSuccess,//上传成功
} WGUploadFileState;

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
//*上传的文件模型**/
@interface WGUploadFileModel : NSObject
@property (nonatomic,assign) WGUploadFileState state;
@property (nonatomic,copy) NSString *host;
@property (nonatomic, strong) NSString *key;
//一般由服务器返回
@property (nonatomic, strong) NSString *token;

@property (nonatomic, strong) UIImage *image;
@property (nonatomic, strong) NSData *fileData;

- (NSString *)uuid;
+ (id)jsonObject:(NSString *)jsonString;
@end

NS_ASSUME_NONNULL_END
