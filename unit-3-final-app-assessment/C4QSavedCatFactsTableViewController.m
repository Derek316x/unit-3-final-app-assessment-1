//
//  C4QSavedCatFactsTableViewController.m
//  unit-3-final-app-assessment
//
//  Created by Z on 12/19/15.
//  Copyright © 2015 Michael Kavouras. All rights reserved.
//

#import "C4QSavedCatFactsTableViewController.h"

@interface C4QSavedCatFactsTableViewController ()

@end

@implementation C4QSavedCatFactsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.savedFacts = [[NSUserDefaults standardUserDefaults] objectForKey:@"saved"];
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.savedFacts.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SavedFactCellID" forIndexPath:indexPath];
    
    NSString *savedFactString = [self.savedFacts objectAtIndex:indexPath.row];
    cell.textLabel.text = savedFactString;
    
    // Configure the cell...
    
    return cell;
}

@end
