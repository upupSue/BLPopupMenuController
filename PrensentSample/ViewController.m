//
//  ViewController.m
//  PrensentSample
//
//  Created by BroadLink on 2017/6/19.
//  Copyright © 2017年 方琼蔚. All rights reserved.
//

#import "ViewController.h"
#import "BLPopupMenuController.h"
#import "TestTableViewCell.h"

@interface ViewController (){
    UIButton *obutton;
    UIButton *tbutton;
    UIButton *thbutton;
    UIButton *fbutton;
}
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    obutton = [UIButton buttonWithType:UIButtonTypeCustom];
    obutton.frame = CGRectMake(10, 30, 100, 30);
    [obutton setTitle:@"弹出" forState:UIControlStateNormal];
    [obutton addTarget:self action:@selector(obuttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    obutton.backgroundColor = [UIColor grayColor];
    [self.view addSubview:obutton];
    
    tbutton = [UIButton buttonWithType:UIButtonTypeCustom];
    tbutton.frame = CGRectMake(200, 30, 100, 30);
    [tbutton setTitle:@"弹出" forState:UIControlStateNormal];
    [tbutton addTarget:self action:@selector(tbuttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    tbutton.backgroundColor = [UIColor grayColor];
    [self.view addSubview:tbutton];
    
    thbutton = [UIButton buttonWithType:UIButtonTypeCustom];
    thbutton.frame = CGRectMake(10, 300, 100, 30);
    [thbutton setTitle:@"不可选 自定义cell" forState:UIControlStateNormal];
    [thbutton addTarget:self action:@selector(thbuttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    thbutton.backgroundColor = [UIColor grayColor];
    [self.view addSubview:thbutton];
    
    fbutton = [UIButton buttonWithType:UIButtonTypeCustom];
    fbutton.frame = CGRectMake(200, 300, 100, 30);
    [fbutton setTitle:@"不可选 自定义cell 大小起始" forState:UIControlStateNormal];
    [fbutton addTarget:self action:@selector(fbuttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    fbutton.backgroundColor = [UIColor grayColor];
    [self.view addSubview:fbutton];
}

- (void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBar.hidden=YES;
}

- (void)obuttonClicked:(UIButton *)btn
{
    BLPopupMenuController *bbVC = [BLPopupMenuController popupMenuControllerWithPreferredStyle:BLPopupMenuControllerStyleSelected];
    bbVC.selectedIndex = 1;
    bbVC.startPoint = CGPointMake(10, 64 + 10);
    [bbVC addAction:[BLPopupAction actionWithTitle:@"lllllllllllllllll" handler:^(BLPopupAction * _Nonnull action) {
        NSLog(@"my home");
    }]];
    [bbVC addAction:[BLPopupAction actionWithTitle:@"哈哈哈哈或或或或" handler:^(BLPopupAction * _Nonnull action) {
        NSLog(@"my office");
    }]];
    [bbVC addAction:[BLPopupAction actionWithTitle:@"哈哈哈哈或或或hh或" handler:^(BLPopupAction * _Nonnull action) {
        NSLog(@"my home");
    }]];
    [bbVC addAction:[BLPopupAction actionWithTitle:@"nnnnnnnnnnnnnnnaa" handler:^(BLPopupAction * _Nonnull action) {
        NSLog(@"my office");
    }]];
    [bbVC addAction:[BLPopupAction actionWithTitle:@"nnnnnnnnnnnnnnnal" handler:^(BLPopupAction * _Nonnull action) {
        NSLog(@"my home");
    }]];
    [bbVC addAction:[BLPopupAction actionWithTitle:@"我的" handler:^(BLPopupAction * _Nonnull action) {
        NSLog(@"my office");
    }]];
    [bbVC addAction:[BLPopupAction actionWithTitle:@"my" handler:^(BLPopupAction * _Nonnull action) {
        NSLog(@"my home");
    }]];
    [bbVC addAction:[BLPopupAction actionWithTitle:@"我的" handler:^(BLPopupAction * _Nonnull action) {
        NSLog(@"my office");
    }]];
    [bbVC addAction:[BLPopupAction actionWithTitle:@"create" handler:^(BLPopupAction * _Nonnull action) {
        NSLog(@"create new office");
    }]];
    [self presentViewController:bbVC animated:YES completion:nil];
}

- (void)tbuttonClicked:(UIButton *)btn
{
    BLPopupMenuController *bbVC = [BLPopupMenuController popupMenuControllerWithPreferredStyle:BLPopupMenuControllerStyleDefault origin:CGPointMake([UIScreen mainScreen].bounds.size.width - 10, 44 + 20 + 10)];
    
    [bbVC addAction:[BLPopupAction actionWithTitle:@"设置起始lalalladad" handler:^(BLPopupAction * _Nonnull action) {
        NSLog(@"属性");
    }]];
    [bbVC addAction:[BLPopupAction actionWithTitle:@"设置大小" handler:^(BLPopupAction * _Nonnull action) {
        NSLog(@"设置");
    }]];
    [bbVC addAction:[BLPopupAction actionWithTitle:@"不能勾选" handler:^(BLPopupAction * _Nonnull action) {
        NSLog(@"设置");
    }]];
    [self presentViewController:bbVC animated:YES completion:nil];

}

- (void)thbuttonClicked:(UIButton *)btn
{
    BLPopupMenuController *bbVC = [BLPopupMenuController popupMenuControllerWithPreferredStyle:BLPopupMenuControllerStyleDefault cellClassName:NSStringFromClass([TestTableViewCell class]) cellHeight:30];
    bbVC.startPoint = CGPointMake(10, 350);
    [bbVC addAction:[BLPopupAction actionWithTitle:@"不可勾选" handler:^(BLPopupAction * _Nonnull action) {
        NSLog(@"my home");
    }]];
    [bbVC addAction:[BLPopupAction actionWithTitle:@"自定义cell" handler:^(BLPopupAction * _Nonnull action) {
        NSLog(@"my office");
    }]];
    [bbVC addAction:[BLPopupAction actionWithTitle:@"设置起始(10, 350)" handler:^(BLPopupAction * _Nonnull action) {
        NSLog(@"my office");
    }]];
    [bbVC addAction:[BLPopupAction actionWithTitle:@"没有固定按钮" handler:^(BLPopupAction * _Nonnull action) {
        NSLog(@"my office");
    }]];
    [self presentViewController:bbVC animated:YES completion:nil];
}

- (void)fbuttonClicked:(UIButton *)btn
{
    BLPopupMenuController *bbVC = [BLPopupMenuController popupMenuControllerWithPreferredStyle:BLPopupMenuControllerStyleDefault origin:CGPointMake(250, 300) cellClassName:NSStringFromClass([TestTableViewCell class]) cellHeight:70];
    bbVC.separatorColor = [UIColor blueColor];
    [bbVC addAction:[BLPopupAction actionWithTitle:@"nnnnnnnnnnnnn" handler:^(BLPopupAction * _Nonnull action) {
        NSLog(@"my home");
    }]];
    [bbVC addAction:[BLPopupAction actionWithTitle:@"自定义cell" handler:^(BLPopupAction * _Nonnull action) {
        NSLog(@"my office");
    }]];
    [bbVC addAction:[BLPopupAction actionWithTitle:@"cell高度100" handler:^(BLPopupAction * _Nonnull action) {
        NSLog(@"create new office");
    }]];
    [bbVC addAction:[BLPopupAction actionWithTitle:@"contentSize(300, 800)" handler:^(BLPopupAction * _Nonnull action) {
        NSLog(@"my home");
    }]];
    [bbVC addAction:[BLPopupAction actionWithTitle:@"CGPointMake(250, 300)" handler:^(BLPopupAction * _Nonnull action) {
        NSLog(@"my office");
    }]];
    [bbVC addAction:[BLPopupAction actionWithTitle:@"没有固定按钮没有" handler:^(BLPopupAction * _Nonnull action) {
        NSLog(@"my office");
    }]];
    [self presentViewController:bbVC animated:YES completion:nil];
}

@end
