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

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50.0f;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        cell.imageView.contentMode = UIViewContentModeScaleAspectFill;
//        cell.imageView.layer.cornerRadius = 10.0f;
//        cell.imageView.layer.masksToBounds = YES;
        cell.imageView.aliCornerRadius = 10.0f;
        
        UIImageView *imageView1 = [[UIImageView alloc] initWithFrame:CGRectMake(100, 0, 50, 50)];
        imageView1.image = [UIImage imageNamed:@"1"];
        [cell.contentView addSubview:imageView1];
        
//        imageView1.aliCornerRadius = 10.0f;
        
//        imageView1.layer.cornerRadius = 10.0f;
//        imageView1.layer.masksToBounds = YES;
    }
    
    cell.imageView.image = [UIImage imageNamed:@"1"];
    
    return cell;
}

@end
