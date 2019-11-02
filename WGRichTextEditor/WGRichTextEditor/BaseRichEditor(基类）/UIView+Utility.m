//
//  UIView+Utility.m
//  DGUtilityKit
//
//  Created by Jinxiao on 4/11/13.
//  Copyright (c) 2013 debugeek. All rights reserved.
//

#import "UIView+Utility.h"

@implementation UIView (Size)

- (CGFloat)left
{
    return self.frame.origin.x;
}

- (void)setLeft:(CGFloat)x
{
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

- (CGFloat)top
{
    return self.frame.origin.y;
}

- (void)setTop:(CGFloat)y
{
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

- (CGFloat)right
{
    return self.frame.origin.x + self.frame.size.width;
}

- (void)setRight:(CGFloat)right
{
    CGRect frame = self.frame;
    frame.origin.x = right - frame.size.width;
    self.frame = frame;
}

- (CGFloat)bottom
{
    return self.frame.origin.y + self.frame.size.height;
}

- (void)setBottom:(CGFloat)bottom
{
    CGRect frame = self.frame;
    frame.origin.y = bottom - frame.size.height;
    self.frame = frame;
}

- (CGFloat)centerX
{
    return self.center.x;
}

- (void)setCenterX:(CGFloat)centerX
{
    self.center = CGPointMake(centerX, self.center.y);
}

- (CGFloat)centerY
{
    return self.center.y;
}

- (void)setCenterY:(CGFloat)centerY
{
    self.center = CGPointMake(self.center.x, centerY);
}

- (CGFloat)width
{
    return self.frame.size.width;
}

- (void)setWidth:(CGFloat)width
{
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

- (CGFloat)height
{
    return self.frame.size.height;
}

- (void)setHeight:(CGFloat)height
{
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

@end

@implementation UIView (Dynamic)

- (UIImage *)snapshotImage
{
    UIGraphicsBeginImageContextWithOptions([self bounds].size, YES, 0);
    
    CGContextTranslateCTM(UIGraphicsGetCurrentContext(), -[self bounds].origin.x, -[self bounds].origin.y);
    
    [[self layer] renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

@end

@implementation UIView (FirstResponder)

- (id)firstResponder
{
    if(self.isFirstResponder)
    {
        return self;
    }
    for(UIView *subView in self.subviews)
    {
        id responder = [subView firstResponder];
        if(responder)
        {
            return responder;
        }
    }
    return nil;
}
@end



@implementation UIView (Border)

#pragma mark -  Borders

- (CALayer *)addTopFromBorderWithColor:(UIColor *)color andWidth:(CGFloat) borderWidth
{
    CALayer *border = [CALayer layer];
    border.backgroundColor = color.CGColor;
    
    border.frame = CGRectMake(0, 0, self.frame.size.width, borderWidth);
    [self.layer addSublayer:border];
    
    return border;
}

- (CALayer *)addTopBorderWithColor:(UIColor *)color andWidth:(CGFloat) borderWidth
{
    CALayer *border = [CALayer layer];
    border.backgroundColor = color.CGColor;
    
    border.frame = CGRectMake(14, 0, self.frame.size.width, borderWidth);
    [self.layer addSublayer:border];
    
    return border;
}

- (CALayer *)addTopBorderWithColor:(UIColor *)color width:(CGFloat) borderWidth left:(CGFloat)borderLeft{
    CALayer *border = [CALayer layer];
    border.backgroundColor = color.CGColor;
    border.frame = CGRectMake(borderLeft, 0, self.frame.size.width - borderLeft, borderWidth);
    [self.layer addSublayer:border];
    
    return border;
}

- (CALayer *)addBottomBorderWithColor:(UIColor *)color andWidth:(CGFloat) borderWidth
{
    CALayer *border = [CALayer layer];
    
    if (borderWidth != 0)
    {
        border.backgroundColor = color.CGColor;
        border.frame = CGRectMake(0, self.frame.size.height-borderWidth, self.frame.size.width, borderWidth);
        [self.layer addSublayer:border];
    }
    
    return border;
}
- (CALayer *)addBottomX:(CGFloat)x BorderWithColor:(UIColor *)color andWidth:(CGFloat) borderWidth
{
    CALayer *border = [CALayer layer];
    
    if (borderWidth != 0)
    {
        border.backgroundColor = color.CGColor;
        
        border.frame = CGRectMake(x, self.frame.size.height-borderWidth, self.frame.size.width, borderWidth);
        [self.layer addSublayer:border];
    }
    
    return border;
}
- (CALayer *)addCenterHBorderWithColor:(UIColor *)color andWidth:(CGFloat) borderWidth
{
    CALayer *border = [CALayer layer];
    
    if (borderWidth != 0)
    {
        border.backgroundColor = color.CGColor;
        
        border.frame = CGRectMake(0, (self.frame.size.height-borderWidth)/2, self.frame.size.width, borderWidth);
        [self.layer addSublayer:border];
    }
    
    return border;
}

- (CALayer *)addCenterVBorderWithColor:(UIColor *)color andWidth:(CGFloat) borderWidth
{
    CALayer *border = [CALayer layer];
    border.backgroundColor = color.CGColor;
    
    border.frame = CGRectMake((self.frame.size.width-borderWidth)/2, 0, borderWidth, self.frame.size.height);
    [self.layer addSublayer:border];
    
    return border;
    
}

- (CALayer *)addBottomBorderWithColor:(UIColor *)color width:(CGFloat) borderWidth left:(CGFloat)borderLeft
{
    CALayer *border = [CALayer layer];
    
    if (borderWidth != 0)
    {
        border.backgroundColor = color.CGColor;
        
        border.frame = CGRectMake(borderLeft, self.frame.size.height-borderWidth, self.frame.size.width - borderLeft, borderWidth);
        [self.layer addSublayer:border];
    }
    
    return border;
}

- (CALayer *)addLeftBorderWithColor:(UIColor *)color andWidth:(CGFloat) borderWidth
{
    CALayer *border = [CALayer layer];
    border.backgroundColor = color.CGColor;
    
    border.frame = CGRectMake(0, 0, borderWidth, self.frame.size.height);
    [self.layer addSublayer:border];
    
    return border;
}

- (CALayer *)addRightBorderWithColor:(UIColor *)color andWidth:(CGFloat) borderWidth
{
    CALayer *border = [CALayer layer];
    border.backgroundColor = color.CGColor;
    
    border.frame = CGRectMake(self.frame.size.width-borderWidth, 0, borderWidth, self.frame.size.height);
    [self.layer addSublayer:border];
    
    return border;
    
}
- (CALayer *)addRoundBorderWithColor:(UIColor *)color andWidth:(CGFloat) borderWidth cornerRadius:(CGFloat)cornerRadius
{
    self.layer.borderWidth = borderWidth;
    self.layer.borderColor = color.CGColor;
    self.layer.cornerRadius = cornerRadius;
    self.clipsToBounds = YES;
    
    return self.layer;
}


- (CALayer *)addBottomY:(CGFloat)y BorderWithColor:(UIColor *)color andHeight:(CGFloat) borderHeight
{
    CALayer *border = [CALayer layer];
    
    if (borderHeight != 0)
    {
        border.backgroundColor = color.CGColor;
        
        border.frame = CGRectMake(0,y, self.frame.size.width, borderHeight);
        [self.layer addSublayer:border];
    }
    
    return border;
}


- (CALayer *)addRightMidBorderWithColor:(UIColor *)color andWidth:(CGFloat) borderWidth
{
    CALayer *border = [CALayer layer];
    border.backgroundColor = color.CGColor;
    
    border.frame = CGRectMake(self.frame.size.width-borderWidth,5, borderWidth, self.frame.size.height-5);
    [self.layer addSublayer:border];
    
    return border;
    
}

- (CALayer *)addRightMidVerifyBorderWithColor:(UIColor *)color andWidth:(CGFloat) borderWidth
{
    CALayer *border = [CALayer layer];
    border.backgroundColor = color.CGColor;
    
    border.frame = CGRectMake(self.frame.size.width-borderWidth,5, borderWidth,44 - 10);
    [self.layer addSublayer:border];
    
    return border;
    
}


- (CALayer *)addNavBarBottomBorderWithColor:(UIColor *)color andWidth:(CGFloat) borderWidth
{
    CALayer *border = [CALayer layer];
    
    if (borderWidth != 0)
    {
        border.backgroundColor = color.CGColor;
        border.frame = CGRectMake(0, self.frame.size.height-borderWidth-1, self.frame.size.width, borderWidth);
        [self.layer addSublayer:border];
    }
    
    return border;
}

- (CALayer *)addBorderY:(CGFloat)y WithColor:(UIColor *)color andHeight:(CGFloat) andHeight
{
    CALayer *border = [CALayer layer];
    border.backgroundColor = color.CGColor;
    
    border.frame = CGRectMake(0,y, self.frame.size.width,andHeight);
    [self.layer addSublayer:border];
    
    return border;
    
}

- (CALayer *)addBorderY:(CGFloat)y leftX:(CGFloat)leftX WithColor:(UIColor *)color andHeight:(CGFloat) andHeight
{
    CALayer *border = [CALayer layer];
    border.backgroundColor = color.CGColor;
    
    border.frame = CGRectMake(leftX,y, self.frame.size.width - leftX*2,andHeight);
    [self.layer addSublayer:border];
    
    return border;
    
}


- (CALayer *)addLeftCodeBorderWithColor:(UIColor *)color andWidth:(CGFloat) borderWidth
{
    CALayer *border = [CALayer layer];
    border.backgroundColor = color.CGColor;
    
    border.frame = CGRectMake(0,5, borderWidth, self.frame.size.height - 10);
    [self.layer addSublayer:border];
    
    return border;
}
@end

@implementation UIView (Corner)

- (void)applyCircleCorner
{
    self.layer.cornerRadius = self.width/2;
    self.layer.masksToBounds = YES;
}


- (void)viewRadiusWithRadius:(CGFloat)radius corner:(UIRectCorner)corner radiusViewBounds:(CGRect)radiusViewBounds{
    
//    CGRect f = radiusViewFrame;
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:radiusViewBounds byRoundingCorners:corner cornerRadii:CGSizeMake(radius,radius)];
    //创建 layer
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = radiusViewBounds;
    //赋值
    maskLayer.path = maskPath.CGPath;
    self.layer.mask = maskLayer;
}



@end
