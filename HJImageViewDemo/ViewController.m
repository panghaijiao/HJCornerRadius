//
//  ViewController.m
//  HJImageViewDemo
//
//  Created by haijiao on 16/3/8.
//  Copyright © 2016年 olinone. All rights reserved.
//

#import "ViewController.h"
#import "HJCornerRadius.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        cell.imageView.contentMode = UIViewContentModeScaleAspectFill;
        cell.imageView.aliCornerRadius = 10.0f;
        
        UIImageView *imageView1 = [[UIImageView alloc] initWithFrame:CGRectMake(100, 5, 50, 50)];
        imageView1.image = [UIImage imageNamed:@"1"];
        imageView1.aliCornerRadius = 10.0f;
        cell.accessoryView = imageView1;
    }
    
    cell.imageView.image = [UIImage imageNamed:@"2"];
    cell.accessoryView.contentMode = UIViewContentModeScaleAspectFill;
    
    return cell;
}

@end
