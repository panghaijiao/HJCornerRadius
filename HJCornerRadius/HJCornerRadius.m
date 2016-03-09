//
//  HJCornerRadius.m
//  HJImageViewDemo
//
//  Created by haijiao on 16/3/10.
//  Copyright © 2016年 olinone. All rights reserved.
//

#import "HJCornerRadius.h"
#import <objc/runtime.h>

@interface UIImage (cornerRadius)

@property (nonatomic, assign) CGFloat aliCornerRadius;

@end

@implementation UIImage (cornerRadius)

- (CGFloat)aliCornerRadius {
    return [objc_getAssociatedObject(self, @selector(aliCornerRadius)) floatValue];
}

- (void)setAliCornerRadius:(CGFloat)aliCornerRadius {
    objc_setAssociatedObject(self, @selector(aliCornerRadius), @(aliCornerRadius), OBJC_ASSOCIATION_COPY_NONATOMIC);
}

@end

/////////////////////////////////////////////////////////////////////
@interface HJImageObserver : NSObject

@property (nonatomic, assign) UIImageView *originImageView;
@property (nonatomic, assign) CGFloat cornerRadius;

- (instancetype)initWithImageView:(UIImageView *)imageView;

@end

@implementation HJImageObserver

- (void)dealloc {
    [self.originImageView removeObserver:self forKeyPath:@"image" context:(__bridge void *)(self)];
}

- (instancetype)initWithImageView:(UIImageView *)imageView{
    if (self = [super init]) {
        self.originImageView = imageView;
        [imageView addObserver:self forKeyPath:@"image" options:NSKeyValueObservingOptionNew context:(__bridge void *)(self)];
    }
    return self;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString*, id> *)change context:(void *)context {
    if ([keyPath isEqualToString:@"image"] && context == (__bridge void *)(self)) {
        UIImage *newImage = change[@"new"];
        if (![newImage isKindOfClass:[UIImage class]] || newImage.aliCornerRadius > 0) {
            return;
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [self updateImageView];
        });
    }
}

- (void)setCornerRadius:(CGFloat)cornerRadius {
    if (_cornerRadius == cornerRadius) {
        return;
    }
    _cornerRadius = cornerRadius;
    if (_cornerRadius > 0) {
        [self updateImageView];
    }
}

- (void)updateImageView {
    if (!self.originImageView.image) {
        return;
    }
    
    UIGraphicsBeginImageContextWithOptions(self.originImageView.bounds.size, NO, [UIScreen mainScreen].scale);
    CGContextRef currnetContext = UIGraphicsGetCurrentContext();
    CGContextAddPath(currnetContext, [UIBezierPath bezierPathWithRoundedRect:self.originImageView.bounds cornerRadius:self.cornerRadius].CGPath);
    CGContextClip(currnetContext);
    [self.originImageView.layer renderInContext:currnetContext];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    if ([image isKindOfClass:[UIImage class]]) {
        image.aliCornerRadius = self.cornerRadius;
        self.originImageView.image = image;
    }
}

@end

/////////////////////////////////////////////////////////////////////
@implementation UIImageView (HJCornerRadius)

- (CGFloat)aliCornerRadius {
    return [self imageObserver].cornerRadius;
}

- (void)setAliCornerRadius:(CGFloat)aliCornerRadius {
    [self imageObserver].cornerRadius = aliCornerRadius;
}

- (HJImageObserver *)imageObserver {
    HJImageObserver *imageObserver = objc_getAssociatedObject(self, @selector(imageObserver));
    if (!imageObserver) {
        imageObserver = [[HJImageObserver alloc] initWithImageView:self];
        objc_setAssociatedObject(self, @selector(imageObserver), imageObserver, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return imageObserver;
}

@end
