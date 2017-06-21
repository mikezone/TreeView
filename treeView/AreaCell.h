//
//  TableViewCell.h
//  treeView
//
//  Created by Mike on 16/7/20.
//  Copyright © 2016年 Mike. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AreaModel.h"

@protocol AreaCellDelegate;

@interface AreaCell : UITableViewCell

@property (nonatomic, strong) AreaModel *model;
@property (nonatomic, weak) id<AreaCellDelegate> delegate;

@end

@protocol AreaCellDelegate <NSObject>

- (void)areaCell:(AreaCell *)areaCell didClickedOnCheckBoxImageView:(UIImageView *)checkBoxImageView;

@end
