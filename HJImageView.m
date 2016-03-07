//
//  HJImageView.m
//  HJImageView
//
//  Created by haijiao on 16/3/8.
//  Copyright © 2016年 olinone. All rights reserved.
//

#import "HJImageView.h"
#import <objc/runtime.h>

////////////////////////////////////////////////////////////////////////
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
    if ([keyPath isEqualToString:@"image"] && context != (__bridge void *)(self)) {
        [self updateImageView];
    }
}

- (void)setCornerRadius:(CGFloat)cornerRadius {
    if (_cornerRadius == cornerRadius) {
        return;
    }
    _cornerRadius = cornerRadius;
    [self updateImageView];
}

- (void)updateImageView {
    UIGraphicsBeginImageContextWithOptions(self.originImageView.bounds.size, false, [UIScreen mainScreen].scale);
    CGContextRef currnetContext = UIGraphicsGetCurrentContext();
    CGContextAddPath(currnetContext, [UIBezierPath bezierPathWithRoundedRect:self.originImageView.bounds cornerRadius:self.cornerRadius].CGPath);
    CGContextClip(currnetContext);
    [self.originImageView.layer renderInContext:currnetContext];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    self.originImageView.image = image;
}

@end

@implementation UIImageView (cornerRadius)

- (CGFloat)cornerRadius {
    return [self imageObserver].cornerRadius;
}

- (void)setCornerRadius:(CGFloat)cornerRadius {
    self.layer.cornerRadius = cornerRadius;
    [self imageObserver].cornerRadius = cornerRadius;
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
