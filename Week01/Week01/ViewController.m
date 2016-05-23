//
//  ViewController.m
//  Week01
//
//  Created by Lucas Campos on 5/23/16.
//  Copyright © 2016 Lucas Campos. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}
- (IBAction)onTapped:(UISwitch *)sender {
    if ([sender isOn]) {
        self.label.text = @"On";
    } else {
        self.label.text = @"Off";
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
