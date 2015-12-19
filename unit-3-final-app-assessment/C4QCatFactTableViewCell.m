//
//  C4QCatFactTableViewCell.m
//  unit-3-final-app-assessment
//
//  Created by Z on 12/19/15.
//  Copyright © 2015 Michael Kavouras. All rights reserved.
//

#import "C4QCatFactTableViewCell.h"

@implementation C4QCatFactTableViewCell

- (IBAction)catFactButtonTapped:(UIButton *)sender {
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    //no facts have ever been saved
    if([defaults objectForKey:@"saved"] == nil){
        NSArray *savedFacts = [[NSArray alloc] initWithObjects:self.catFactLabel.text, nil];
        [defaults setObject:savedFacts forKey:@"saved"];
    }
    
    //ensure that fact tapped has not been saved before
    NSArray *savedFacts = [defaults objectForKey:@"saved"];
    BOOL savedBefore = NO;
    for (NSString *fact in savedFacts){
        if ([fact isEqualToString:self.catFactLabel.text]) {
            savedBefore = YES;
            break;
        }
    }
    
    //save new fact
    if (savedBefore == NO) {
        NSArray *newSavedFacts = [savedFacts arrayByAddingObject:self.catFactLabel.text];
        [defaults setObject:newSavedFacts forKey:@"saved"];
        
        [defaults synchronize];
        
        //call delegate method
        [self.delegate catFactTableViewCelldidSaveFact:self];
    }
    
}

@end
