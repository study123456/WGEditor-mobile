//
//  WGUploadFileTool.h
//  WGRichTextEditor
//
//  Created by 胡文广 on 2019/11/2.
//  Copyright © 2019 wenguang. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
@interface WGUploadFileTool : NSObject
-(void)upLoadFileModel:(WGUploadFileModel*)fileModel
               Callback:(void(^)(
                                NSString *key,
                                float percent,
                                id _Nullable obj,
                                NSError * _Nullable error
                                )
                        )callback;

-(void)upLoadFileModels:(NSArray*)fileModels
               Callback:(void(^)(
                                 NSString *key,
                                 float percent,
                                 id _Nullable obj,
                                 NSError * _Nullable error
                                 )
                         )callback;
@end

NS_ASSUME_NONNULL_END
