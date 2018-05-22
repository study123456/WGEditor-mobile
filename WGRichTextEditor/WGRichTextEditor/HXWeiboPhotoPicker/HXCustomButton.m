//
//  HXCustomButton.m
//  KaiWen
//
//  Created by 胡文广 on 2018/4/25.
//  Copyright © 2018年 胡文广. All rights reserved.
//

#import "HXCustomButton.h"

@implementation HXCustomButton
-(BOOL)pointInside:(CGPoint)point withEvent:(UIEvent*)event {
    
    CGRect bounds = self.bounds;
    if (self.amplifierRange<=0) {
        self.amplifierRange = bounds.size.width;
    }
    CGFloat widthDelta = MAX(self.amplifierRange, 0);
    CGFloat heightDelta = MAX(self.amplifierRange, 0);
    bounds = CGRectInset(bounds, -0.5 * widthDelta, -0.5 * heightDelta);
    return CGRectContainsPoint(bounds, point);
    
}
@end
