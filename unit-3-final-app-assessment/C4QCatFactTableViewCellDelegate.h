#import <Foundation/Foundation.h>
#import "C4QCatFactTableViewCell.h"

@class C4QCatFactTableViewCell;

@protocol C4QCatFactTableViewCellDelegate <NSObject>

- (void)catFactTableViewCelldidSaveFact:(C4QCatFactTableViewCell *)catCell ;

@end