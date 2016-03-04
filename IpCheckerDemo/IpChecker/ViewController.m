//
//  ViewController.m
//  IpChecker
//
//  Created by yebaojia on 16/3/4.
//  Copyright (c) 2016年 mjia. All rights reserved.
//

#import "ViewController.h"
#import "IpChecker.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [IpChecker checkIp];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
