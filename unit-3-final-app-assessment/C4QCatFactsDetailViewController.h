//
//  C4QCatFactDetailViewController.h
//  unit-3-final-app-assessment
//
//  Created by Michael Kavouras on 12/18/15.
//  Copyright © 2015 Michael Kavouras. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIImage+animatedGIF.h"

@interface C4QCatFactsDetailViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIImageView *catImageView;
@property (weak, nonatomic) IBOutlet UILabel *catFactLabel;
@property (nonatomic) NSString *factToShow;



@end
