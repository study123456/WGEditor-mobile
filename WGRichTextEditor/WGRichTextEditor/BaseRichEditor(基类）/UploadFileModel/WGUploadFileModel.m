//
//  WGUploadFileModel.m
//  WGRichTextEditor
//
//  Created by 胡文广 on 2019/11/2.
//  Copyright © 2019 wenguang. All rights reserved.
//

#import "WGUploadFileModel.h"

@implementation WGUploadFileModel


- (NSString *)uuid{
    CFUUIDRef uuidRef = CFUUIDCreate(nil);
    CFStringRef uuidString = CFUUIDCreateString(nil, uuidRef);
    NSString *uuid = (__bridge NSString *)uuidString;
    CFRelease(uuidString);
    CFRelease(uuidRef);
    
    return uuid;
}

+ (id)jsonObject:(NSString *)jsonString
{
    NSError *error = nil;
    if (jsonString == NO) {
        //        YKLog(@"string is invalid");
        return nil;
    }
    id result = [NSJSONSerialization JSONObjectWithData:[jsonString dataUsingEncoding:NSUTF8StringEncoding]
                                                options:NSJSONReadingMutableContainers
                                                  error:&error];
    if (error || [NSJSONSerialization isValidJSONObject:result] == NO)
    {
        return nil;
    }
    
    return result;
}
@end
