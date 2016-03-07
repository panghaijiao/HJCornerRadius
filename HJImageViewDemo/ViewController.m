//
//  ViewController.m
//  HJImageViewDemo
//
//  Created by haijiao on 16/3/8.
//  Copyright © 2016年 olinone. All rights reserved.
//

#import "ViewController.h"
#import "HJImageView.h"

@interface ViewController ()

@property (nonatomic, weak) IBOutlet UIImageView *imageView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.imageView.cornerRadius = 10.0f;
}

@end
