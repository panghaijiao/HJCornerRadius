//
//  ViewController.m
//  HJImageViewDemo
//
//  Created by haijiao on 16/3/8.
//  Copyright © 2016年 olinone. All rights reserved.
//

#import "ViewController.h"
#import "HJCornerRadius.h"
#import <SDWebImage/UIImageView+WebCache.h>

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
        cell.imageView.image = [UIImage imageNamed:@"2"];
        
        UIImageView *imageView1 = [[UIImageView alloc] initWithFrame:CGRectMake(100, 5, 50, 50)];
        imageView1.contentMode = UIViewContentModeScaleAspectFill;
        imageView1.aliCornerRadius = 25.0f;
        cell.accessoryView = imageView1;
    }
    
    NSString *url = nil;
    switch (indexPath.row % 3) {
        case 0:
            url = @"http://pic24.nipic.com/20121022/1417516_151626862000_2.jpg";
            break;
        case 1:
            url = @"http://img3.doubanio.com/view/commodity_review/large/public/p200907257.jpg";
            break;
        default:
            url = @"http://pic26.nipic.com/20130114/9252150_140310235330_2.jpg";
            break;
    }
    
    [(UIImageView *)cell.accessoryView sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:@"1"]];
    
    return cell;
}

@end
