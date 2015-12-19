//
//  C4QCatsTableViewController.m
//  unit-3-final-assessment
//
//  Created by Michael Kavouras on 12/17/15.
//  Copyright © 2015 Michael Kavouras. All rights reserved.
//

#import "C4QCatFactsTableViewController.h"
#import <AFNetworking/AFNetworking.h>
#import "C4QCatFactTableViewCell.h"
#import "C4QCatFactTableViewCellDelegate.h"
#import "C4QCatFactsDetailViewController.h"
#import "C4QCatFactsDetailViewController.h"

#define CAT_API_URL @"http://catfacts-api.appspot.com/api/facts?number=100"

@interface C4QCatFactsTableViewController () <C4QCatFactTableViewCellDelegate>

@property (nonatomic) NSInteger selectedIndexPathRow;

@end

@implementation C4QCatFactsTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.selectedIndexPathRow = 0;
    
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 44.0; // set to whatever your "average" cell height is
    
    UINib *nib = [UINib nibWithNibName:@"C4QCatFactTableViewCell" bundle:nil];
    [[self tableView] registerNib:nib forCellReuseIdentifier:@"C4QCatCellIdentifier"];
    
    
    [self getCatFactsFromAPIWithCallbackBlock:^{
        [self.tableView reloadData];
    }];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.catFacts.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    C4QCatFactTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"C4QCatCellIdentifier"];
    cell.delegate = self;
    
    if (!cell) {
        [self.tableView registerNib:[UINib nibWithNibName:@"C4QCatFactTableViewCell"  bundle:nil]forCellReuseIdentifier:@"C4QCatCellIdentifier"];
    }
    
    cell.catFactLabel.text = [self.catFacts objectAtIndex:indexPath.row];
    [cell.catFactButton setImage:[UIImage imageNamed:@"add_icon"] forState:UIControlStateNormal];
    
    //check if the fact displayed in the cell has been saved before
    NSArray *savedFacts = [[NSUserDefaults standardUserDefaults] objectForKey:@"saved"];
    
    if (savedFacts != nil) {
        for (NSString *fact in savedFacts) {
            if ([fact isEqualToString:cell.catFactLabel.text]) { //saved before
                [cell.catFactButton setImage:[UIImage imageNamed:@"Checkmark-32"] forState:UIControlStateNormal];
            }
        }
    }
    
    return cell;
}

#pragma mark - Navigation

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    self.selectedIndexPathRow = indexPath.row;
    
    [self performSegueWithIdentifier:@"DetailSegueID" sender:self];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    if ([segue.identifier  isEqual: @"DetailSegueID"]) {
        C4QCatFactsDetailViewController *detailVC = segue.destinationViewController;
        
        detailVC.factToShow = [self.catFacts objectAtIndex:self.selectedIndexPathRow];
        NSLog(@"detailVC.factToShow = %@",detailVC.factToShow);
    }
}


#pragma mark - API
//AFNetworking 2.0

-(void)getCatFactsFromAPIWithCallbackBlock:(void(^)())block{
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    [manager GET:@"http://catfacts-api.appspot.com/api/facts?number=100" parameters:nil progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        
        //NSLog(@"JSON: %@", responseObject);
        NSDictionary *catJSON = responseObject;
        
        self.catFacts = [catJSON objectForKey:@"facts"];
        
        block();
        
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
    
}

#pragma mark - Saving cat fact delegate

-(void)catFactTableViewCelldidSaveFact:(C4QCatFactTableViewCell *)catCell{
    [self.tableView reloadData];
    
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Saved"
                                                                   message:@"New cat fact saved!"
                                                            preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                          handler:^(UIAlertAction * action) {}];
    
    [alert addAction:defaultAction];
    [self presentViewController:alert animated:YES completion:nil];
}

@end
