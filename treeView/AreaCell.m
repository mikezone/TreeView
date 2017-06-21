//
//  TableViewCell.m
//  treeView
//
//  Created by Mike on 16/7/20.
//  Copyright © 2016年 Mike. All rights reserved.
//

#import "AreaCell.h"

@interface AreaCell ()

@property (weak, nonatomic) IBOutlet UIImageView *checkBoxImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constraintCheckBoxLeadingToSuperView;

@end

@implementation AreaCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self.checkBoxImageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapOnCheckBoxImageView:)]];
}

- (void)setModel:(AreaModel *)model {
    _model = model;
    _constraintCheckBoxLeadingToSuperView.constant = 10 + model.level * 30.f;
    self.nameLabel.text = model.name;
    if (model.isChecked) {
        self.checkBoxImageView.image = [UIImage imageNamed:@"f_hs_activities_-approval_batch_choose_pressed"];
    } else {
        self.checkBoxImageView.image = [UIImage imageNamed:@"f_hs_activities_-approval_batch_choose"];
    }
}

- (void)tapOnCheckBoxImageView:(UITapGestureRecognizer *)sender {
    if ([self.delegate respondsToSelector:@selector(areaCell:didClickedOnCheckBoxImageView:)]) {
        [self.delegate areaCell:self didClickedOnCheckBoxImageView:self.checkBoxImageView];
    }
}

@end
