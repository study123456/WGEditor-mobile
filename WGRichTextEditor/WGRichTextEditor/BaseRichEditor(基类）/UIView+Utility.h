//
//  UIView+Utility.h
//  DGUtilityKit
//
//  Created by Jinxiao on 4/11/13.
//  Copyright (c) 2013 debugeek. All rights reserved.
//

@interface UIView (Size)

@property (nonatomic) CGFloat left;
@property (nonatomic) CGFloat top;
@property (nonatomic) CGFloat right;
@property (nonatomic) CGFloat bottom;


@property (nonatomic) CGFloat width;
@property (nonatomic) CGFloat height;


@property (nonatomic) CGFloat centerX;
@property (nonatomic) CGFloat centerY;

@end

@interface UIView (Dynamic)

- (UIImage *)snapshotImage;

@end


@interface UIView (FirstResponder)

- (id)firstResponder;

@end


@interface UIView (Border)

- (CALayer *)addTopBorderWithColor:(UIColor *)color andWidth:(CGFloat) borderWidth;
- (CALayer *)addTopBorderWithColor:(UIColor *)color width:(CGFloat) borderWidth left:(CGFloat)borderLeft;
- (CALayer *)addBottomBorderWithColor:(UIColor *)color andWidth:(CGFloat) borderWidth;
- (CALayer *)addBottomBorderWithColor:(UIColor *)color width:(CGFloat) borderWidth left:(CGFloat)borderLeft;
- (CALayer *)addLeftBorderWithColor:(UIColor *)color andWidth:(CGFloat) borderWidth;
- (CALayer *)addRightBorderWithColor:(UIColor *)color andWidth:(CGFloat) borderWidth;
- (CALayer *)addRoundBorderWithColor:(UIColor *)color andWidth:(CGFloat) borderWidth cornerRadius:(CGFloat)cornerRadius;
- (CALayer *)addBottomX:(CGFloat)x BorderWithColor:(UIColor *)color andWidth:(CGFloat) borderWidth;

- (CALayer *)addBorderY:(CGFloat)y leftX:(CGFloat)leftX WithColor:(UIColor *)color andHeight:(CGFloat) andHeight;

- (CALayer *)addBottomY:(CGFloat)y BorderWithColor:(UIColor *)color andWidth:(CGFloat) borderWidth;

- (CALayer *)addBottomY:(CGFloat)y BorderWithColor:(UIColor *)color andHeight:(CGFloat) borderHeight;

- (CALayer *)addRightMidBorderWithColor:(UIColor *)color andWidth:(CGFloat) borderWidth;

- (CALayer *)addTopFromBorderWithColor:(UIColor *)color andWidth:(CGFloat) borderWidth;

- (CALayer *)addNavBarBottomBorderWithColor:(UIColor *)color andWidth:(CGFloat) borderWidth;

- (CALayer *)addRightMidVerifyBorderWithColor:(UIColor *)color andWidth:(CGFloat) borderWidth;

- (CALayer *)addBorderY:(CGFloat)y WithColor:(UIColor *)color andHeight:(CGFloat) andHeight;

- (CALayer *)addLeftCodeBorderWithColor:(UIColor *)color andWidth:(CGFloat) borderWidth;
@end

@interface UIView (Corner)

- (void)applyCircleCorner;
- (void)viewRadiusWithRadius:(CGFloat)radius
                      corner:(UIRectCorner)corner
             radiusViewBounds:(CGRect)radiusViewBounds;
@end
