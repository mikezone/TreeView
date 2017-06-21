//
//  Model.m
//  treeView
//
//  Created by Mike on 16/7/20.
//  Copyright © 2016年 Mike. All rights reserved.
//

#import "MKTreeViewModel.h"

@implementation MKTreeViewModel

#pragma mark - return model in `dataArray` according to `row`

+ (instancetype)modelAtRow:(NSUInteger)row inArray:(NSArray *)dataArray{
    NSUInteger currentIndex = 0;
    for (NSUInteger i = 0; i < dataArray.count; i++) {
        MKTreeViewModel *modelInner = [self modelWithBeginModel:dataArray[i] forRow:row currentIndex:&currentIndex];
        if (modelInner) {
            return modelInner;
        } else {
            continue;
        }
    }
    return nil;
}

+ (MKTreeViewModel *)modelWithBeginModel:(MKTreeViewModel *)model forRow:(NSUInteger)row currentIndex:(NSUInteger *)currentIndex {
    if (model) {
        if (row == *currentIndex) {
            return model;
        }
        *currentIndex = *currentIndex + 1;
        if (model.expanded && model.childModelArray) {
            for (MKTreeViewModel *innerModel in model.childModelArray) {
                MKTreeViewModel *willReturnModel = [self modelWithBeginModel:innerModel forRow:row currentIndex:currentIndex];
                if (willReturnModel) {
                    return willReturnModel;
                } else {
                    continue;
                }
            }
        } else {
            return nil;
        }
    }
    return nil;
}

#pragma mark - calculate rowCount according to model and its sonModel in modelArray

+ (NSUInteger)rowCountForModelArray:(NSArray *)modelArray {
    NSUInteger count = 0;
    for (MKTreeViewModel *model in modelArray) {
        [self countWithBeginModel:model count:&count];
    }
    return count;
}

+ (void)countWithBeginModel:(MKTreeViewModel *)model count:(NSUInteger *)count {
    if (model) {
        (*count)++;
        if (model.expanded && model.childModelArray) {
            for (MKTreeViewModel *innerModel in model.childModelArray) {
                [self countWithBeginModel:innerModel count:count];
            }
        } else {
            return;
        }
    }
}

#pragma mark -

- (void)setCheckFatherInModelArray:(NSArray *)dataArray {
    MKTreeViewModel *fatherModel = [self fatherModelInModelArray:dataArray];
    MKTreeViewModel *model = self;
    while (fatherModel) {
        if (!model.isChecked) {
            fatherModel.isChecked = NO;
        } else {
            BOOL allSelected = YES;
            for (NSUInteger i = 0; i < fatherModel.childModelArray.count; i++) {
                MKTreeViewModel *innerModel = fatherModel.childModelArray[i];
                if (!innerModel.isChecked) {
                    allSelected = NO;
                    break;
                }
            }
            fatherModel.isChecked = allSelected;
        }
        model = fatherModel;
        fatherModel = [model fatherModelInModelArray:dataArray];
    }
}

- (MKTreeViewModel *)fatherModelInModelArray:(NSArray *)dataArray {
    MKTreeViewModel *fatherModel = nil;
    if ([dataArray containsObject:self]) {
        fatherModel = nil;
    } else {
        for (NSUInteger i =0; i < dataArray.count; i++) {
            MKTreeViewModel *innnerModel = dataArray[i];
            [self fatherModel:&fatherModel currentModel:innnerModel];
            if (fatherModel) {
                return fatherModel;
            } else {
                continue;
            }
        }
    }
    return nil;
}

- (void)fatherModel:(MKTreeViewModel **)fatherModel currentModel:(MKTreeViewModel *)currentModel {
    if ([currentModel.childModelArray containsObject:self]) {
        *fatherModel = currentModel;
        return;
    }
    for (NSUInteger i = 0; i < currentModel.childModelArray.count; i++) {
        MKTreeViewModel *innerModel = currentModel.childModelArray[i];
        [self fatherModel:fatherModel currentModel:innerModel];
        if (*fatherModel != nil) {
            return;
        } else {
            continue;
        }
    }
}
#pragma mark - 

- (void)setCheckChild {
    if (self.childModelArray) {
        for (MKTreeViewModel *innerModel in self.childModelArray) {
            innerModel.isChecked = self.isChecked;
            [innerModel setCheckChild];
        }
    } else {
        return;
    }
}

#pragma mark -

- (void)allExpandedChildCount:(NSUInteger *)count {
    if (self.expanded && self.childModelArray) {
        for (MKTreeViewModel *innerModel in self.childModelArray) {
            (*count)++;
            [innerModel allExpandedChildCount:count];
        }
    } else {
        return;
    }
}

@end
