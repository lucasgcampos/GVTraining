//
//  DetailTVCTableViewController.h
//  GVTraining04
//
//  Created by Lucas Campos on 6/21/16.
//  Copyright © 2016 Guichê Virtual. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailTVCTableViewController : UITableViewController
@property (nonatomic, strong) NSDictionary<NSString *, NSString *>*selected;
@property (nonatomic, strong) NSMutableArray<NSString *> *keys;
@end
