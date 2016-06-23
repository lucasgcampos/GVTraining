//
//  DetailTVCTableViewController.m
//  GVTraining04
//
//  Created by Lucas Campos on 6/21/16.
//  Copyright © 2016 Guichê Virtual. All rights reserved.
//

#import "DetailTVCTableViewController.h"

@interface DetailTVCTableViewController ()

@end

@implementation DetailTVCTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.keys = [[NSMutableArray alloc] init];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    for (NSString *key in self.selected.allKeys) {
        [self.keys addObject:key];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.selected.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DetailCell"];
    
    
    cell.textLabel.text = [self.keys objectAtIndex:indexPath.row];
//    cell.detailTextLabel.text = ;
    
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@", self.selected[[self.keys objectAtIndex:indexPath.row]]];
    
//    if ([self.selected[[self.keys objectAtIndex:indexPath.row]] isKindOfClass:[NSString class]]) {
//        cell.detailTextLabel.text = self.selected[[self.keys objectAtIndex:indexPath.row]]?:@"";
//    }
    return cell;
}

@end
