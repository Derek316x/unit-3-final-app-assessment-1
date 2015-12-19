//
//  C4QCatFactTableViewCell.h
//  unit-3-final-app-assessment
//
//  Created by Z on 12/19/15.
//  Copyright © 2015 Michael Kavouras. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "C4QCatFactTableViewCellDelegate.h"

@interface C4QCatFactTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *catFactLabel;
@property (weak, nonatomic) IBOutlet UIButton *catFactButton;

@property (nonatomic, weak) id<C4QCatFactTableViewCellDelegate>delegate;


@end
