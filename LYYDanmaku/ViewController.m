//
//  ViewController.m
//  LYYDanmaku
//
//  Created by lieyunye on 1/25/16.
//  Copyright © 2016 lieyunye. All rights reserved.
//

#import "ViewController.h"
#import "LYYDanmakuView.h"

@interface ViewController ()
{
    UIButton *_pauseBtn;
    UIButton *_resumeBtn;
    LYYDanmakuView *_danmakuView;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
     _danmakuView = [[LYYDanmakuView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:_danmakuView];
    
    
    _pauseBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 100, 100, 100)];
    [self.view addSubview:_pauseBtn];
    _pauseBtn.backgroundColor = [UIColor yellowColor];
    [_pauseBtn addTarget:self action:@selector(pauseAction) forControlEvents:UIControlEventTouchUpInside];
    
    _resumeBtn = [[UIButton alloc] initWithFrame:CGRectMake(210, 100, 100, 100)];
    [self.view addSubview:_resumeBtn];
    _resumeBtn.backgroundColor = [UIColor greenColor];
    
    [_resumeBtn addTarget:self action:@selector(resumeAction) forControlEvents:UIControlEventTouchUpInside];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)resumeAction
{
    [_danmakuView resumeTracks];
}

- (void)pauseAction
{
    [_danmakuView pauseTracks];

}

@end
