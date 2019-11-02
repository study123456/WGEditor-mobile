//
//  WGUploadFileTool.m
//  WGRichTextEditor
//
//  Created by 胡文广 on 2019/11/2.
//  Copyright © 2019 wenguang. All rights reserved.
//

#import "WGUploadFileTool.h"

@implementation WGUploadFileTool
-(void)upLoadFileModel:(WGUploadFileModel*)fileModel Callback:(void(^)(NSString *key, float percent,id _Nullable obj,NSError * _Nullable error))callback{
    ///MARK:模拟网络请求上传图片
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if (callback) {
            callback(fileModel.key,0.1,nil,nil);
        }
    });
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.35 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if (callback) {
            callback(fileModel.key,0.35,nil,nil);
        }
    });
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.55 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if (callback) {
            callback(fileModel.key,0.55,nil,nil);
        }
    });
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.75 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if (callback) {
            callback(fileModel.key,0.75,nil,nil);
        }
    });
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if (callback) {
            callback(fileModel.key,1,@"上传成功",nil);
        }
    });
    
}
-(void)upLoadFileModels:(NSArray*)fileModels Callback:(void(^)(
                                                                      NSString *key,
                                                                      float percent,
                                                                      id _Nullable obj,
                                                                      NSError * _Nullable error
                                                                      )
                                                              )callback;{
    
    for (WGUploadFileModel *fileM in fileModels) {
        [self upLoadFileModel:fileM Callback:callback];
    }
    
}
@end
